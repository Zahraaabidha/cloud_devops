pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPO = '<your-ecr-url>/quantum-sim'
    }
    stages {
        stage('Clone') {
            steps {
                git branch: 'main',
                    url: url: 'https://github.com/Zahraaabidha/cloud_devops.git'
            }
        }
        stage('Install & Build') {
            steps { sh 'npm install && npm run build' }
        }
        stage('Docker Build') {
            steps { sh 'docker build -t quantum-sim:latest .' }
        }
        stage('Security Scan') {
            steps { sh 'trivy image quantum-sim:latest || true' }
        }
        stage('Push to ECR') {
            steps {
                sh '''
                    aws ecr get-login-password --region $AWS_REGION | \
                    docker login --username AWS --password-stdin $ECR_REPO
                    docker tag quantum-sim:latest $ECR_REPO:latest
                    docker push $ECR_REPO:latest
                '''
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                    aws ecs update-service \
                        --cluster quantum-cluster \
                        --service quantum-sim-service \
                        --force-new-deployment \
                        --region $AWS_REGION
                '''
            }
        }
    }
    post {
        success { echo 'Live on AWS!' }
        failure { echo 'Pipeline failed. Check logs.' }
    }
}