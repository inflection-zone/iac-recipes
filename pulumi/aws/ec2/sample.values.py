vpc_properties = {
    "vpc-name": "pulumi-ec2-vpc",
    "vpc-igw-name": "pulumi-ec2-vpc-igw",
    "vpc-public-rt-name": "pulumi-ec2-vpc-public-rt",
    "vpc-private-rt-name": "pulumi-ec2-vpc-private-rt",
    "vpc-public-subnet-name": "pulumi-ec2-vpc-public-subnet",
    "vpc-private-subnet-name": "pulumi-ec2-vpc-private-subnet",
}

ec2_properties = {
    # Instance settings
    "ec2-instance-name": "pulumi-ec2-instance",
    "ec2-instance-type": "t2.micro",
    "ec2-ami-id": "ami-02b8269d5e85954ef",

    # Key Pair
    "ec2-keypair-name": "pulumi-ec2-key-pair",
    "ec2-keypair-path": ".ssh/server/id_server.pub",

    # User data
    "ec2-user-data-file-path": "../../../startup-configs/ubuntu/docker.tpl",

    # Security group name
    "ec2-security-group-name": "pulumi-ec2-sg",

    # Allowed inbound ports
    "ec2-allowed-ports": [
        {"port": 22,  "description": "SSH"},
        {"port": 80,  "description": "HTTP"},
        {"port": 443, "description": "HTTPS"},
    ],

    # Elastic IP
    "ec2-eip-name": "pulumi-ec2-eip",
}
