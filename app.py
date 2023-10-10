import logging
from flask import Flask, request, jsonify

app = Flask(__name__)

# Установите уровень логирования на INFO
logging.basicConfig(level=logging.INFO)

@app.route('/calculate', methods=['POST'])
def calculate():
    data = request.get_json()
    a = data.get('a')
    b = data.get('b')
    operation = data.get('operation')

    # Проверьте, что "a" и "b" являются числами
    if not isinstance(a, (int, float)) or not isinstance(b, (int, float)):
        return jsonify({'error': 'Both "a" and "b" must be numbers'}), 400

    # Проверьте, что "operation" - это допустимая операция
    if operation not in ('add', 'subtract', 'multiply', 'divide'):
        return jsonify({'error': 'Invalid operation'}), 400

    # Выполните операцию и обработайте ошибку деления на ноль
    try:
        if operation == 'add':
            result = a + b
        elif operation == 'subtract':
            result = a - b
        elif operation == 'multiply':
            result = a * b
        elif operation == 'divide':
            if b == 0:
                return jsonify({'error': 'Division by zero'}), 400
            result = a / b
    except Exception as e:
        logging.error(f"An error occurred: {str(e)}")
        return jsonify({'error': 'An error occurred'}), 500

    # Залогируйте успешное выполнение операции
    logging.info(f"Operation '{operation}' performed with {a} and {b}, result: {result}")

    return jsonify({'result': result})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
