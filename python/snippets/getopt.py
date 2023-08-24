#!/usr/bin/python3
# See https://docs.python.org/3/library/getopt.html
# Consider also using argparse module, making things a bit easier

from sys import argv
import getopt

VERBOSE = False
TEST    = False

if len(argv) > 1: # argv[0] is the script name, just like in bash
  opts, args = getopt.getopt(argv[1:],'vt')
  optlist = [o for o,v in opts] # select only options without values
  if '-v' in optlist:
    VERBOSE = True
  if '-t' in optlist:
    TEST = True
print(VERBOSE,TEST)
