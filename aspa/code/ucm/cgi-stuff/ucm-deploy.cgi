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
  tpdhost="${thisnode}"
  mainpage='cgi-bin/tpd/mainpage.cgi'
  mainret="http://${tpdhost}/${mainpage}" thispage='cgi-bin/ucm-deploy.cgi'
  self="http://${thisnode}/${thispage}"
  msg_main="Return to Mainpage"

  echo '<br>'
  echo "<h4>Unity CM Deploy</h4>"
  echo "<form method=GET action="${self}">"\
  echo '<table nowrap>'\
         '<tr><td>SSH Git Url</TD><TD><input type="text" name="giturl" size=12></td></tr>'\
         '<tr><td>Branch</TD><TD><input type="text" name="branch" size=12></td></tr>'\
         '</tr></table>'
  echo '<br><input type="submit" value="Deploy">'\
           '</form>'

  if [ -z "$QUERY_STRING" ]
  then  exit 0
  else
    SSHURL=`echo "$QUERY_STRING" | sed -n 's/^.*giturl=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
    SSHURLCLEAN="`echo $SSHURL   | sed 's/%3A/:/g ; s/%2F/\//g ; s/%40/@/g'`"
    BRANCH=`echo "$QUERY_STRING" | sed -n 's/^.*branch=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
    BRANCHCLEAN="`echo $BRANCH   | sed 's/%3A/:/g ; s/%2F/\//g ; s/%40/@/g'`"

    echo '<br>'
    echo "RUNNING UCM DEPLOY NOW..."
    echo '<br>'
    echo "<pre>"
    echo "... SSHURL: $SSHURLCLEAN"
    echo "... BRANCH: $BRANCHCLEAN"
    # /usr/bin/sudo /usr/local/bin/ucmtest
    # echo "/usr/bin/sudo /usr/local/bin/ucm-git-main $SSHURL $BRANCH "# >/dev/null 2>&1
    /usr/bin/sudo /usr/local/bin/ucm-git-main $SSHURLCLEAN $BRANCHCLEAN # >/dev/null 2>&1
    echo '<br>'
    echo "<pre>"
    # cat /tmp/ucm-deploy-main.txt
    echo "<pre>"
    echo '<br>'
  fi
echo '</body>'
echo '</html>'
exit 0

