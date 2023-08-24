#!/usr/bin/python3
def is_something(refstring,matchstr='criterion'):
  '''Test whether string refstring contains string matchstr'''
  return True if refstring.find(matchstr)>=0 else False

# Test
print(is_something('criterion met?')) # should be true
print(is_something('fail')) # should be false
