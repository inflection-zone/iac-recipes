resource_group_properties = {
    "rg-name": "vm-resource-group",
    "rg-location": "Central India"
}

vnet_properties = {
    "vnet-name": "vm-vnet",
    "vnet-address-prefixes": ["10.1.0.0/16"],
    "vnet-public-subnet-count": 1,
    "vnet-subnet-names": ["vm-vnet-subnet"]
}

virtual_machine_properties = {
    "public-ip-name": "vm-public-ip",
    "public-ip-allocation-method": "Static",

    "network-security-group-name": "vm-nsg",

    "network-interface-name": "vm-nic",
    "network-interface-ip-configuration-name": "vm-ip-configuration",

    "virtual-machine-vm-name": "vm",
    "virtual-machine-vm-size": "Standard_B1s",
    "virtual-machine-vm-os-profile-computer-name": "vm",
    "virtual-machine-vm-os-profile-admin-username": "",
    "virtual-machine-vm-os-profile-admin-password": "",
    "virtual-machine-vm-custom-data-file-path" : "../../../startup-configs/ubuntu/docker.tpl",

    "virtual-machine-vm-storage-profile-os-disk-create-option": "FromImage",
    "virtual-machine-vm-storage-profile-os-disk-storage-account-type": "Standard_LRS",

    "virtual-machine-vm-storage-profile-image-reference-publisher": "Canonical",
    "virtual-machine-vm-storage-profile-image-reference-offer": "0001-com-ubuntu-server-jammy",
    "virtual-machine-vm-storage-profile-image-reference-sku": "22_04-lts",
    "virtual-machine-vm-storage-profile-image-reference-version": "latest",
}
