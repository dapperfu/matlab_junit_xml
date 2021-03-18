pipeline {
  agent any
  stages {
    stage('Run Examples') {
      steps {
        runMATLABCommand 'run(\'tools\\run_examples.m\')'
      }
    }

    stage('Archive Artifacts') {
      steps {
        junit '**/*.xml'
      }
    }

  }
  triggers {
    cron('0 0 * * *')
    pollSCM('*/5 * * * *')
  }
}