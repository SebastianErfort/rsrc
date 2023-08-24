# For type dict_keys
from collections import KeysView
d = {'1': 1}
def keys(d: dict[str, int]) -> KeysView[str]:
    return d.keys()
