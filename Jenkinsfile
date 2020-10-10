// working example, as configured in the pipeline settings of the project

pipeline {

    agent none

    environment {
        registry = 'ims19/secure_devops_spring'
        registryCredentials = 'docker-hub'
    }
    stages {
        
        stage('Clone') {
            agent any
            steps {
                git 'https://github.com/ims-19/gs-rest-service.git'
            }
        } 
        stage('Build') {
            agent {
                docker {
                    image 'openjdk:16-jdk-alpine'
                }
            }
            steps {
                sh './mvnw clean install'
            }
        }
        stage('Test') {
            agent {
                docker {
                    image 'openjdk:16-jdk-alpine'
                }
            }
            steps {
                sh './mvnw test' 
            }
        }
        stage('Build image') {
            steps {
                script {
                    dockerImage = docker.build(registry + ":$BUILD_NUMBER")
                }
            }
        }
        stage('Publish image') {
            steps {
                script {
                    docker.withRegistry('', registryCredentials) {
                        dockerImage.push()
                        dockerImage.push("latest")
                    }
                }
            }
        }
    }
}