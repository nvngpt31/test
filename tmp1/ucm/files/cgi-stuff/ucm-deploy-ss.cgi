#!/bin/bash

  source /etc/environment
  PATH=$NEWPATH

  echo "Content-type: text/html"
  echo ""
  echo '<html>'
  echo '<head>'
  echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
  echo '<title>UCM Depoy SS</title>'
  echo '</head>'
  echo '<body>'

  thisnode="`hostname -f`"                tpdhost="${thisnode}"                    mainpage='cgi-bin/tpd/mainpage.cgi'
  mainret="http://${tpdhost}/${mainpage}" thispage='cgi-bin/tpd/ucm-deploy-ss.cgi' self="http://${thisnode}/${thispage}"
  msg_main="Return to Mainpage"

  echo '<br>'
  echo "<a href="${mainret}"> ${msg_main} </a>"
  echo "<h4>Unity CM Deploy Self Service Environments</h4>"
  echo "<form method=GET action="${self}">"\ 
  echo '<table nowrap>'\
         '<tr><td>Puppet Environment</TD><TD><input type="text" name="env" size=12></td></tr>'\
         '</tr></table>' 
  echo '<br><input type="submit" value="Deploy">'\
           '</form>'

  if [ -z "$QUERY_STRING" ]
  then  exit 0
  else 
    PENVIRONMENT=`echo "$QUERY_STRING" | sed -n 's/^.*env=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`

    if [[ -f /app/ucm.lock ]]
    then
    echo "...ONE SEC, WRAPPING UP A CURRENT JOB"
      while [[ -f /app/ucm.lock ]] ; do 
        sleep .5 >/dev/null 2>&1
      done 
    fi 

    echo "RUNNING FOR:"
    echo '<br>'
    echo '<br>'
    echo "ENVIRONMENT: $PENVIRONMENT "
    echo '<br>'
    echo "RUNNING UCM DEPLOY NOW..."
    echo '<br>'
    sudo /usr/local/bin/ucm-deploy-ss $PENVIRONMENT >/dev/null 2>&1
    echo '<br>' 
    echo "<pre>"
    cat /tmp/env-${PENVIRONMENT}-modules.txt
    echo "<pre>"
    echo '<br>' 
  fi
echo '</body>'
echo '</html>'
exit 0

