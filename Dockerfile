# Используйте базовый образ Python
FROM python:3.8-slim-buster

# Установите зависимости
RUN pip install flask
RUN pip uninstall setuptools
# Копируйте код приложения в контейнер
COPY . /app
# Установите рабочую директорию
WORKDIR /app

# Запустите приложение калькулятора
CMD ["python", "app.py"]
