# Используйте базовый образ Python
FROM python:3.9.18-slim-bullseye
# Установите зависимости
RUN pip install setuptools==65.5.1
RUN pip install flask
# Копируйте код приложения в контейнер
COPY . /app
# Установите рабочую директорию
WORKDIR /app

# Запустите приложение калькулятора
CMD ["python", "app.py"]
