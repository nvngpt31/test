#!/bin/bash

################################################################################
## admigr.ksh - Migrate Linux host from legacy to hierarchical zone            #
################################################################################
## TD Ameritrade Security and Access Engineering
## Last modified 2018/07/05
################################################################################
## Usage
# Runs with no options:
#    # ./admigr.ksh
#         * Default zone is Unix
#         * Default domain is the currently joined domain.
#         * Defaut container is based on the domain
# Run with options, options override env variables:
#    # ./admigr.ksh [ -z zone ] [ -d domain ]
# Backout, options override env variables:
#    # ./admigr.ksh -b [ -z zone ] [ -d domain ] [ -c container ]
# A note about order of options.
#    -d will also set the container based on the zone. If you want to override
#       the container you must specify -c after -d.
#    -b will reset zone, domain, and container based on the saved state file.
#       To override the settings in the saved state, -z, -d, and -c must be used
#       after -b.
################################################################################
## Exit codes
#  1 - run as non-root
#  2 - improper options
#  3 - save state failed
#  4 - adleave failed
#  6 - destination and current container match
#  Script exits with adjoin exit code
################################################################################
## Process/algorithm overview
#   adleave - exit current domain
#   Create a local emergency user
#   adjoin - join new hierarchial domain
#   Remove pam.allow.groups entry from centrifydc.conf
#   Remove sudo and replace with a sym link to dzdo
#   Restart centrifydc service
#   adflush - Flush AD cache
#   Validate with adinfo --test
################################################################################

## Container from Domain mapping
## prod-am -> OU=Computers,OU=Unix,DC=prod-am,DC=ameritrade,DC=com
## clientsys -> OU=Computers,OU=Unix,DC=clientsys,DC=local
## iteclientsys -> OU=Computers,OU=Unix,DC=iteclientsys,DC=local
## pte-am -> OU=Computers,OU=Unix,DC=pte-am,DC=ameritrade,DC=com

# Self set vars
export PATH='/bin:/sbin:/usr/bin:/usr/sbin'
SCRIPT=`basename $0`


# Vars
ADJOINacct='zUnixADJoin'
ADJOINpass='t479788a1!'
SUDO='/usr/bin/sudo'
DZDO='/usr/bin/dzdo'
DCCONFIG='/etc/centrifydc/centrifydc.conf'
JOINTRIES=3

BAKTIME=$(date +%Y%m%d-%H%M)

LOGFILE=/var/log/rbac.log.${BAKTIME}
SAVESTATE=/var/log/rbac.savestate

# Functions
err () {
   echo ${SCRIPT}: ${1} 1>&2
   exit $2
}
warn () {
   echo ${SCRIPT}: ${1} 1>&2
}
d2c () {
   # Calculate container from domain
   echo "OU=Computers,OU=Unix,DC=$(echo ${DOMAIN} | sed -e 's/\./,DC=/g')"
}

# Step 0 - verify running as root
if [ `whoami` != "root" ] ; then
   err "Must be run as root" 1 
fi

#ZONE="${ZONE:-Unix}"
#DOMAIN="${DOMAIN:-iteclientsys.local}"
#CONTAINER="${CONTAINER:-OU=Computers,OU=Unix,DC=iteclientsys,DC=local}"


# Now gets settings from command line so command line overrides and environment vars
ZONE="Unix"
OLDDOMAIN=`adinfo -d`; DOMAINEC=$?
DOMAIN="${OLDDOMAIN}"
CONTAINER="$(d2c ${DOMAIN})"
BACKOUT="no"
LOCALUSER="no"
REGISTER="no"
DID=$(cat /etc/deploymentid.halo 2>/dev/null)
FORCE="no"
while getopts ":z:d:c:blfu:p:" option; do
   case ${option} in
    z) ZONE="${OPTARG}";;
    u) ADJOINacct="${OPTARG}";;
    p) ADJOINpass="${OPTARG}";;
    d) DOMAIN="${OPTARG}"
       CONTAINER="$(d2c ${DOMAIN})"
       ;;
    c) CONTAINER="${OPTARG}";;
    l) LOCALUSER="yes";;
    f) FORCE="yes";;
    b) BACKOUT="yes"
       if [ -r ${SAVESTATE} ] ; then
          . ${SAVESTATE}
       else
          warn "No save state found - ensure zone, domain, and container are properly set for backout."
       fi
       ;;
    \?|:)
       echo "Usage: ${SCRIPT} [ -b ] [ -z zone ] [ -d domain ] [ -c container ]"

       exit 2
       ;;
   esac
