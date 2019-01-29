node{
    
 stage ('Checkout do projeto') {
   git credentialsId: '6ba95ae6-dbd6-4b46-bfcd-0bc57bd1ca9e', poll: false, url: 'http://git.tuhe.com.br/Docker/wildfly-octopus.git'
 }
 
 stage ('Buscando aplicativo') {
  withMaven(
        maven: 'Maven 3.5.0',
        jdk: 'HotSpot JDK 8',
        mavenSettingsConfig: 'maven-global',
        mavenLocalRepo: '.repository') {
      sh "mvn -Dversao=$VERSAO_EAR clean package"
    }
 }
    
  stage 'Adicionando aplicativo'
    sh 'sudo docker build --no-cache=true -t nexus.tuhe.com.br:5000/docker/wildfly-octopus:$VERSAO .'

  stage 'Enviando'
    sh 'sudo docker push nexus.tuhe.com.br:5000/docker/wildfly-octopus:$VERSAO'
    
  stage 'Removendo imagem local'
    sh 'sudo docker rmi nexus.tuhe.com.br:5000/docker/wildfly-octopus:$VERSAO'

   stage ('Removendo Workspace'){
    deleteDir()
   }
}