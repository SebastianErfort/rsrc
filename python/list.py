#!/usr/bin/env python3

# initialise/declare list
l = []

# add items
l += 'a'
l.append('b') # for scalar arguments append will concatenate
print(l)
l2 = [3, 4]
l.append(l2) # append will add entire list, not concatenate
print(l)
l += l2 # this will concatenate
print(l)

# remove/delete item by value
l.remove('b')
print(l)
# remove/delete item by index
l.pop(-1)

# access items
print("item with index 2:", l[2])
print("item with index 1 from back:", l[-1])
# invert list
print(l[::-1])

# Methods
# NOTE methods such as sort will change the list in-place and not return a new list
