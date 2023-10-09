pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'calculator-app:1' // Замените на имя вашего локального образа
        CONTAINER_NAME = 'calculator-app-container'  // Имя контейнера
  }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Deploy Container') {
            steps {
                script {
                // Остановка и удаление существующего контейнера (если есть)
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"

                // Запуск контейнера из локального образа
                sh "docker run -d -p 5000:5000 --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
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
