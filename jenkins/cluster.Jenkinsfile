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
                              defaultValue: 'llan', 
                              description: 'Terraform action to be selected.', 
                              type: 'PT_SINGLE_SELECT',
                              value: 'plan, apply, destroy'
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
            runTerraform( "${Terraform_Action}", '01_network')
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
              runTerraform( "${Terraform_Action}", '02_jump_box')
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
            runTerraform( "${Terraform_Action}", '03_k8s_cluster')
          }
        }
    }   
}

def runTerraform(action, module) {
  ansiColor('xterm') {
    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws', accessKeyVariable: 'AWS_ACCESS_KEY_ID',
              secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) 
    {      
      // ### run the terrform function
      if (action == 'apply') {
        action = 'apply -auto-approve=true'
      }
      sh script: """
      cd terraform/env_defn/dev/${module}
      export AWS_DEFAULT_REGION=eu-west-1
      export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
      export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
      /Users/Siddu/CustomApps/terraform init
      /Users/Siddu/CustomApps/terraform ${action} 
      """
        
    }
  }
}