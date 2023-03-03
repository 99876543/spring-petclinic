node('scripted') {
    stage('version control') {
      git url: https://github.com/spring-projects/spring-petclinic.git
        branch: 'scripted'    
    }
    stage('build') {
      sh './mvnw package'
    }
}
