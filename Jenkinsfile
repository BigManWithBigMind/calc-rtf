pipeline {
    agent any

    environment {
        CONTAINER_NAME = 'calculator-app-container'  // Имя контейнера
        DOCKER_IMAGE = 'bigmanwithbigmind/calc-rtf'
  }

    stages {
        stage('Build') {
            steps {
                script {
                sh 'docker build -t bigmanwithbigmind/calc-rtf:latest .'
                    }
                }
            }
        stage('Scanning') {
            steps {
                script {
                sh 'mkdir -p reports'
                sh 'trivy image --format template --template "@contrib/html.tpl" -o reports/calc-scan.html ${DOCKER_IMAGE} ' 
                publishHTML target : [
                    allowMissing: true,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'reports',
                    reportFiles: 'calc-scan.html',
                    reportName: 'Trivy Scan',
                    reportTitles: 'Trivy Scan'
                ]
                }
            }
        }
        stage('Deploy Container') {
            steps {
                script {
                // Остановка и удаление существующего контейнера (если есть)
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"

                // Запуск контейнера
                sh "docker run -d --network host -p 5000:5000 --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Test Calculator') {
            steps {
                // Запуск тестов (например, с использованием curl)
                sh 'curl -X POST -H "Content-Type: application/json" -d \'{"a": 5, "b": 3, "operation": "add"}\' http://localhost:5000/calculate'
                sh 'curl -X POST -H "Content-Type: application/json" -d \'{"a": "bbb", "b": 3, "operation": "add"}\' http://localhost:5000/calculate'
                sh 'curl -X POST -H "Content-Type: application/json" -d \'{"a": 6, "b": 0, "operation": "divide"}\' http://localhost:5000/calculate'
                sh 'curl -X POST -H "Content-Type: application/json" -d \'{"a": 5, "b": 3, "operation": "cheat"}\' http://localhost:5000/calculate'
            }
        }
    }
}

            
