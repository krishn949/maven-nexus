pipeline {
    
    agent any 
    
    stages {
        
        stage('Git Checkout'){
            
            steps{
                
                script{
                    
                    git branch: 'main', url: 'https://github.com/khadar099/maven-nexus.git'
                }
            }
        }
        stage('UNIT testing'){
            
            steps{
                
                script{
                    
                    sh 'mvn test'
                }
            }
        }
        stage('Integration testing'){
            
            steps{
                
                script{
                    
                    sh 'mvn verify -DskipUnitTests'
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
        stage('Static code analysis'){
            
            steps{
                
                script {
                    
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                        
                        sh 'mvn clean package sonar:sonar'
                    }
                }
                    
            }
        }
        //stage('Quality Gate Status') {
                
            //steps {
                    
                //script {
                        
                    //waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
                //}
            //}
        //}
        stage ('Docker Build Stage') {
            steps {
                script {
                    sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_ID khadar099/$JOB_NAME:v1.$BUILD_ID'
                }
            }
        }
        stage ('push docker image to  dockerhub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockrhb-pswd', variable: 'dockerhub-paswrd')]) {
                        sh 'docker login -u khadar099 -p ${dockerhub-paswrd}'
                        sh 'docker image push khadar099/$JOB_NAME:v1.$BUILD_ID'
                    }
                }
            }
        }
    }
}
