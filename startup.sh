#!/bin/bash

# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

# Start Ollama with the specified model
echo "Starting Ollama with model: $MODEL_CHOICE"
ollama run "$MODEL_CHOICE" &

# Wait for Ollama to fully start
echo "Waiting for Ollama to fully start..."
until curl -s http://localhost:11434/v1/models > /dev/null; do
    sleep 1
done
echo "Ollama is fully started."

# Start the Python script
echo "Starting the Python script..."
python pydantic_mcp_agent.py
