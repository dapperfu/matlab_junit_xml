pipeline {
  agent any
  stages {
    stage('Run Examples') {
      steps {
        runMATLABCommand 'run(\'tools\\run_examples.m\')'
      }
    }

  }
  triggers {
    cron('0 0 * * *')
    pollSCM('*/5 * * * *')
  }
}