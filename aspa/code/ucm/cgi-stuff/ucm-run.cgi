#!/bin/bash

  source /etc/environment
  PATH=$NEWPATH

  echo "Content-type: text/html"
  echo ""
  echo '<html>'
  echo '<head>'
  echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
  echo '<title>UCM Deploy</title>'
  echo '</head>'
  echo '<body>'

  thisnode="prdtxlvpptapp03.associatesys.local"
  thispage='cgi-bin/ucm-run.cgi'
  self="http://${thisnode}/${thispage}"

  echo '<br>'
  echo "<h4>Unity CM Run Agent</h4>"
  echo "<form method=GET action="${self}">"\
  echo '<table nowrap>'\
         '<tr><td>Node</TD><TD><input type="text" name="node" size=12></td></tr>'\
         '</tr></table>'
  echo '<br><input type="submit" value="run">'\
           '</form>'

  if [ -z "$QUERY_STRING" ]
  then  exit 0
  else
    NODE=`echo "$QUERY_STRING" | sed -n 's/^.*node=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
    NODECLEAN="`echo $NODE     | sed 's/%3A/:/g ; s/%2F/\//g ; s/%40/@/g'`"

    echo '<br>'
    # echo "RUNNING SALT > WHICH RUNS PUPPET NOW..."
    echo '<br>'
    echo "<pre>"
    echo "... NODE: $NODECLEAN"
    # /usr/bin/sudo 
    echo '<br>'
    echo "<pre>"
    /usr/bin/sudo /usr/local/bin/ucm-remote-run --server $NODECLEAN 
    # /usr/bin/sudo /usr/bin/salt --async $NODECLEAN state.highstate
    # /usr/bin/sudo -u root /usr/bin/salt --async h0001753.associatesys.local state.highstate
    # cat /tmp/ucm-deploy-main.txt
    echo "<pre>"
    echo '<br>'
  fi
echo '</body>'
echo '</html>'
exit 0

