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

        stage('01_network'){
          when {
            expression { 
                return params.Terraform_Action == 'Plan'
            }
          }
          steps {
                  sh """
                  echo "deploy to production"
                  """
          }
        }
    }   
}

def runTerraform(action, module) {
  withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws', accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
      {   
          // ### runt he terrform function defined in the python/terraform.py file
          sh script: """
          cd terraform/env_defn/dev/${module}
          export AWS_DEFAULT_REGION=eu-west-1
          export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
          export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
          /Users/Siddu/CustomApps/terraform ${action}
          """
      }
  }
}



               sh "echo this is ${env.AWS_ACCESS_KEY_ID}"
               sh "echo this is ${env.AWS_SECRET_ACCESS_KEY}"
       }