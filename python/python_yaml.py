from yaml import load as _yaml_load, dump as _yaml_dump
try:
    from yaml import CLoader as Loader, CDumper as Dumper
except ImportError:
    from yaml import Loader, Dumper

def yaml_load(f):
    return _yaml_load(f, Loader=Loader)

def yaml_dump(d):
    return _yaml_dump(d, Dumper=Dumper)

with open('cfg.yml', 'r') as file:
    cfg = yaml_load(file)

print(cfg['partitions'])
for k in cfg['partitions']:
    print(k)
