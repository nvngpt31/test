

v_method = 'contains'
v_search = '3000'
v_file   = '/tmp/props.txt'

with open(v_file) as readfile:

  found_search = False
  if v_method == 'contains':
    for line in readfile:
      print line
      if v_search in line:
        found_search = True
        break
  else:
    print ""

print "found_search:", found_search

