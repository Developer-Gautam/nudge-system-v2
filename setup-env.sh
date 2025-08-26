#!/bin/bash

echo "🔧 Nudge System Environment Setup"
echo "=================================="
echo ""

# Check if .env exists
if [ -f ".env" ]; then
    echo "⚠️  .env file already exists. Do you want to overwrite it? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        cp env.example .env
        echo "✅ .env file recreated from example"
    else
        echo "ℹ️  Using existing .env file"
    fi
else
    cp env.example .env
    echo "✅ .env file created from example"
fi

echo ""
echo "📝 Please configure the following in your .env file:"
echo ""

echo "🔹 MONGODB_URI:"
echo "   - For MongoDB Atlas: mongodb+srv://username:password@cluster.mongodb.net/nudge-system"
echo "   - For local MongoDB: mongodb://localhost:27017/nudge-system"
echo ""

echo "🔹 JWT_SECRET:"
echo "   - Generate a random string (you can use: openssl rand -base64 32)"
echo ""

echo "🔹 AWS_ACCESS_KEY_ID:"
echo "   - From your IAM user credentials"
echo ""

echo "🔹 AWS_SECRET_ACCESS_KEY:"
echo "   - From your IAM user credentials"
echo ""

echo "🔹 SQS_QUEUE_URL:"
echo "   - From your SQS queue (format: https://sqs.region.amazonaws.com/account-id/queue-name)"
echo ""

echo "🔹 EVENTBRIDGE_BUS_NAME:"
echo "   - Name of your EventBridge bus (default: nudge-system-bus)"
echo ""

echo "📋 Quick Reference:"
echo "=================="
echo "1. MongoDB Atlas: https://www.mongodb.com/atlas"
echo "2. AWS Console: https://aws.amazon.com/"
echo "3. IAM Users: https://console.aws.amazon.com/iam/"
echo "4. SQS: https://console.aws.amazon.com/sqs/"
echo "5. EventBridge: https://console.aws.amazon.com/events/"
echo ""

echo "🚀 After configuring .env, run:"
echo "   npm run seed    # Seed the database"
echo "   npm run dev     # Start the server"
echo ""
