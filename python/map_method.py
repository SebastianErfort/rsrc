#!/usr/bin/pyhton3
# Adapted from https://isenberg-ran.medium.com/reduce-your-python-code-complexity-with-this-simple-trick-7046b7c54e7a
# I doubt even the original code will run òÓ
method_map = {
  'init': _init,
  'activate': _activate,
  'clean': _clean,
}

def method_handler(request: dict) -> None:
  action = request.get('action')
  instance_name = request.get('instance')
  # validate input
  _handle_request(action,instance_name)

def _handle_request(action: str, instance_name: str) -> None:
  action_handler = method_map.get(action)
  # handle action
  action_handler(instance_name)

def _init(instance_name: str) -> None:
  # initalise
  # ...
  return

def _activate(instance_name: str) -> None:
  # activate
  # ...
  return

def _clean(instance_name: str) -> None:
  # clean
  # ...
  return

