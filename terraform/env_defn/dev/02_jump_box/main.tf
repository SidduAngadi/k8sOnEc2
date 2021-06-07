module "jump_box" {
    source = "../../../terraform_modules/auto-scaling-group"

    env_name = "dev"
    resource_static_name = "jumpBox"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
    template_file = "${path.cwd}/user_data.tpl"
    subnets = data.terraform_remote_state.vpc.outputs.public_subnet_ids
    max_size = 1
    min_size = 1

}

module "sec_group" {
    source = "../../../terraform_modules/security_grp_rules"
    security_group_id = module.jump_box.security_group_id
    security_group_rules = {
        # type = from_port,to_port,protocol,cidr_blocks 
        1 = "egress,0,0,-1,0.0.0.0/0"
    }
}