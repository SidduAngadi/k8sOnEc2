module "controlPanel" {
    source = "../../../terraform_modules/auto-scaling-group"

    env_name = "dev"
    resource_static_name = "controlPanel"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
    template_file = "${path.cwd}/user_data.tpl"
    subnets = data.terraform_remote_state.vpc.outputs.private_subnet_ids

}

module "sec_group" {
    source = "../../../terraform_modules/security_grp_rules"
    security_group_id = module.controlPanel.security_group_id
    security_group_rules = {
        # type = from_port,to_port,protocol,cidr_blocks 
        1 = "egress,0,0,-1,0.0.0.0/0"
    }
}

module "sec_group_ssh" {
    source = "../../../terraform_modules/security_grp_rules"
    for_each = toset(data.terraform_remote_state.vpc.outputs.public_cidr_block)
    security_group_id = module.controlPanel.security_group_id
    security_group_rules = {
        # index = type,from_port,to_port,protocol,cidr_blocks 
        1 = "ingress,22,22,tcp,${each.key}"
    }
}