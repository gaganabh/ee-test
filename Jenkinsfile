pipeline {
  environment {
    registry = "gd015p/equalexperts"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
  stage('Cloning Git') {
      steps {
        git 'https://github.com/gaganabh/ee-test.git'
      }
    }
  stage("copy docker file to ws") {
  steps{
       sh ''' cp -r $WORKSPACE/Dockerfile $WORKSPACE/../'''
	     }
     }
  stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
         script {
            docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('start container') {
      steps{
       sh ''' docker run -p 8080:8080 ee-test:"$BUILD_NUMBER"'''
	     }
    }
  }
}
