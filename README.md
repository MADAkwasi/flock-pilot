# 🐔 FlockPilot (Flutter Frontend)

FlockPilot is a **mobile poultry farm management application** built with Flutter.
It helps farmers track flock performance, manage farm operations, and interact with an AI assistant for smart farming insights.

This repository contains the **Flutter frontend**, which connects to the FlockPilot backend API.

👉 Backend Repository:
[https://github.com/MADAkwasi/flock-pilot-backend](https://github.com/MADAkwasi/flock-pilot-backend)

---

## ✨ Features

- 📊 Farm dashboard with performance insights
- 🐣 Flock management (add, update, track flocks)
- 🥚 Egg production tracking
- 🍗 Feed consumption and inventory management
- 💰 Expense tracking
- 📈 Analytics and farm insights
- 🤖 AI assistant (CoopMind) powered by Groq API
- 💬 Conversational chat with history support
- 🔔 Notifications for farm events
- 🌙 Clean, responsive mobile UI

---

## 🏗️ Tech Stack

- **Flutter** (UI framework)
- **Dart** (language)
- **Riverpod** (state management)
- **Dio** (HTTP client)
- **GoRouter** (navigation)
- **Grok / LLM API** (AI assistant integration)
- **Local storage** (token persistence, caching)

---

## 📱 App Architecture

The project follows a **feature-first architecture**:

```
lib/
│
├── core/              # App config, router, theme, API client
├── features/         # Feature modules (flocks, feed, AI chat, etc.)
├── provider/         # Riverpod state management
├── data/             # Repositories & API layer
├── shared/           # Models, widgets, utilities
├── main.dart         # App entry point
```

---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/flockpilot.git
cd flockpilot-frontend
```

---

### 2. Install dependencies

```bash
flutter pub get
```

---

### 3. Configure API

Update your API base URL inside:

```dart
BaseOptions(
  baseUrl: 'http://your-backend-url/api/v1',
)
```

Or use environment variables if configured.

---

### 4. Run the app

```bash
flutter run
```

---

## 🔌 Backend Integration

This frontend communicates with the **FlockPilot Backend API** for:

- Farm data
- Flock tracking
- Inventory & feed logs
- Expense management
- AI assistant chat system

👉 Backend API:
[https://github.com/yourusername/flockpilot-backend](https://github.com/yourusername/flockpilot-backend)

---

## 🤖 AI Assistant (CoopMind)

The AI assistant provides:

- Smart farm insights
- Feed optimization suggestions
- Flock health analysis
- Expense and productivity insights
- Context-aware chat using farm data + history

Chat supports:

- Conversation history
- Persistent conversation IDs
- Multi-turn contextual responses

---

## 📦 Key Dependencies

```yaml
dependencies:
  flutter:
  flutter_riverpod:
  dio:
  go_router:
  intl:
  flutter_markdown:
  toastification:
```

---

## 🧪 Testing

Run tests:

```bash
flutter test
```

---

## 📌 Roadmap

- [ ] Offline-first support
- [ ] Voice AI assistant
- [ ] Multi-farm switching
- [ ] Advanced analytics dashboard
- [ ] IoT sensor integration
- [ ] Push notifications

---

## 🤝 Contributing

Contributions are welcome:

1. Fork repository
2. Create feature branch
3. Commit changes
4. Open Pull Request

---

## 📄 License

MIT License

---
