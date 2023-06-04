pipeline {
    agent {label 'NPM'}
    stages {
      stage('git clone') {
        steps {
          git url: 'https://github.com/99876543/js-e2e-express-server.git',
              branch: 'declarative'
        }
      }
      stage('Build') {
        steps {
          sh 'dotnet build'  
        }
      }
      stage('Test') {
        steps {
          sh 'dotnet test' 
          
        }
      }
      stage('Update') {
        steps {
          sh 'dotnet publish'
        }
      }
    }
  }