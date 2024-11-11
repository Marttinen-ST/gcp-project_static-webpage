pipeline {
    agent any
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-service-account')
        GIT_TOKEN = credentials('github-token')
    }
    stages {
        stage('Checkout Code') {
            steps {
                // Clones the repository
                sh 'rm -r gcp-project_static-webpage/'
                sh 'git clone https://$GIT_TOKEN_PSW@github.com/Marttinen-ST/gcp-project_static-webpage.git'
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
        stage('Yarn Install and Build') {
            steps {
                // Changes directory to the terraform folder and initializes Terraform
                dir('code') {
                    sh 'yarn install'
                    sh 'yarn build'
                }
            }
        }
        stage('Cleaning up bucket') {
            steps {
                // Changes directory to the terraform folder and initializes Terraform
                dir('code') {
                    // sh 'gcloud auth activate-service-account --key-file=/var/lib/jenkins/long-sum-441213-v5-2df2b21e07ed.json'
                    sh 'gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS'
                    sh 'gcloud storage rm gs://rga-test-website-host/*'
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
