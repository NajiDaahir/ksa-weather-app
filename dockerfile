# Use Python base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the application files
COPY . .

# Install dependencies
RUN pip install flask requests boto3

# Run the application
CMD ["python", "app.py"]
