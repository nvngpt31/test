#!/usr/bin/python
import argparse, sys, re, fileinput

parser = argparse.ArgumentParser(description='Regex replacer script called specifically by UCM strmod type.')
parser.add_argument("-st", "--startswith", help="Regex Behavior: Will replace entire line after finding match that starts with provided string.", action="store_true")
parser.add_argument("-e", "--endswith", help="Regex Behavior: Will replace entire line after finding match that ends with provided string.", action="store_true")
parser.add_argument("-d", "--delete", help="Regex Behavior: Will delete entire line after finding match.", action="store_true")
parser.add_argument("-s", "--search", dest="search", help="Expression or string used to find the given line or part of string in file.", action="store")
parser.add_argument("-sh", "--shouldbe", dest="shouldbe", help="String content used to replace the given line or part of string in file.", action="store")
parser.add_argument("-f", "--filepath", dest="filepath", help="The file to read and modify", action="store")
parser.add_argument("-u", "--update", dest="update", help="Provide either 'all' or 'first'.  Updates all instances of the match or just the first.", action="store")
parser.add_argument("-r", "--replace", dest="replace", help="Provide either 'string' or 'line'.  Replace the entire line containing the matched string or just the part of the line that matches.", action="store")

# a0

args           = parser.parse_args()
v_search       = args.search
v_should       = args.shouldbe
v_file         = args.filepath
v_up           = args.update
v_repl         = args.replace
v_update_all   = True if v_up == 'all' else False
v_update_first = True if v_up == 'first' else False
v_replace_line = True if v_repl == 'line' else False
v_replace_str  = True if v_repl == 'string' else False
v_startswith   = args.startswith
v_endswith     = args.endswith
v_contains     = True if v_endswith is False and v_startswith is False else False
msg_all_line   = "REPLACING ALL MATCHES WITH GIVEN LINE"
msg_all_str    = "REPLACING ALL MATCHES GIVEN STRING"
msg_fir_line   = "REPLACING FIRST MATCH WITH GIVEN LINE"
msg_fir_str    = "REPLACING FIRST MATCH WITH GIVEN STRING"
msg_bomb       = "DID NOT FIND MATCH FOR:"
msg_st         = "METHOD IS STARTS WITH"
msg_en         = "METHOD IS ENDS WITH"
msg_co         = "METHOD IS CONTAINS"

with open(v_file) as f:
  for line in f:
    if line.startswith(v_search):
      startswith_match = True
      match_startswith = line
      break

with open(v_file) as f:
  with open(v_file) as editfile:
    updatedline = match_startswith.replace(v_search, v_should)
    stringsub = editfile.read().replace(match_startswith, updatedline)
  with open(v_file, "w") as editfile:
    editfile.write(stringsub)
    sys.exit(0)

