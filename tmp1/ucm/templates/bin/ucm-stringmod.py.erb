#!/usr/bin/python

import argparse, sys, re, fileinput
parser = argparse.ArgumentParser(description='Regex replacer script called specifically by UCM strmod type.')
parser.add_argument("-d", "--delete", dest="method", help="The method for parse content in your file, use 'contains', 'startswith', 'endswith', or 'delete'.", action="store")
parser.add_argument("-m", "--method", dest="method", help="The method for parse content in your file, use 'contains', 'startswith', 'endswith', or 'delete'.", action="store")
parser.add_argument("-f", "--filepath", dest="filepath", help="The file to read and modify", action="store")
parser.add_argument("-s", "--search", dest="search", help="Expression or string used to find the given line or part of string in file.", action="store")
parser.add_argument("-sh", "--shouldbe", dest="shouldbe", help="String content used to replace the given line or part of string in file.", action="store")
parser.add_argument("-u", "--update", dest="update", help="Provide either 'all' or 'first'.  Updates all instances of the match or just the first.", action="store")
parser.add_argument("-r", "--replace", dest="replace", help="Provide either 'string' or 'line'.  Replace the entire line containing the matched string or just the part of the line that matches.", action="store")

args      = parser.parse_args()
v_method  = args.method
v_file    = args.filepath
v_search  = args.search
v_should  = args.shouldbe
v_update  = args.update
v_replace = args.replace


def modstring(f_file, f_method, f_search, f_should, f_update, f_replace):
  f_should_end       = f_should + '\n'
  f_search_end       = f_search + '\n'
  f_should_line      = f_should_end 
  f_should_null_line = "" + '\n' 

  if f_should == 'deleted': 
    f_should     = ""
    f_should_end = f_should.strip()
   
  with open(f_file) as editfile:
    matched = False
    match   = False
       
    for line in editfile:
      if f_search in line:
        if f_method == 'startswith':
          if line.startswith(f_search):
            matched = True
            match   = line
            break
        elif f_method == 'endswith':
          if line.endswith(f_search_end):
            matched = True
            match   = line
            break
        elif f_method == 'contains':
          if f_search in line: 
            matched = True
            match   = line
            break
        elif f_method == 'delete':
          pass
        else: 
          print "Please use one of methods 'startswith', 'endswith', 'contains', or 'delete'"
          sys.exit(1)

  if matched:
    print "Found match that", f_method, f_search 

    with open(f_file) as editfile:
      if f_replace == 'line': 
        # 2019.6.6 this entire stanza for "first" + "line" works as expected.
        if f_update == 'first':
          # match will = the line found according to the method given, so if method = startswith match will = the first line found that "starts with" the given search string.
          # we know match = the first match found because we break after finding the first match for each method condutional check
          stringsub = editfile.read().replace(match, f_should_end)
               
          with open(f_file, "w") as editfile:
            editfile.write(stringsub)    
            
        elif f_update == 'all':
          with open(v_file) as f:
            if f_method == 'startswith':
              for line in fileinput.input(f_file, inplace=True):
                if line.startswith(f_search):
                  line = f_should + '\n'
                sys.stdout.write(line)          
               
            if f_method == 'endswith':
              for line in fileinput.input(f_file, inplace=True):
                if line.endswith(f_search_end):
                  line = f_should + '\n'
                sys.stdout.write(line)          
                 
            if f_method == 'contains':
              for line in fileinput.input(f_file, inplace=True):
                if f_search in line:
                  line = f_should + '\n'
                sys.stdout.write(line)          
                 
      elif f_replace == 'string':
        if f_update == 'first':
          line = match.replace(f_search, f_should)
          stringsub = editfile.read().replace(match, line)

          with open(f_file, "w") as editfile:
            editfile.write(stringsub)

        elif f_update == 'all':
          with open(v_file) as f:
            if f_method == 'startswith':
              for line in fileinput.input(f_file, inplace=True):
                if line.startswith(f_search):
                  line = line.replace(f_search, f_should)
                sys.stdout.write(line)

            if f_method == 'endswith':
              for line in fileinput.input(f_file, inplace=True):
                if line.endswith(f_search_end):
                  line = line.replace(f_search, f_should)
                sys.stdout.write(line)

            if f_method == 'contains':
              for line in fileinput.input(f_file, inplace=True):
                if f_search in line:
                  line = line.replace(f_search, f_should)
                sys.stdout.write(line)
      else:
        pass
  else:
    print "didn't find string:", f_search, "appending:", f_should  
    with open(f_file,'ab') as editfile:
      editfile.write(f_should)
      sys.exit(0)
    # print "Did not find a match for:", f_search
    # sys.exit(1)
        

modstring(v_file, v_method, v_search, v_should, v_update, v_replace)

