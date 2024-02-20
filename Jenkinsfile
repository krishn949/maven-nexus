pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout your source code from version control
                script{
                    git branch: 'main', url: 'https://github.com/khadar099/maven-nexus.git'
                }
            }
        }
        stage('Maven build') {
            steps {
                script{
                    sh 'mvn clean install'
                }
            }
        }
    }
}
