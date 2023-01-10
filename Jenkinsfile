pipeline {
    
    agent any 
    
    stages {
        stage('Git Checkout') {
            
            steps {
                
                script {
                    
                    git branch: 'main', url: 'https://github.com/khadar099/maven-nexus.git'
                }
            }
        }
        stage ('deploy app') {
            steps {
                script {
                    sh 'ssh -tt ubuntu@13.114.117.217'
                    sh 'mkdir basha'
                    sh 'ls'
                }
            }
        }
    }
}
