pipeline {
    agent any
    triggers {
        cron('0 0 * * *')   // Midnight build.
        pollSCM('*/5 * * * *') // Look every 5 minutes for new commits.
    }
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }  
        stage('Run Examples'){
            steps {
                bat '''
@ECHO OFF
call tools\\run_examples.bat
'''
            }
        }
        stage('Package Toolbox'){
            steps {
                bat '''
@ECHO OFF
call tools\\packager.bat
'''
                archiveArtifacts artifacts: '*.mltbx, *.log', caseSensitive: false, fingerprint: true, onlyIfSuccessful: true
            }
        }
    }
}
