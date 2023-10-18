node {
    docker.image('maven:3.9.0').inside('-v /root/.m2:/root/.m2') {
        stage('Build') {
            try {
                sh 'mvn -B -DskipTests clean package'
            } catch (Exception e) {
                currentBuild.result = 'FAILURE'
                throw e
            }
        }
        stage('Test') {
            try {
                sh 'mvn test'
                step([$class: 'JUnitResultArchiver', testResults: 'target/surefire-reports/*.xml'])
            } catch (Exception e) {
                currentBuild.result = 'FAILURE'
                throw e
            }
        }
        stage('Deliver') {
            try {
                sh './jenkins/scripts/deliver.sh'
            } catch (Exception e) {
                currentBuild.result = 'FAILURE'
                throw e
            }
        }
    }
}
