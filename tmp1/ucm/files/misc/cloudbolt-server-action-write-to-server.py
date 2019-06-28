path='/etc/puppetlabs/code/environments/production/hieradata'
serverName=$(hostname -f)
fileName="${path}/${serverName}.json"

#create path to file if it does not already exist
mkdir -p $path

#write given os Config value to file
#writes over any value that already exists
cat <<'EOF' > $fileName
    {{osConfig}}
EOF
