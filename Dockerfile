# Используйте базовый образ Python
FROM python:3.8-slim

# Установите зависимости
RUN pip install flask
# Копируйте код приложения в контейнер
COPY . /app
# Установите рабочую директорию
WORKDIR /app

# Запустите приложение калькулятора
CMD ["python", "app.py"]
