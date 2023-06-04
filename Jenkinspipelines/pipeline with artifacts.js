pipeline {
    agent {
        label 'MVN'
    }
    stages {
      stage('Artifactory configuration') {
        steps {
              rtServer (
                  id: "Artifactory",
                  url: 'https://syedadnan.jfrog.io/artifactory',
                  credentialsId: 'JFROG_CLOUD_ADMIN'
              )
  
              rtMavenDeployer (
                  id: "MAVEN_DEPLOYER",
                  serverId: "Artifactory",
                  releaseRepo: 'libs-release',
                  snapshotRepo: 'libs-snapshot'
              )
  
              rtMavenResolver (
                  id: "MAVEN_RESOLVER",
                  serverId: "Artifactory",
                  releaseRepo: 'libs-release',
                  snapshotRepo: 'libs-snapshot'
              )
          }
      }
      stage('clone code') {
        steps {
          git url: 'https://github.com/99876543/spring-petclinic.git',
             branch: 'declarative'
        }
      }
      stage('build') {
        steps { 
           sh './mvnw package'
        }       
      }
      stage('sonar analysis') {
        steps {
              withSonarQubeEnv('SONAR_CLOUD') {
              sh './mvnw verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=syed01_springpet -Dsonar.organization=syed01'
                
            }
        }
      }
      stage('post build') {
        steps {
                archiveArtifacts artifacts: '**/target/spring-petclinic-3.0.0-SNAPSHOT.jar',
                                 onlyIfSuccessful: true
                junit testResults: '**/surefire-reports/TEST-*.xml'
            }
        }  
      }
  }
  