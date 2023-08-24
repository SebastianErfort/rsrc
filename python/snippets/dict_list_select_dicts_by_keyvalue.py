#!/usr/bin/python3
# NOTE Bit of an obscure application
def list_items_in_dict(d: dict, list_dict_key: str, return_key: str, select_key: str,
                       select_value: str) -> list:
  '''In diconary d, select list of dictionaries list_dict and return values for key return_key where
  select_key matches select_value.'''

  return [i[return_key] for i in d[list_dict_key] if i[select_key] == select_value]

 
# Example
d = {'name': 'inventory',
  'items': [
    {'name': 'apples',       'type': 'fruit', 'number': 5},
    {'name': 'strawberries', 'type': 'fruit', 'number': 20},
    {'name': 'courgette',    'type': 'vegetable', 'number': 2},
    {'name': 'almonds',      'type': 'nut',   'number': 7}
  ]
}
l = list_items_in_dict(d, 'items', 'type', 'name', 'fruit')
print(l)
l = list_items_in_dict(d, 'items', 'type', 'name', 'nut')
print(l)

