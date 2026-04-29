pipeline {
    agent any
    stages {
        stage('Clone') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Zahraaabidha/cloud_devops.git'
            }
        }
        stage('Install & Build') {
            steps {
                sh 'echo "Pre-built dist included in repo"'
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t quantum-sim:latest .'
            }
        }
        stage('Security Scan') {
            steps {
                sh 'trivy image quantum-sim:latest || true'
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                    docker stop quantum-sim || true
                    docker rm quantum-sim || true
                    docker run -d -p 80:80 --name quantum-sim quantum-sim:latest
                '''
            }
        }
    }
    post {
        success { echo 'Quantum Simulator is live!' }
        failure { echo 'Build failed.' }
    }
}