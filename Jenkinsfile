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
        stage('Terraform Apply with auto approve') {
            steps {
                // Changes directory to the terraform folder and initializes Terraform
                dir('terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        stage('Yarn Build') {
            steps {
                // Changes directory to the terraform folder and initializes Terraform
                dir('terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        stage('Cleaning up bucket') {
            steps {
                // Changes directory to the terraform folder and initializes Terraform
                dir('code') {
                    sh 'gsutil -m rm -r gs://rga-test-website-host/**'
                }
            }
        }
        stage('Coping new content') {
            steps {
                // Changes directory to the terraform folder and initializes Terraform
                dir('code/build') {
                    sh 'gsutil -m cp -r * gs://rga-test-website-host/'
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
