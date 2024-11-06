# E-Commerce Shopping App

A modern, feature-rich e-commerce mobile application built with Flutter.

## 🌟 Features

- **User Authentication & Profile Management**
  - Secure login/signup system
  - Profile customization
  - Complete profile information management

- **Shopping Experience**
  - Product browsing and search
  - Cart management
  - Order tracking
  - Multiple payment methods

- **Additional Features**
  - Push notifications (Firebase Cloud Messaging)
  - Location services
  - Order history
  - Settings management
  - Help center

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (Latest Version)
- Dart SDK (Latest Version)
- Firebase account
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/shop_app.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure Firebase
   - Add your `google-services.json` for Android
   - Add your `GoogleService-Info.plist` for iOS
   - Update Firebase configuration in `firebase_options.dart`

4. Run the app
```bash
flutter run
```

## 🏗️ Architecture

The app follows a clean architecture pattern with Provider for state management:

- `lib/screens/` - UI screens and components
- `lib/provider/` - State management
- `lib/models/` - Data models
- `lib/constants/` - App-wide constants
- `lib/routes/` - Navigation routes

## 🔧 Configuration

### API Endpoint

The app uses a REST API backend. Configure the endpoint in `constants.dart`:

```dart

const kEndpoint = "YOUR_API_ENDPOINT";
```

### Environment Variables

Required environment variables:
- `FIREBASE_PROJECT_ID`
- `FIREBASE_MESSAGING_SENDER_ID`
- `FIREBASE_STORAGE_BUCKET`

## 📱 Key Dependencies

- `provider`: ^6.0.0 - State management
- `firebase_core`: Latest version - Firebase core functionality
- `firebase_messaging`: Latest version - Push notifications
- `get_storage`: Latest version - Local storage
- `get`: Latest version - Navigation and dependency injection

## 🔐 Security

- Implements secure user authentication
- Data encryption for sensitive information
- Secure API communication
- Input validation and sanitization

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## 👥 Authors

- Abdilaahi Mowliid - *Initial work* - [Github](https://github.com/Dhaqane-00)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase and Nodejs for backend services
- All contributors who helped with the project

## 📞 Support

For support, email AbdilaahiMowliid@gmail.com
