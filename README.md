# PureSky 🌟

PureSky is a modern iOS application that combines weather forecasting, moon phase tracking, and tarot readings in a beautifully designed interface. Built with SwiftUI, it offers a premium user experience with smooth animations and intuitive navigation.

## Table of Contents 📑
- [Features](#features-)
- [Technical Details](#technical-details-)
- [Requirements](#requirements-)
- [Installation](#installation-)
- [Project Structure](#project-structure-)
- [API Integration](#api-integration-)
- [Design System](#design-system-)
- [Contributing](#contributing-)
- [License](#license-)
- [Acknowledgments](#acknowledgments-)
- [Contact](#contact-)
- [Screenshots](#screenshots-)
- [Future Enhancements](#future-enhancements-)
- [Support](#support-)

## Features 🌈

### Weather Forecast
- Real-time weather updates using WeatherAPI.com
- Current weather conditions with temperature, humidity, and wind speed
- Hourly forecast for the next 24 hours
- 7-day weather forecast
- Beautiful weather animations and transitions
- Location-based weather updates
- UV index and visibility information
- Weather alerts and notifications
- Customizable weather units (Celsius/Fahrenheit)
- Weather map integration

### Moon Phase Tracking
- Current moon phase visualization
- Detailed moon phase information
- Moonrise and moonset times
- Moon illumination percentage
- Next full moon and new moon dates
- Beautiful moon animations
- Moon phase calendar
- Lunar eclipse predictions
- Moon phase notifications
- Custom moon phase widgets

### Tarot Readings
- Daily tarot card readings
- Three-card spread readings
- Detailed card interpretations
- Card history tracking
- Beautiful card animations
- Save and share readings
- Multiple spread layouts
- Card meaning dictionary
- Reading journal
- Custom card decks

## Technical Details 🛠

### Architecture
- MVVM (Model-View-ViewModel) architecture
- SwiftUI for modern UI implementation
- Combine framework for reactive programming
- CoreLocation for location services
- Swift Concurrency for async operations
- Protocol-oriented programming
- Dependency injection
- Clean architecture principles

### Design System
- Custom color palette with dark mode support
- Consistent typography and spacing
- Reusable UI components
- Smooth animations and transitions
- Glass morphism effects
- Premium gradient backgrounds
- Custom SF Symbols integration
- Adaptive layouts
- Accessibility support
- Dynamic type support

### Dependencies
- WeatherAPI.com for weather data
- CoreLocation for location services
- SwiftUI for UI components
- Combine for reactive programming
- Swift Concurrency for async/await
- UserDefaults for local storage
- CoreData for persistent storage
- WidgetKit for iOS widgets
- StoreKit for in-app purchases

## Requirements 📋

### Development Requirements
- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+
- WeatherAPI.com API key
- macOS 12.0+
- Git for version control
- CocoaPods (optional)

### Runtime Requirements
- iOS 15.0 or later
- iPhone or iPad
- Internet connection for weather updates
- Location services (optional)
- Push notifications (optional)

## Installation 🚀

1. Clone the repository:
```bash
git clone https://github.com/yourusername/PureSky.git
```

2. Open the project in Xcode:
```bash
cd PureSky
open PureSky.xcodeproj
```

3. Add your WeatherAPI.com API key in `Config.swift`:
```swift
struct Config {
    static let weatherAPIKey = "YOUR_API_KEY"
}
```

4. Install dependencies (if using CocoaPods):
```bash
pod install
```

5. Build and run the project in Xcode

## Project Structure 📁

```
PureSky/
├── App/
│   ├── PureSkyApp.swift
│   └── Config.swift
├── Views/
│   ├── WeatherView.swift
│   ├── MoonPhaseView.swift
│   └── TarotView.swift
├── ViewModels/
│   ├── WeatherViewModel.swift
│   ├── MoonPhaseViewModel.swift
│   └── TarotViewModel.swift
├── Models/
│   ├── WeatherModels.swift
│   ├── MoonPhaseModels.swift
│   └── TarotModels.swift
├── Design/
│   ├── DesignSystem.swift
│   └── Components/
│       ├── PremiumComponents.swift
│       └── CustomViews.swift
├── Services/
│   ├── WeatherService.swift
│   ├── LocationService.swift
│   └── StorageService.swift
├── Utils/
│   ├── Extensions/
│   ├── Helpers/
│   └── Constants/
└── Resources/
    ├── Assets.xcassets
    ├── Localizable.strings
    └── Info.plist
```

## API Integration 🔌

### WeatherAPI.com
- Real-time weather data
- Forecast information
- Weather alerts
- Air quality data
- Historical weather data

### Location Services
- Current location detection
- Geocoding support
- Location permissions handling
- Location updates

### Data Storage
- UserDefaults for settings
- CoreData for persistent storage
- FileManager for file storage
- Keychain for secure data

## Design System 🎨

### Colors
```swift
struct AppColors {
    static let primary = Color("PrimaryColor")
    static let secondary = Color("SecondaryColor")
    static let accent = Color("AccentColor")
    static let background = Color("BackgroundColor")
    static let cardBackground = Color("CardBackgroundColor")
}
```

### Typography
```swift
struct AppTypography {
    static let title = Font.title
    static let headline = Font.headline
    static let body = Font.body
    static let caption = Font.caption
}
```

### Components
- PremiumWeatherCard
- PremiumButton
- PremiumTextField
- PremiumWeatherDetail
- ScaleButtonStyle

## Contributing 🤝

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Coding Standards
- Follow Swift style guide
- Use meaningful variable names
- Add comments for complex logic
- Write unit tests
- Update documentation

## License 📝

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments 🙏

- WeatherAPI.com for providing weather data
- Apple for SwiftUI and iOS development tools
- The open-source community for inspiration and support
- Contributors and maintainers
- Beta testers and users

## Contact 📧

Your Name - [@yourtwitter](https://twitter.com/yourtwitter)
Project Link: [https://github.com/yourusername/PureSky](https://github.com/yourusername/PureSky)
Email: your.email@example.com

## Screenshots 📱

[Add screenshots of your app here]

## Future Enhancements 🚀

### Weather Features
- [ ] Add more weather details and forecasts
- [ ] Implement weather notifications
- [ ] Add weather maps
- [ ] Implement weather widgets
- [ ] Add weather sharing

### Moon Phase Features
- [ ] Add more moon phase details
- [ ] Implement moon phase notifications
- [ ] Add moon phase widgets
- [ ] Implement moon phase sharing
- [ ] Add moon phase calendar

### Tarot Features
- [ ] Add more tarot spreads
- [ ] Implement tarot notifications
- [ ] Add tarot widgets
- [ ] Implement tarot sharing
- [ ] Add tarot journal

### General Features
- [ ] Implement user accounts and cloud sync
- [ ] Add widget support
- [ ] Implement Apple Watch companion app
- [ ] Add more customization options
- [ ] Implement offline support
- [ ] Add more animations and transitions
- [ ] Implement accessibility features
- [ ] Add localization support
- [ ] Implement in-app purchases
- [ ] Add analytics and crash reporting

## Support 💖

If you like this project, please give it a ⭐️ on GitHub!

### Ways to Support
- Star the repository
- Fork the project
- Create issues
- Submit pull requests
- Share with others
- Donate (optional)

### Community
- Discord server
- Twitter updates
- GitHub discussions
- Stack Overflow tags
- Reddit community
