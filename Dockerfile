# Используйте базовый образ Python
FROM python:3.8-slim-buster

# Установите зависимости
RUN apt-get update
RUN apt install openssl -y
RUN pip install setuptools==65.5.1
RUN pip install flask
# Копируйте код приложения в контейнер
COPY . /app
# Установите рабочую директорию
WORKDIR /app

# Запустите приложение калькулятора
CMD ["python", "app.py"]
