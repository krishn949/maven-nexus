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
                    sh 'ssh -tt root@43.206.221.127 -oStrictHostKeyChecking=no'
                    sh 'mkdir basha'
                    sh 'ls'
                }
            }
        }
    }
}
