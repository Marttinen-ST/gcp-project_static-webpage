pipeline {
    agent any
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-service-account')
        GIT_TOKEN = credentials('git-token')
    }
    stages {
        stage('Checkout Code') {
            steps {
                // Clones the repository
                git branch: 'main', url: 'https://${GIT_TOKEN}@github.com/Marttinen-ST/gcp-project_static-webpage.git'
            }
        }
        stage('Initialize Terraform') {
            steps {
                // Changes directory to the terraform folder and initializes Terraform
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }
        stage('Plan Terraform') {
            steps {
                // Changes directory to the terraform folder and generates an execution plan
                dir('terraform') {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }
        stage('Apply Terraform') {
            steps {
                // Changes directory to the terraform folder and applies the Terraform configuration
                dir('terraform') {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }
    post {
        always {
            // Clean up
            dir('terraform') {
                sh 'rm -f tfplan'
            }
        }
    }
}
