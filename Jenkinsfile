
node {
    stage('Checkout') {
        checkout scm
    }

    docker.image('jhipster/jhipster:v6.10.5').inside('-u jhipster -e MAVEN_OPTS="-Duser.home=./"') {
        stage('Check java') {
            sh "java -version"
        }

        stage('Clean') {
            sh "chmod +x mvnw"
            sh "./mvnw -ntp clean -P-webpack"
        }
        stage('Nohttp') {
            sh "./mvnw -ntp checkstyle:check"
        }

        stage('Install Tools') {
            sh "./mvnw -ntp com.github.eirslett:frontend-maven-plugin:install-node-and-npm -DnodeVersion=v12.16.1 -DnpmVersion=6.14.5"
        }

        stage('npm Install') {
            sh "./mvnw -ntp com.github.eirslett:frontend-maven-plugin:npm"
            sh 'npm --version'

        }

        stage('Backend Tests') {
            try {
                sh "./mvnw -ntp verify -P-webpack -Denforcer.skip=true -DskipTests"
            } catch(err) {
                throw err
            } finally {
                junit allowEmptyResults: true,
                testResults: 'SGP/target/test-results/TESTS-*.xml'
            }
        }

        stage('Frontend Tests') {
            try {
               sh 'npm install npm@6.14.13'
               sh 'npm test'
            } catch(err) {
                throw err
            } finally {
                junit allowEmptyResults: true,
                testResults: 'SGP/target/test-results/TESTS-*.xml'            }
        }

        stage('Packaging') {
            sh "./mvnw -ntp verify -P-webpack -Denforcer.skip=true -DskipTests"
        }
    }
}