done
case ${DOMAIN} in
   "prod-am.ameritrade.com"|"clientsys.local"|"iteclientsys.local"|"pte-am.ameritrade.com") true;;
   *) err "invalid domain '${DOMAIN}'. Valid domains are prod-am.ameritrade.com,clientsys.local,iteclientsys.local,pte-am.ameritrade.com." 2;;
esac

# Start logging
echo "Logging to ${LOGFILE}"
echo ""
{

   # echo out status
   echo "AD Migration - destination:"
   echo "    ZONE:          ${ZONE}"
   echo "    DOMAIN:        ${DOMAIN}"
   echo "    CONTAINER:     ${CONTAINER}"
   echo ""

   # Save state for backout

   # b.create a local account for backup in case of issues
   # c.adleave current zone
   # confirm current zone is legacy zone
   if [ $DOMAINEC == "10" ] ; then
      echo "    OLD ZONE:      Not joined to a domain"
      echo "    OLD DOMAIN:    Not joined to a domain"
      echo "    OLD CONTAINER: Not joined to a domain"
   else
      OLDZONE=`adinfo -z`; ZONEEC=$?
      OLDCONTAINER=$(adinfo -V 2>&1 | awk -F"`hostname|cut -d . -f1`," '/Found computer account:/ {print $2;exit}')
      echo "    OLD ZONE:      ${OLDZONE}"
      echo "    OLD DOMAIN:    ${OLDDOMAIN}"
      echo "    OLD CONTAINER: ${OLDCONTAINER}"
      if [ \
               "X$(basename ${OLDZONE})" == "X${ZONE}" \
            -a "X${OLDDOMAIN}" == "X${DOMAIN}" \
            -a "X${OLDCONTAINER}" == "X${CONTAINER}" \
         ] ; then
            if [ "X${FORCE}" == "Xno" ] ; then
               err "Current config matches migrated config - migration aborted." 6
            else
               warn "Current config matches migrated config - migration forced."
            fi
      fi
      if [ -f ${SAVESTATE} ] ; then
         echo "Saved state file already exists - skipping."
      else
         echo -n "Writing to savestate file ${SAVESTATE}..."
         if printf "ZONE=\"${OLDZONE}\"\nDOMAIN=\"${OLDDOMAIN}\"\nCONTAINER=\"${OLDCONTAINER}\"" > ${SAVESTATE} ; then
            echo "Succeeded."
         else
            echo "Failed."
            err "Write to savestate failed." 3
         fi
      fi
      ULSEGID=$( getent group ulse | awk -F: '{print $3}' )
      [ 0${ULSEGID} -lt 5 ] && ULSEGID=9005

      echo "Begin adleave: adleave -u ${ADJOINacct} -p XXXXXX"
      adleave -u ${ADJOINacct} -p ${ADJOINpass} 2>&1 | paste /dev/null - ; ADLEAVEEC=${PIPESTATUS[0]}
      echo "...adleave complete with status ${ADLEAVEEC}."
      if [ ${ADLEAVEEC} != 0 ] ; then
         err "adleave failed. Unable to continue." 4
      fi
   fi
   if [ "X${LOCALUSER}" = "Xyes" ] ; then
      echo "Creating a local emergency account"
      egrep -q '^ulse:' /etc/group || groupadd -g ${ULSEGID} ulse && \
      useradd -c 'RBHA Emergency Service Account' -g ${ULSEGID} -M -N -r \
         -p '$6$sm6LV6RS$7COoyl.fb8dFHGIn99LDqg7/OM/SX7FK2Jihdo4uzXPkbOzcxztPqHtOuh2xXyM0YRARbhcxiUjHX.B58AykF1' rbhaulse
      [ ! -f /etc/sudoers.d/ulse ] && cat << EOF > /etc/sudoers.d/ulse
#
# %ulse team is allowed to root access
#
%ulse   ALL=(ALL)   ALL
EOF
   fi

   # d.join to new Unix hierarchical zone 
   adjointry=0; ADJOINEC=-1
   while (( ${ADJOINEC} != 0 && ${adjointry} < ${JOINTRIES} )) ; do
      (( adjointry++ ))
      if (( adjointry > 1 )) ; then sleep 5; fi
      echo "Begin adjoin try ${adjointry}: adjoin --verbose --force -u ${ADJOINacct} -p XXXXXX -c ${CONTAINER} --zone ${ZONE} ${DOMAIN}"
      echo "---------------------------------------------"
      adjoin --verbose --force -u ${ADJOINacct} -p ${ADJOINpass} -c ${CONTAINER} --zone ${ZONE} ${DOMAIN} 2>&1 ; ADJOINEC=${?}
      echo "---------------------------------------------"
      echo "...adjoin complete with status ${ADJOINEC}."
      echo "---------------------------------------------"
   done
   # e.Initialize computer role calling centrify API ( performed by cloudbolt)
   if [ "X${ADJOINEC}" = "X0" ] ; then
      echo "Begin postconfig:"
      if [ "X${BACKOUT}" != "Xyes" ] ; then
         # Back up and alter centrifydc.conf
         echo "   Update ${DCCONFIG}"
         cp ${DCCONFIG} ${DCCONFIG}.${BAKTIME} && \
            sed -s 's/^pam.allow.groups:/#admigr: pam.allow.groups:/' < ${DCCONFIG}.${BAKTIME} > ${DCCONFIG}
         # f.disable sudo binary
         echo "   Remove sudo"
         yum -y remove sudo 2>&1 | paste /dev/null -
         echo "   Replace sudo with dzdo"
         # g.add a symlink for sudo:  sudo -> dzdo
         # Order of this if is important - link will pass both -h and -f tests, so must handle link case first
         if [ -h ${SUDO} ] ; then
            rm ${SUDO}
         elif [ -f ${SUDO} ] ; then
            mv ${SUDO} ${SUDO}.${BAKTIME}
            chmod 0400 ${SUDO}.${BAKTIME}
         fi
         ln -s ${DZDO} ${SUDO}
         # h.remove local account created in step b
      else
         # Back up and alter centrifydc.conf
         echo "   Backout ${DCCONFIG}"
         cp ${DCCONFIG} ${DCCONFIG}.${BAKTIME} && \
            sed -s 's/^#admigr: pam.allow.groups:/pam.allow.groups:/' < ${DCCONFIG}.${BAKTIME} > ${DCCONFIG}
         # Put sudo back
         echo "   Replace dzdo with sudo"
         rm ${SUDO}
         yum -y install sudo 2>&1 | paste /dev/null -
      fi
      echo "   Restart centrifydc"
      if [ -x `which systemctl 2>/dev/null` ] ; then
         systemctl restart centrifydc
      else
         service centrifydc restart
      fi | paste /dev/null -
      echo "...postconfig complete."
      echo "   Flush the cache"
      adflush -f | paste /dev/null -
      echo "...flush complete."
   fi

   echo "Validating..."
   # TODO Consider adding adinfo --diag
   adinfo --test 2>&1 | paste /dev/null - ; ADTESTEC=${PIPESTATUS[0]}
   echo "Validation exited with ${ADTESTEC}."
   echo "Centrify adcheck results:"
   /usr/share/centrifydc/bin/adcheck -a "${DOMAIN}" 2>&1 | paste /dev/null - ; ADCHECKEC=${PIPESTATUS[0]}
   echo "Centrify adcheck completed."

# Close log
} 2>&1 | tee -a ${LOGFILE}

exit ${ADJOINEC}

