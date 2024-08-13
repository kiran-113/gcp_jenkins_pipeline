pipeline {
    agent any

    environment {
        // Use the ID of the secret file credential set up in Jenkins to get the path
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-key')
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
                    withEnv(["GOOGLE_APPLICATION_CREDENTIALS=${GOOGLE_APPLICATION_CREDENTIALS}"]) {
                        sh 'gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}'
                        sh 'gcloud config set project your-gcp-project-id'
                    }
                }
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    withEnv(["GOOGLE_APPLICATION_CREDENTIALS=${GOOGLE_APPLICATION_CREDENTIALS}"]) {
                        sh 'terraform init'
                    }
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                script {
                    withEnv(["GOOGLE_APPLICATION_CREDENTIALS=${GOOGLE_APPLICATION_CREDENTIALS}"]) {
                        sh "terraform plan -out=tfplan -var='credentials_file=${GOOGLE_APPLICATION_CREDENTIALS}'"
                    }
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
                    withEnv(["GOOGLE_APPLICATION_CREDENTIALS=${GOOGLE_APPLICATION_CREDENTIALS}"]) {
                        sh 'terraform apply tfplan'
                    }
                }
            }
        }
    }
}