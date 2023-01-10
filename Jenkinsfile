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
                    echo "===> about to SSH into the dev environment.."
                        sh '''
                        echo "===> in bash script now"
                        ssh -tt ubuntu@172.31.33.206
                        ls
                        pwd          
                        '''
                }
            }
        }
    }
}
