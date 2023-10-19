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
        stage('Manual Approval') {
            input message: 'Lanjutkan ke tahap Deploy?'
        }
        stage('Deploy') {
            try {
                sh './jenkins/scripts/deliver.sh'
                sh 'sleep 1m'
            } catch (Exception e) {
                currentBuild.result = 'FAILURE'
                throw e
            }
        }
    }
}
