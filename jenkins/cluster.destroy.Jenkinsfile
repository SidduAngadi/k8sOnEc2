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
                              name: 'modules', 
                              // defaultValue: '01_network, 02_jump_box, 03_k8s_cluster', 
                              description: 'select modules to deploy', 
                              type: 'PT_CHECKBOX',
                              value: '01_k8s_cluster,02_jump_box, 03_network',
                              visibleItemCount: 3
                          )
                      ])
                  ])
                }
            }
        }

        stage('01_k8s_cluster'){
          
          when {
            expression { 
                return '01_k8s_cluster' in choice
            }
          }
          steps {
            echo "Executing step 01_k8s_cluster ==================================================="
            runTerraform( "destroy", '03_k8s_cluster')
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
              runTerraform( "destroy", '02_jump_box')
          }
        }

        stage('03_network'){
          when {
            expression { 
                return '03_network' in choice
            }
          }
          steps {
            echo "Executing step 03_network ==================================================="
            runTerraform( "destroy", '01_network')
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