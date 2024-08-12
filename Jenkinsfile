pipeline {
    agent any

    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('jenkins-gcp-credentials') // GCP credentials for Jenkins
        PROJECT_ID = 'my-first-gcp-instance-323404'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Setup') {
            steps {
                script {
                    // Authenticate with Google Cloud
                    sh '''
                    gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
                    gcloud auth configure-docker
                    gcloud config set project $PROJECT_ID
                    '''
                }
            }
        }

        stage('Impersonate Service Account') {
            steps {
                script {
                    // Impersonate the service account
                    sh '''
                    gcloud auth print-access-token --impersonate-service-account=impersonated-terraform-sa@my-first-gcp-instance-323404.iam.gserviceaccount.com > access_token.txt
                    export ACCESS_TOKEN=$(cat access_token.txt)
                    '''
                }
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    // Use the access token for Terraform authentication
                    sh """
                    terraform init
                    export GOOGLE_OAUTH_ACCESS_TOKEN=$ACCESS_TOKEN
                    terraform plan
                    """
                }
            }
        }

        stage('Apply Terraform') {
            steps {
                script {
                    // Apply changes
                    sh "terraform apply -auto-approve"
                }
            }
        }
    }

    post {
        cleanup {
            sh "rm -f access_token.txt"
        }
    }
}