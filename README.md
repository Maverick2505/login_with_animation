# 🎉 Login Animation with Rive  

This project demonstrates a **Flutter login screen** integrated with a **Rive animation** that reacts dynamically to user input.  
The animation changes state when typing, focusing on fields, or submitting credentials — creating a fun and interactive user experience.  

---

## ✅ Features  
- 🧠 **Interactive Animation:** The character reacts to the user’s actions in real time.  
- 👀 **Eye Tracking:** The animation follows the cursor or text while typing in the email field.  
- 🙈 **Privacy Mode:** The character covers its eyes when the password field is focused.  
- ✅ **Validation Feedback:** Success or failure animation plays depending on input validation.  
- ⚙️ **Client-side Validation:** Basic input checks for email format and password.  
- 🔄 **Password Toggle:** Allows the user to show or hide the password.  

---

## 🎨 What is Rive?  
[Rive](https://rive.app) is a powerful design and animation tool that allows developers to create **real-time, interactive vector animations**.  
Unlike traditional video or GIF animations, Rive animations can be controlled directly from your app’s logic.

### 🧠 What is a State Machine?  
A **State Machine** in Rive defines the logic and transitions between animation states.  
It connects visual animations with dynamic inputs, such as booleans, triggers, or numbers.

Example of common state machine inputs used in this project:
- `isChecking`: Character looks at the email input field.  
- `isHandsUp`: Character covers its eyes while typing a password.  
- `trigSuccess`: Plays the success animation after login.  
- `trigFail`: Plays the fail animation if credentials are incorrect.  

---

## 🛠 Technologies Used  
- [Flutter](https://flutter.dev)  
- [Dart](https://dart.dev)  
- [Rive](https://rive.app) (`rive` package)  

---

## 📁 Project Structure  

The project’s `lib` folder is organized simply:

```plaintext
Login_with_animation/
├── assets/
│   └── login_animation.riv         # The Rive animation file
├── lib/
│   ├── main.dart                   # Main app entry point
│   └── screens/
│       └── login_screen.dart       # The login screen UI and logic
└── pubspec.yaml                    # Project dependencies and asset declarations
```
## 
lib/main.dart: Entry point of the app. Initializes Flutter and sets LoginScreen as the home widget.

lib/screens/login_screen.dart: Core of the project. Connects the UI to the Rive State Machine.

assets/: Holds the .riv animation file used in the app.

pubspec.yaml: Configuration file that declares dependencies (like Flutter and Rive) and defines the asset paths.

---
# Demo

---
# 📘 Course Information

Course: Computer Graphics

Instructor: Rodrigo Fidel Gaxiola Sosa

---
# Credits ✨
This project uses a remixed Rive animation.

- Original Animation: JcToon
- Remix By: Dexterc
- Source: https://rive.app/marketplace/3645-7621-remix-of-login-machine/

---
# 🚀 How to Run

To get a local copy up and running, follow these simple steps:

1. Clone the repository
```git clone https://github.com/Maverick2505/login_with_animation```

2. Navigate to the project directory
```cd login_with_animation```

3. Install dependencies
```flutter pub get```

4. Run the app
```flutter run```
