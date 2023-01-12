pipeline {
    agent any

    options {
        timeout(time: 5, unit: 'MINUTES')
    }
    environment {
        ARTIFACT_ID = "railsapijenkins:${env.BUILD_NUMBER}"
    }

    stages {
        stage('Create container') {
            steps {
                script {
                    sh'''
                        docker build -t ${env.ARTIFACT_ID} .
                    '''
                }
            }
        }
        stage('Run tests') {
            steps {
                sh '''
                    docker run --rm ${env.ARTIFACT_ID} bundle exec rspec
                '''
                
            }
        }
        stage('Run') {
            steps {
                sh '''
                    docker run --rm -p -d 3000:3000 ${env.ARTIFACT_ID}
                '''
                
            }
        }
    
    }
}