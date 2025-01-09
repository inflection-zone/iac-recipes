from commons import resource_group, vnet, virtual_machine
import values

RESOURCE_GROUP = resource_group(values)
VNET = vnet(values, RESOURCE_GROUP)
VM = virtual_machine(values, RESOURCE_GROUP, VNET)