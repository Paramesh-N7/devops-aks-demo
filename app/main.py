from fastapi import FastAPI
from sqlalchemy.orm import Session
from app.db import engine, SessionLocal
from app.models import Base, Task

app = FastAPI()

# Create tables ONLY if DB is available
if engine:
    Base.metadata.create_all(bind=engine)

@app.post("/tasks")
def create_task(title: str):
    if not SessionLocal:
        return {"error": "Database not configured"}

    db: Session = SessionLocal()
    task = Task(title=title)
    db.add(task)
    db.commit()
    db.refresh(task)
    db.close()
    return task

@app.get("/tasks")
def get_tasks():
    if not SessionLocal:
        return []

    db: Session = SessionLocal()
    tasks = db.query(Task).all()
    db.close()
    return tasks

@app.get("/health")
def health():
    return {"status": "ok"}
