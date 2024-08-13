pipeline{
    agent any
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-key')
    }
	
    stages{

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/kiran-113/gcp_jenkins_pipeline.git'
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
     
