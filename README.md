# Create EC2 Instance with Terraform

## Steps to Perform / Resource Blocks

1. **Create VPC** - `aws_vpc`  
    - Set `cidr_block`

2. **Create Internet Gateway** - `aws_internet_gateway`  
    - Attach to VPC using `vpc_id`

3. **Create Subnet** - `aws_subnet`  
    - Set `cidr_block`  
    - Attach to VPC using `vpc_id`  
    - Set `map_public_ip_on_launch = true`  
    - ⚠️ *Do not associate with a route table if subnet needs to be private*

4. **Create Route Table** - `aws_route_table`  
    - Attach to VPC using `vpc_id`  
    - Add routing via Internet Gateway using:
      - `route.cidr_block`
      - `route.gateway_id`

5. **Create Route Table Association**  
    - Use `route_table_id`  
    - Use `subnet_id`

6. **Create Security Group** - `aws_security_group`  
    - **Ingress Rules**:
      - `ingress.from_port`, `ingress.to_port`, `ingress.protocol`, `ingress.cidr_blocks`
    - **Egress Rules**:
      - `egress.from_port`, `egress.to_port`, `egress.protocol`, `egress.cidr_blocks`

7. **Create EC2 Instance** - `aws_instance`  
    - Attach to subnet  
    - Select AMI  
    - Choose instance type

---

## Terraform Commands

```bash
terraform init
terraform plan
terraform apply
terraform apply -auto-approve
terraform plan -var="created_by=Ravikant" -var="ami-0f918f7e67a3323f0"
terraform apply --auto-approve -var-file=test.tfvars
terraform plan -var-file=test.tfvars

```
## Note
- No default variable value passed
- If you don't pass variable input via cli or file, it will ask you to enter when you run terraform plan or terraform apply
- Demonstrated with validation as well to 
    * added length validation, that should be minimum 4 character length
    * add validation, ami must start with "ami-"



