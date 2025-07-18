#!/bin/bash

echo "Setting up Flutter Weather App..."

# Check if Flutter is already installed
if ! command -v flutter &> /dev/null; then
    echo "Flutter not found. Installing Flutter..."
    
    # Install Flutter
    cd /tmp
    git clone https://github.com/flutter/flutter.git -b stable
    
    # Add Flutter to PATH
    export PATH="$PATH:/tmp/flutter/bin"
    
    # Run flutter doctor
    flutter doctor
    
    echo "Flutter installed successfully!"
else
    echo "Flutter is already installed."
fi

# Go back to project directory
cd /workspace

# Get dependencies
echo "Installing dependencies..."
flutter pub get

# Generate JSON serialization code
echo "Generating JSON serialization code..."
flutter packages pub run build_runner build

echo "Setup complete!"
echo ""
echo "To run the app:"
echo "1. Get an API key from https://openweathermap.org/api"
echo "2. Replace 'your_api_key_here' in lib/services/weather_service.dart with your API key"
echo "3. Run: flutter run"