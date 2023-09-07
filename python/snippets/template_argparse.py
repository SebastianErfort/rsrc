#!/usr/bin/python3

import argparse

examples='''
examples:
  First example
    <program name> -a arg1 arg2 arg3 ...
'''
argparser = argparse.ArgumentParser(prog='<program name>', description='<Program description>',
                                    epilog=examples,
                                    formatter_class=argparse.RawTextHelpFormatter)
argparser.add_argument('-v', dest='verbose', default=False, help='Verbose mode, extended output.',
                       action='store_true')
argparser.add_argument('-q', dest='quiet', default=False, help='Quiet mode, no output.',
                       action='store_true')
argparser.add_argument('-f', dest='force', default=False, help='Force-run, no questions asked.',
                       action='store_true')
argparser.add_argument('-y', dest='yes', default='n',
                       help='Answer non-critical interactive prompts mode with yes.',
                       action='store_true')
argparser.add_argument('-a', '--add', dest='new', default=['first'],
                       help='Add new, options are: ...', nargs='+')
argparser.add_argument('-t', '-n', dest='test', default=False, help='Simulate run, no actual changes.',
                       action='store_true')
argparser.add_argument
 
progargs = argparser.parse_args()

print(progargs.verbose)
print(progargs.test)
