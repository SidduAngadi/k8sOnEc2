module "jump_box" {
    source = "git@github.com:SidduAngadi/terraform_modules.git//auto-scaling-group?ref=v0.0.1"

    env_name = "dev"
    resource_static_name = "jumpBox"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
    template_file = "${path.cwd}/user_data.tpl"
    subnets = data.terraform_remote_state.vpc.outputs.public_subnet_ids
    max_size = 1
    min_size = 1

}

module "sec_group" {
    source = "git@github.com:SidduAngadi/terraform_modules.git//security_grp_rules?ref=v0.0.1"
    
    security_group_id = module.jump_box.security_group_id
    security_group_rules = {
        # type = from_port,to_port,protocol,cidr_blocks 
        1 = "egress,0,0,-1,0.0.0.0/0"
    }
}