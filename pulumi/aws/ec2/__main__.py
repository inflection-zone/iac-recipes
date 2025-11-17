from commons import vpc, ec2_instance
import values

VPC = vpc(values)
EC2 = ec2_instance(values, VPC)
