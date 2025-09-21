# Backend Python para MotosSurTacna

FROM python:3.11-slim

WORKDIR /app

COPY . /app

RUN pip install --upgrade pip

# Copiar requirements.txt antes para aprovechar el cache de Docker
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
