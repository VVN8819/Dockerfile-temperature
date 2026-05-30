# Dockerfile-temperature
Учебный проект на тему "Dockerfile: найти и исправить".

**Цель:** исправление Dockerfile

**Проект демонстрирует:**
- Собор образа, запуск контейнера
- Выявление и исправление ошибок в Dockerfile
- Volumes: изменение поведения без пересборки через файл my_config.json с новыми порогами
- Запуск не от root (RUN useradd -m appuser)
- Секреты в ENV (ENV API_KEY=... в Dockerfile)
- Передача секретов только при запуске (--env-file .env)
- Проверка секрета в истории образа (docker history)

**Структура:**

    - Dockerfile - Конфигурация Docker
    - main.py - FastAPI приложение
    - config.json - Пороги температур (cold_max, hot_min)
    - requirements.txt - Python зависимости
    - .env - Переменные окружения (не коммитить!)
    - my_config.json - Кастомный конфиг для volume mounting
    - .gitignore - Игнорируемые файлы для Git
    - LICENSE - Лицензия проекта
    - README.md - Описание проекта

# Задания

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

**Проверьте, что кеш слоёв работает: измените любую строку в main.py, пересоберите образ — шаг pip install не должен запускаться заново.**
Ссылка на скрин https://imgbox.com/cjsSxtMo

# Opt-1 — Volumes: изменение поведения без пересборки
Создайте рядом файл my_config.json с новыми порогами:
{
    "cold_max": 20,
    "hot_min": 30
}
Ссылка на скрин https://imgbox.com/YCpniAz1

# Opt-2 — Запуск не от root
Добавьте в свой исправленный Dockerfile перед CMD:
RUN useradd -m appuser
USER appuser
Ссылка на скрин https://imgbox.com/GnEOl8Xl

# Opt-3 — Секреты в ENV
Часть A — воспроизведите проблему
Добавьте в ваш исправленный Dockerfile строку с «секретом»: 
ENV API_KEY=supersecret-12345 
Секрет виден в открытом виде в метаданных образа.
Ссылка на скрин https://imgbox.com/VupjpPTJ

Часть B — правильный способ
Уберите ENV API_KEY=... из Dockerfile. Создайте файл .env рядом: 
API_KEY=supersecret-12345

в истории образа секрета больше нет, но внутри контейнера переменная всё равно доступна https://imgbox.com/5B1gwKR0
