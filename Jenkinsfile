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
        stage('UNIT testing') {
            
            steps {
                
                script {
                    
                    sh 'mvn test'
                }
            }
        }
        stage('Maven build') {
            
            steps {
                
                script {
                    
                    sh 'mvn clean install'
                }
            }
        }
        stage ('Docker Build Stage') {
            steps {
                script {
                    sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_ID khadar3099/$JOB_NAME:v1.$BUILD_ID'
                }
            }
        }
        stage ('Docker image push') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'docker_creds', variable: 'dockerpassword')]) {
                        sh 'docker login -u khadar3099 -p ${dockerpassword}'
                        sh 'docker image push khadar3099/$JOB_NAME:v1.$BUILD_ID'
                    }
                }
            }
        }
        stage ('deploy app') {
            steps {
                script {
                    sh 'ssh 43.206.192.82'
                    sh 'mkdir basha'
                }
            }
        }
    }
}
