pipeline {
    agent any
    stages {
        stage('Setup parameters') {
            steps {
                script { 
                    properties([
                      parameters([
                          extendedChoice( 
                              name: 'Terraform_Action', 
                              defaultValue: 'Plan', 
                              description: 'Terraform action to be selected.', 
                              type: 'PT_SINGLE_SELECT',
                              value: 'Plan, Apply, Destroy'
                          ),
                          extendedChoice( 
                              name: 'stages', 
                              defaultValue: '01_network, 02_jump_box, 03_k8s_cluster', 
                              description: 'select stages to deploy', 
                              type: 'PT_MULTI_SELECT',
                              value: '01_network, 02_jump_box, 03_k8s_cluster'
                          )
                      ])
                  ])
                }
            }
        }
    }   
}