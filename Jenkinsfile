pipeline {
    agent any

    parameters {
        string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION    = "ap-south-1"
    }

    stages {
        stage('Checkout') {
            steps {
                sh 'rm -rf assignment-docker.git' 
                sh 'git clone "https://github.com/tarundanda147/assignment-docker.git"'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh "terraform plan -input=false -out=tfplan"
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
            
            stage('Approval') {
                when {
                    not { equals expected: true, actual: params.autoApprove }
                }
                steps {
                    script {
                        def plan = readFile 'tfplan.txt'
                        input message: "Do you want to apply the plan?",
                        parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                    }
                }
            }

            stage('Terraform Apply') {
                steps {
                    sh "terraform apply -input=false tfplan"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
