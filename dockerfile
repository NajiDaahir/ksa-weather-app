FROM python:3.9-slim

WORKDIR /app

COPY . .

RUN pip install flask requests boto3

CMD ["python", "app.py"]
