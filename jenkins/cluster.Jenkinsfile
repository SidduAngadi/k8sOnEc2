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
                              type: 'PT_SINGLE_SELECT'
                              value: 'Plan, Apply, Destroy'
                          )
                      ])
                  ])
                }
            }
        }
    }   
}