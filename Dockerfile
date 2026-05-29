FROM python:3.11-slim

WORKDIR /app

# Копируем весь проект сразу
COPY . .

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

CMD ["uvicorn", "main:app", "--port", "8000"]
