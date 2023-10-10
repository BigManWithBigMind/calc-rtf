pipeline {
    agent any

    environment {
        CONTAINER_NAME = 'calculator-app-container'  // Имя контейнера
        DOCKER_IMAGE = 'BigManWithBigMind/calc-rtf'
  }

    stages {
        
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                script {
                sh 'docker build -t BigManWithBigMind/calc-rtf:latest .'
                    }
                }
            }
        stage('Deploy Container') {
            steps {
                script {
                // Остановка и удаление существующего контейнера (если есть)
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"

                // Запуск контейнера из локального образа
                sh "docker run -d --network host -p 5000:5000 --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Test Calculator') {
            steps {
                // Запуск тестов (например, с использованием curl)
                sh 'curl -X POST -H "Content-Type: application/json" -d \'{"a": 5, "b": 3, "operation": "add"}\' http://192.168.1.5:5000/calculate'
                // Добавьте дополнительные тесты
            }
        }
    }
}

            
