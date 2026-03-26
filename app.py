import os

import whisper
from fastapi import FastAPI, File, UploadFile

app = FastAPI()
model = whisper.load_model("base")


@app.get("/")
def read_root():
    return {"status": "Whisper API is running!"}


@app.post("/transcribe")
async def transcribe(file: UploadFile = File(...)):
    with open("temp_audio.mp3", "wb") as f:
        f.write(await file.read())
    result = model.transcribe("temp_audio.mp3")
    os.remove("temp_audio.mp3")
    return {"text": result["text"]}
