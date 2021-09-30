#!/usr/bin/env groovy

pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                script {
                    image = docker.build('jftanner/jenkins-agent')
                }
            }
        }

        stage('Publish') {
            when {
                branch 'master'
            }
            steps {
                echo 'Pushing...'
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        image.push('latest')
                    }
                }
            }
        }
    }
}
