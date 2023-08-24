#!/usr/bin/python3
# #tags: set, iterable, attribute, utility
# Sets and subsets, see https://realpython.com/python-sets/
def isin(l,*args):
  '''Check whether item(s) args are in l'''
  print(args,len(args))
  if l is None: return False # only here because I was handling variables that could be None
  if len(args) == 1:
    if hasattr(args[0],'__iter__') and not isinstance(args[0], str): # TODO won't work for strings!
      return set(tuple(args[0])).issubset(l)
    else:
      return set((args[0],)).issubset(l) # tuple-ify our one argument
  else:
    return set(args).issubset(l)

l = {1,2,3,4}
print(isin(l,(2,3)))
print(isin(l,2,3,4))
print(isin(l,5))
print(isin(None,3))
l = ['a','b','cd']
print(isin(l,['b','a']))
print(isin(l,'b','a'))
print(isin(l,'cd'))
print(isin(l,'d'))

