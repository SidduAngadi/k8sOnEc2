module "vpc" {
    source = "git@github.com:SidduAngadi/terraform_modules.git//vpc_core?ref=v0.0.1"

    env_name = "dev"
    resource_static_name = "siddu"
    
    cidr_block = "10.0.0.0/16"
    private_subnets = {
        "eu-west-1a" = "10.0.0.0/19"
        "eu-west-1b" = "10.0.32.0/19"
        "eu-west-1c" = "10.0.64.0/19"
    }
    public_subnets = {
        "eu-west-1a" = "10.0.96.0/26"
        "eu-west-1b" = "10.0.96.64/26"
        "eu-west-1c" = "10.0.96.128/26"
    }
    enable_nat_gateway = true
    interface_endpoint_service_names = ["ec2"]

    tags = {
        environment = "dev"
    }

}

module "sec_group" {
    source = "../../../modules/security_grp_rules"
    security_group_id = module.vpc.vpce_endpoint_sg_id
    security_group_rules = {
        # type = from_port,to_port,protocol,cidr_blocks 
        1 = "ingress,443,443,tcp,${module.vpc.cidr_block}"
        2 = "egress,443,443,tcp,0.0.0.0/0"
    }
}
