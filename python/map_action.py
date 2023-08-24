from typing import Any, Dict

def _handle_create_request(customer_name: str) -> None:
    # do something related to create
    return

def _handle_activate_request(customer_name: str) -> None:
    # do something related to activate
    return

def _handle_suspend_request(customer_name: str) -> None:
    # do something related to suspend
    return

def _handle_delete_request(customer_name: str) -> None:
    # do something related to delete
    return

ACTION_MAPPING = {
    "create": _handle_create_request,
    "activate": _handle_activate_request,
    "suspend": _handle_suspend_request,
    "delete": _handle_delete_request,
}

def function_handler(request: Dict[str, Any]) -> None:
    action = request.get("action")
    customer_name = request.get("customer")
    # validate input
    _handle_request(action, customer_name)

def _handle_request(action: str, customer_name: str) -> None:
    action_handler = ACTION_MAPPING.get(action)
    # handle action
    action_handler(customer_name)

