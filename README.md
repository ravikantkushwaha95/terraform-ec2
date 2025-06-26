Create EC2 instance 

Steps to perform or write resource block
1. Create VPC - aws_vpc
    a. enter cidr range - cidr_block
2. Create Internet Gateway - aws_internet_gateway
    a. Attach VPC - vpc_id
3. Create subnet - aws_subnet
    a. enter cidr range - cidr_block
    b. attach vpc id - vpc_id
    c. make map_public_ip_on_launch = true
    c. Note - do not associate with route table if subnet need to be in private
4. Create route table - aws_route_table
    a. Attach VPC - vpc_id
    b. Add routing with IGW - route.cidr_block & route.gateway_id
5. Create route table association - 
    a. select route table id - route_table_id
    b. select subnet id - subnet_id
6. Create Security Group - aws_security_group
    a. enter ingress
        i. ingress.from_port, ingress.to_port, ingress.protocol, ingress.cidr_block
        ii. egree.from_port, egress.to_port, egress.protocol, egree.cidr_block
    b. enter egree
7. Create EC2 instance - aws_instance
    a. Attach subnet
    b. select ami 
    c. select type



-------------- COMMANDS ------------
terraform init
terraform plan
terraform apply
terraform apply -auto-approve
terraform plan -var="created_by=Ravikant" -var="ami-0f918f7e67a3323f0"
terraform apply --auto-approve -var-file=test.tfvars


terraform plan -var-file=test.tfvars


---------- NOTES ------
- No default variable value passed
- If you don't pass variable input via cli or file, it will ask you to enter when you run terraform plan or terraform apply
- Demonstrated with validation as well to 
    * added length validation, that should be minimum 4 character length
    * add validation, ami must start with "ami-"



