node('scripted') {
    stage('version control') {
      git url: https://github.com/99876543/spring-petclinic.git
        branch: 'scripted'    
    }
    stage('build') {
      sh './mvnw package'
    }
}
