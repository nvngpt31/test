#!/bin/bash

  source /etc/environment
  PATH=$NEWPATH

  echo "Content-type: text/html"
  echo ""
  echo '<html>'
  echo '<head>'
  echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
  echo '<title>UCM Depoy</title>'
  echo '</head>'
  echo '<body>'

  thisnode="`hostname -f`"                tpdhost="${thisnode}"                 mainpage='cgi-bin/tpd/mainpage.cgi'
  mainret="http://${tpdhost}/${mainpage}" thispage='cgi-bin/tpd/ucm-deploy.cgi' self="http://${thisnode}/${thispage}"
  msg_main="Return to Mainpage"

  echo '<br>'
  echo "<h4>Unity CM Deploy</h4>"
  echo "<form method=GET action="${self}">"\
  echo '<table nowrap>'\
         '<tr><td>Data Module Name</TD><TD><input type="text" name="name" size=12></td></tr>'\
         '<tr><td>SSH Git Url</TD><TD><input type="text" name="giturl" size=12></td></tr>'\
         '<tr><td>Branch</TD><TD><input type="text" name="branch" size=12></td></tr>'\
         '</tr></table>'
  echo '<br><input type="submit" value="Deploy">'\
           '</form>'

  if [ -z "$QUERY_STRING" ]
  then  exit 0
  else
    raw_modname=`echo "$QUERY_STRING" | sed -n 's/^.*name=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
    raw_url=`echo "$QUERY_STRING" | sed -n 's/^.*giturl=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
    raw_branch=`echo "$QUERY_STRING" | sed -n 's/^.*branch=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`

    name="`echo $raw_modname | sed 's/\%3A/:/g ; s/\%2F/\//g ; s/\%40/\@/g'`"
    url="`echo $raw_url | sed 's/\%3A/:/g ; s/\%2F/\//g ; s/\%40/\@/g'`"
    branch="`echo $raw_branch | sed 's/\%3A/:/g ; s/\%2F/\//g ; s/\%40/\@/g'`"

    echo '<br>'
    echo "RUNNING UCM DEPLOY NOW..."
    echo '<br>'
    echo "name   = $name"
    echo '<br>'
    echo "sshurl = $url"
    echo '<br>'
    echo "branch = $branch"
    echo '<br>'
    echo "<pre>"
    sudo /usr/local/bin/ucm-git $name $branch $url null production > /tmp/ucm-puppet-git-deploy-for-${name}.txt
    echo '<br>'
    echo "<pre>"
    cat /tmp/ucm-puppet-git-deploy-for-${name}.txt
    echo "<pre>"
    echo '<br>'
  fi
echo '</body>'
echo '</html>'
exit 0

