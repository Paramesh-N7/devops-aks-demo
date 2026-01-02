FROM --platform=linux/amd64 python:3.10-slim

# Set container working directory
WORKDIR /app

# Copy dependencies first
COPY app/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy application package
COPY app /app/app

# Explicitly set PYTHONPATH (THIS FIXES YOUR ERROR)
ENV PYTHONPATH=/app

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
