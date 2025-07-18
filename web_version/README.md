# Weather Web App

A beautiful, responsive weather web application built with HTML, CSS, and JavaScript that provides real-time weather information and forecasts for any location worldwide.

## 🌟 Features

- **Real-time Weather Data**: Current weather conditions for any city
- **5-Day Forecast**: Detailed weather predictions
- **Geolocation Support**: Automatically detect your location
- **Responsive Design**: Works perfectly on desktop, tablet, and mobile
- **Beautiful UI**: Modern glassmorphism design with smooth animations
- **Local Storage**: Securely stores your API key in your browser

## 🚀 Quick Start

### 1. Get Your API Key

1. Visit [OpenWeatherMap](https://openweathermap.org/api)
2. Sign up for a free account
3. Verify your email address
4. Go to [API Keys](https://home.openweathermap.org/api_keys)
5. Copy your API key

### 2. Run the App

1. **Download the files**:
   - `index.html`
   - `style.css`
   - `script.js`

2. **Open in browser**:
   - Simply double-click `index.html`
   - Or serve with a local server (recommended)

3. **Enter your API key**:
   - The app will prompt you to enter your API key
   - Your key will be stored securely in your browser

## 🛠️ Local Development

### Option 1: Simple File Server
```bash
# Using Python 3
python -m http.server 8000

# Using Node.js
npx http-server

# Using PHP
php -S localhost:8000
```

### Option 2: Live Server (VS Code)
1. Install the "Live Server" extension
2. Right-click on `index.html`
3. Select "Open with Live Server"

## 📱 How to Use

1. **Search by City**: Type any city name and press Enter or click the search button
2. **Use Your Location**: Click the "Use My Location" button to get weather for your current location
3. **View Details**: See comprehensive weather information including:
   - Current temperature and conditions
   - Humidity, pressure, wind speed
   - Visibility and sunrise/sunset times
   - 5-day forecast with daily highs and lows

## 🎨 Features

### Weather Information
- Current temperature and "feels like" temperature
- Weather description with emoji icons
- Humidity and atmospheric pressure
- Wind speed and visibility
- Sunrise and sunset times
- 5-day forecast with min/max temperatures

### User Experience
- Responsive design for all screen sizes
- Loading states and error handling
- Smooth animations and transitions
- Modern glassmorphism UI design
- Intuitive search and location features

## 🔧 Technical Details

### Browser Support
- Chrome/Edge 60+
- Firefox 55+
- Safari 12+
- Mobile browsers (iOS Safari, Chrome Mobile)

### API Integration
- Uses OpenWeatherMap API
- Fetches current weather and 5-day forecast
- Handles geolocation for automatic location detection
- Includes proper error handling for API failures

### Security
- API key stored locally in browser
- No server-side components required
- HTTPS API calls for secure data transmission

## 🌡️ Weather Data

The app displays:
- **Current Weather**: Real-time conditions
- **Temperature**: Current, feels-like, daily highs/lows
- **Atmospheric Data**: Humidity, pressure, visibility
- **Wind Information**: Speed and direction
- **Sun Times**: Sunrise and sunset
- **Forecast**: 5-day weather predictions

## 🎯 Customization

### Adding New Features
1. **Different Units**: Modify the API calls to use imperial units
2. **More Forecast Days**: Extend the forecast display
3. **Weather Maps**: Integrate weather map overlays
4. **Themes**: Add dark/light mode toggle

### Styling
- Modify `style.css` to change colors, fonts, or layout
- Add new animations or transitions
- Customize the responsive breakpoints

## 🐛 Troubleshooting

### Common Issues

1. **API Key Error**
   - Make sure your API key is correct
   - Check that your API key is activated (can take up to 2 hours)
   - Verify you haven't exceeded the free tier limits

2. **Location Not Working**
   - Ensure you've granted location permissions
   - Check that location services are enabled
   - Try using HTTPS instead of HTTP

3. **City Not Found**
   - Check the spelling of the city name
   - Try including the country code (e.g., "London, UK")
   - Use the exact city name as recognized by OpenWeatherMap

## 📄 Files Structure

```
web_version/
├── index.html          # Main HTML file
├── style.css           # Styles and animations
├── script.js           # JavaScript functionality
└── README.md           # This file
```

## 🌐 Demo

You can see the app in action by opening `index.html` in your browser. The app will:
1. Prompt you to enter your API key
2. Load default weather for London
3. Allow you to search for any city
4. Detect your location (with permission)

## 📞 Support

If you encounter any issues:
1. Check your browser's console for error messages
2. Verify your API key is correct and active
3. Ensure you have an internet connection
4. Try refreshing the page

## 🤝 Contributing

Feel free to contribute improvements:
1. Fork the project
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📄 License

This project is open source and available under the MIT License.

---

**Enjoy your beautiful weather web app! 🌈**