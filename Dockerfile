# Используйте базовый образ Python
FROM python:3.8-slim-buster

# Установите зависимости
RUN pip install flask
RUN apt-get -y install apache2
# Копируйте код приложения в контейнер
COPY . /app
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
RUN mkdir -p /var/www/public
COPY files /var/www/public
RUN chown -R www-data:www-data /var/www/public
# Установите рабочую директорию
WORKDIR /app

# Запустите приложение калькулятора
CMD ["python", "app.py", "apache2-foreground"]
