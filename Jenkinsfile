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
                git branch: 'main', url: 'https://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@github.com/Marttinen-ST/gcp-project_static-webpage.git'
            }
        }
        stage('Terraform Init') {
            steps {
                // Changes directory to the terraform folder and initializes Terraform
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                // Changes directory to the terraform folder and initializes Terraform
                dir('terraform') {
                    sh 'terraform plan'
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
