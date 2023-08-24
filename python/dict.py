#!/usr/bin/env python3

# initialise/declare dictionary
d = {}

# simple assignment
d['one']   = 'a'
d['two']   = 'b'
d['three'] = 'c'
print(d)

# remove/delete item by key
d.pop('two')
print(d)
# TODO remove/delete by value

d2 = {'four': 'd', 'six': 'f'}

# update/merge dictionary
d.update(d2)
print(d)

# access keys
print(d.keys())
# access values
print(d.values())

# iterate/loop over items
# keys only
# equivalent to
# for k in d.keys():
for k in d:
    print(k)
# values
for v in d.values():
    print(v)
# key-value pairs
for k,v in d.items():
    print(k, " -> ", v)

# find item with max/min value for certain key in list of dictionaries with common key
prices = [{'name': 'apples', 'price': 1}, {'name': 'strawberries', 'price': 3}, {'name': 'watermelon', 'price': 5}]
print("prices:",prices)
print(f"highest price: {max(prices, key=lambda x:x['price'])}")
print(f"lowest price: {min(prices, key=lambda x:x['price'])}")
