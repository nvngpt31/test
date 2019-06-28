# About "p3.yaml" and the "p3/" directory   
Unitl we are off p3 completely, this file is parsed when configuring net new linux builds today.  So long as a server remains on p3, each   
Puppet run will actively apply this data.  

# About all other non p3 yaml files   
All servers upgraded to p5 are in scope of these files.  All data contained within is parsed read-only.  So if a package in the yaml data   
is not installed, it will only report that it is not installed.  There is more documentation on this in Confluence.  

