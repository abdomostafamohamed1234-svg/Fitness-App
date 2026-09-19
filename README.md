# 🏋️ Fitness App

A Flutter-based fitness application for managing workouts, exploring exercises, tracking nutrition, and interacting with an AI-powered fitness assistant.

## 📱 Overview

**Fitness App** is a cross-platform mobile fitness application built with **Flutter and Dart**. The application provides users with fitness and nutrition guidance, personalized calculations, workout assistance, and an AI-powered chatbot for fitness-related questions.

## ✨ Features

- 🔐 **User Authentication**
  - User registration and login
  - Secure authentication flow

- 🏋️ **Workout & Exercise**
  - Browse exercises and workout information
  - Get exercise guidance
  - Receive workout recommendations

- 🍎 **Nutrition & Calories**
  - Track nutritional information
  - Calculate daily calorie requirements
  - Calculate BMI, BMR, and TDEE
  - Get personalized nutrition guidance

- 🤖 **AI Fitness Assistant**
  - Ask fitness and nutrition-related questions
  - Receive personalized AI recommendations
  - Stream AI responses in real time
  - Maintain chat history

- 🔥 **Firebase Integration**
  - Firebase Authentication
  - Cloud Firestore
  - Store user data and chat history

## 🛠️ Tech Stack

- **Flutter**
- **Dart**
- **BLoC / Cubit**
- **Clean Architecture**
- **MVVM / MVI**
- **Firebase Authentication**
- **Cloud Firestore**
- **Ollama Cloud**
- **REST APIs**
- **Dependency Injection**

## 🏗️ Architecture

The application follows a structured and maintainable architecture using:

```text
Presentation
    ↓
Business Logic
    ↓
Domain
    ↓
Data
    ↓
Remote Services / Firebase
```

This separation helps keep the application scalable, testable, and easier to maintain.

## 🔄 Application Flow

```text
Authentication
      ↓
Fitness Profile
      ↓
Browse Exercises & Workouts
      ↓
Nutrition & Calorie Information
      ↓
AI Fitness Assistant
      ↓
Personalized Fitness Guidance
```

## 🤖 AI Chat Flow

The AI assistant uses **Ollama Cloud** to provide fitness and nutrition-related responses.

```text
User Message
      ↓
Chat Cubit
      ↓
AI Service
      ↓
Ollama Cloud
      ↓
Streaming Response
      ↓
Chat UI
```

Chat conversations are stored in **Cloud Firestore** for each authenticated user.

## 📂 Project Structure

```text
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── network/
│   └── utils/
│
├── data/
│   ├── models/
│   ├── data_sources/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── use_cases/
│
└── presentation/
    ├── cubits/
    ├── screens/
    └── widgets/
```

## 🔗 Backend & AI

The application uses **Firebase** for authentication and cloud data storage, while **Ollama Cloud** provides AI-powered fitness and nutrition assistance.

## 📸 Screenshots

<img width="2500" height="1743" alt="fitness_LQ" src="https://github.com/user-attachments/assets/867d7210-2e86-4392-9040-775f4f3cabde" />

- Flutter & Dart
- Clean Architecture
- BLoC / Cubit
- Firebase
- AI Integration
- Mobile Application Development

---

⭐ If you find this project useful, consider giving the repository a star.
