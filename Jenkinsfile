#!/usr/bin/env groovy

pipeline {
    agent {
        label 'kubernetes || kubepod'
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                script {
                    image = docker.build('alexrubiolv/jenkins-agent')
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
