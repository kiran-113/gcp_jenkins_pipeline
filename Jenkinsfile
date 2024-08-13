pipeline {
    agent any

    environment {
        // Use the ID of the secret file credential added in Jenkins
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-key')
        PROJECT_ID = "my-first-gcp-instance-323404"
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/kiran-113/gcp_jenkins_pipeline.git'
            }
        }

        stage('Configure GCP Authentication') {
            steps {
                script {
                    // This sets the environment variable that the Google SDK uses to authenticate
                    withEnv(["GOOGLE_APPLICATION_CREDENTIALS=${GOOGLE_APPLICATION_CREDENTIALS}"]) {
                        sh 'gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}'
                        sh 'gcloud config set project ${PROJECT_ID}'
                    }
                }
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Manual Approval') {
            steps {
                input "Approve?"
            }
        }
     
        stage('Terraform Apply') {
            steps {
                script {
                    sh 'terraform apply tfplan'
                }
            }
        }
    }
}