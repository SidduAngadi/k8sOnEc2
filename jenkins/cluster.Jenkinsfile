def choice=[]
node {
    choice = params["modules"].split(",")
}

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
                              name: 'modules', 
                              // defaultValue: '01_network, 02_jump_box, 03_k8s_cluster', 
                              description: 'select modules to deploy', 
                              type: 'PT_CHECKBOX',
                              value: '01_network,02_jump_box,03_k8s_cluster',
                              visibleItemCount: 3
                          )
                      ])
                  ])
                }
            }
        }

        stage('01_network'){
          
          when {
            expression { 
                return '01_network' in choice
            }
          }
          steps {
            echo "Executing step 01_network ==================================================="
            def runTerraform(${Terraform_Action}, '01_network')
          }
        }

        stage('02_jump_box'){
          when {
            expression { 
                return '02_jump_box' in choice
            }
          }
          steps {
              echo "Executing step 02_jump_box ==================================================="
              def runTerraform(${Terraform_Action}, '02_jump_box')
          }
        }

        stage('03_k8s_cluster'){
          when {
            expression { 
                return '03_k8s_cluster' in choice
            }
          }
          steps {
            echo "Executing step 03_k8s_cluster ==================================================="
            def runTerraform(${Terraform_Action}, '03_k8s_cluster')
          }
        }
    }   
}

def runTerraform(action, module) {
  withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws', accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) 
  {      
    // ### runt he terrform function 
    sh script: """
    cd terraform/env_defn/dev/${module}
    export AWS_DEFAULT_REGION=eu-west-1
    export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
    export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
    /Users/Siddu/CustomApps/terraform ${action}
    """
      
  }
}