#!/bin/bash

  while (( "$#" ))
  do case $1 in
       -f|--fact)       shift && fact="$1"  ;;
       -v|--value)      shift && value="$1" ;;
       -s|--salt-state) shift && state="$1" ;;
     esac
     shift
  done

  if [[ -z $fact || -z $value || -z $state ]]
  then echo "... please provide -f <FACT NAME> -v <FACT VALUE> -s <SALT STATE>"
       exit 1
  fi

  parent='/etc/puppetlabs/code/ucm'
  workdir="${parent}/cache"
  logdir="${parent}/log/baseline"
  logfilename="${fact}.${value}"
  saltstate='tdaenv'
  subworkdir="${workdir}/.${fact}.${value}.sort" # Turn this on when done testing
  file="${workdir}/${fact}.${value}.txt"
  workfile="${subworkdir}/${fact}.${value}.workingcopy"

  # ---------------------------------------------------------------------------------
  echo ""
  echo "Getting server list from Foreman for nodes that have $fact = $value"
  echo ""
  /usr/local/bin/search-param-to-hosts -p $fact -v $value > $file

  mkdir -p $subworkdir
  cp -p $file $workfile # We'll keep api derived host files around for now

  # Make a file for every 3000 servers
  counter='0'
  while [[ -s $workfile ]]
  do counter="`expr $counter + 1`"
     echo "$workfile is not empty.  Line count = `wc -l ${workfile}`"
     head -3000 $workfile > ${workfile}.${counter}
     for i in `cat ${workfile}.${counter}` ; do sed -i "/${i}/d" ${workfile} ; done
     sed -i '/^\s*$/d' ${workfile}
  done

  rm -f $workfile

  # ---------------------------------------------------------------------------------
  # The following will:
  #  . Iterate through each file
  #  . For each file, pass it to the Salt state command
  #  . Salt will then run the state on 20% of all hosts in the given file at a time until complete
  cp ${logdir}/${fact}.${value}.log ${logdir}/${fact}.${value}.`date +"%A_%b_%e_%Y"_%I_%M_%S_%p`.log
  > ${logdir}/${fact}.${value}.log
  for batchfile in `ls -1 ${subworkdir}`
  do echo "Will work on batch file $batchfile"
     salt --batch-size 10% -L "$(<${subworkdir}/${batchfile})" state.sls $state | tee -a ${logdir}/${fact}.${value}.log
  done

  # Remove cache files 
  rm -rf ${subworkdir}

