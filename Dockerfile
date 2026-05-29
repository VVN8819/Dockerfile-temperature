FROM python:3.11-slim

WORKDIR /app

# 1. добавил COPY requirements.txt .
COPY requirements.txt .
# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь проект сразу
COPY . .

# 2. добавил ENV MODEL_PATH
ENV MODEL_PATH=/app/models/model.pkl

EXPOSE 8080

# 3. добавил "--host", "0.0.0.0",
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
