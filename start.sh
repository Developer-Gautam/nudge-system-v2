#!/bin/bash

echo "🚀 Starting Nudge System v2 Setup..."

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js v16 or higher."
    exit 1
fi

echo "✅ Node.js found: $(node --version)"

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm."
    exit 1
fi

echo "✅ npm found: $(npm --version)"

# Setup Backend
echo "📦 Setting up backend..."
cd server

# Install dependencies
echo "Installing backend dependencies..."
npm install

# Check if .env exists, if not copy from example
if [ ! -f .env ]; then
    echo "📝 Creating .env file from example..."
    cp env.example .env
    echo "⚠️  Please configure your .env file with your MongoDB and AWS credentials"
fi

# Seed database
echo "🌱 Seeding database with questions..."
npm run seed

# Start backend in background
echo "🚀 Starting backend server..."
npm run dev &
BACKEND_PID=$!

cd ..

# Setup Frontend
echo "📦 Setting up frontend..."
cd client

# Install dependencies
echo "Installing frontend dependencies..."
npm install

# Check if .env exists, if not copy from example
if [ ! -f .env ]; then
    echo "📝 Creating .env file from example..."
    cp env.example .env
fi

# Start frontend
echo "🚀 Starting frontend server..."
npm run dev &
FRONTEND_PID=$!

cd ..

echo ""
echo "🎉 Nudge System v2 is starting up!"
echo ""
echo "📱 Frontend: http://localhost:5173"
echo "🔧 Backend:  http://localhost:5000"
echo ""
echo "Press Ctrl+C to stop both servers"

# Wait for user to stop
trap "echo ''; echo '🛑 Stopping servers...'; kill $BACKEND_PID $FRONTEND_PID; exit" INT
wait
