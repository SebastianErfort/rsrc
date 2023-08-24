#!/usr/bin/python3
# See https://docs.python.org/3/library/argparse.html

import argparse

# Generic argument parser. Can be used as a blueprint for more specific parsers using the `parents`
# option, specific_parser = argparse.ArgumentParser(parents=[generic_parser])
generic_parser = argparse.ArgumentParser(description='This is a program')
generic_parser.add_argument('-v', '--verbose', dest='verbose', default=False, help='Verbose mode, '
                            +'extended output', action='store_true')
generic_parser.add_argument('-t', '--test', dest='test'   , default=False, help='Test specified '
                            +'component, no actual changes', action='store_true')
generic_parser.add_argument('-n', '--dry', dest='dry'   , default=False, help='Dry run simulating'
                            +'program behavior, no actual changes', action='store_true')
args = generic_parser.parse_args()

if __name__=='__main__':
    generic_parser.print_help()
    print('Arguments:\n',args)
