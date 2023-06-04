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
          sh 'npm install' 
          sh 'npm run build' 
        }
      }
      stage('Test') {
        steps {
          sh 'npm test' 
          sh 'npm fund'
          sh 'npm audit'
          sh 'npm audit fix'
        }
      }
      stage('Update') {
        steps {
          sh 'npm update'
        }
      }
    }
  }