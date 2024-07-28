# Artfolio

>Artfolio is a mobile application aimed at empowering artists by providing them with a platform to showcase their creative work, connect with potential clients, and receive valuable feedback. >It serves as a digital canvas for artists of various disciplines, including painters, photographers, sculptors, and others.

## Features
  - Home Screen: Displays featured artworks
  - Profile Screen: Displays the artist’s profile with bio, portfolio
  - Search Screen: Allows users to search for specific artworks or artists by title or description.
  - Upload Screen: Allows artists to upload new artworks with descriptions and tags.
  - Edit Profile: Allows artists to update their profile information, manage their portfolio, and change their profile image.

## Getting Started

### Prerequisites
  Flutter SDK
  Firebase account

### Installation
  
  1. Clone the repository:  
    /git clone https://github.com/yourusername/artfolio.git/
    cd artfolio
  
  2. Install dependencies:
    flutter pub get
  
  3. Setup Firebase:
    - Create a new project in Firebase.
    - Add an Android app to your Firebase project.
    - Download the google-services.json file and place it in the android/app directory.
    - Add an iOS app to your Firebase project.
    - Download the GoogleService-Info.plist file and place it in the ios/Runner directory.
    - Enable Firestore and Firebase Storage in your Firebase project.

  4. Run the app:
    flutter run

## Project Structure
        lib/
        ├── main.dart
        ├── home_screen.dart
        ├── profile_screen.dart
        ├── edit_profile_screen.dart
        ├── upload_screen.dart
        ├── search_screen.dart
        ├── login_screen.dart
        └── artwork_detail_screen.dart

## Key Files

main.dart
The entry point of the application. It sets up the MaterialApp and defines the routes.

home_screen.dart
Contains the HomeScreen widget which displays featured artworks

profile_screen.dart
Contains the ProfileScreen widget which displays the artist's profile and their artworks. It also provides options to edit the profile and logout.

edit_profile_screen.dart
Contains the EditProfileScreen widget which allows artists to update their email, password, and profile image.

upload_screen.dart
Contains the UploadScreen widget which allows artists to upload new artworks with descriptions and tags.

search_screen.dart
Contains the SearchScreen widget which allows users to search for specific artworks or artists by title or description.

login_screen.dart
Contains the LoginScreen widget which provides login and registration functionality.

Firebase Integration
This project uses Firebase for authentication, Firestore for storing user and artwork data, and Firebase Storage for storing artwork images.

## Acknowledgments
Flutter
Firebase



A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# MobileAppDevelopment-Project2
