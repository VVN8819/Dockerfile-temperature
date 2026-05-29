# Dockerfile-temperature

После исправлений:
# Собрать образ
docker build -t weather-hw:v1 .
Ссылка на скрин https://imgbox.com/drTETH9S

# Запустить контейнер
docker run --rm -p 8000:8000 weather-hw:v1
Ссылка на скрин https://imgbox.com/SudaUrTq

# В другом терминале — проверить
curl -X POST http://localhost:8000/classify \
 -H "Content-Type: application/json" \
 -d '{"temperature": 35}'
Ожидаемый ответ:
{"category": "hot", "temperature": 35.0}
Ссылка на скрин https://imgbox.com/dIe0hZ7M

# Проверьте, что кеш слоёв работает: измените любую строку в main.py, пересоберите образ — шаг pip install не должен запускаться заново.
Ссылка на скрин https://imgbox.com/cjsSxtMo