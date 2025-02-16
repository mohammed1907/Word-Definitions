# 📖 WordDefinitions

## 📌 Overview
WordDefinitions is an iOS application built using **SwiftUI** and **MVVM-C (Model-View-ViewModel-Coordinator)** architecture. The app fetches word definitions from an API, caches the searched words using **Core Data**, and ensures smooth offline access.

## 🚀 Features
- **Search for Word Definitions** 🔍
- **Offline Mode** with **CoreData** for caching 🔄
- **Coordinator-based Navigation (MVVM-C)** 📌
- **Elegant UI with SwiftUI & Animations** 🎨
- **Unit Testing for ViewModels & Services** ✅

## 🏗️ Architecture
The project follows **MVVM-C (Model-View-ViewModel-Coordinator)**:
- **Model** → Defines the structure of words and caching logic.
- **ViewModel** → Handles business logic, API requests, and state management.
- **View** → SwiftUI views that render UI based on ViewModel data.
- **Coordinator** → Manages navigation between screens.

---
## 📂 Project Structure
```
📦 WordDefinitions
 ┣ 📂 App
 ┃ ┗ 📜 WordDefinitionsApp.swift
 ┣ 📂 Coordinator
 ┃ ┣ 📜 AppCoordinator.swift
 ┃ ┣ 📜 Coordinator.swift
 ┃ ┗ 📜 UIKitCoordinatorBridge.swift
 ┣ 📂 CoreData
 ┃ ┣ 📜 CachedWord+CoreDataClass.swift
 ┃ ┣ 📜 CachedWord+CoreDataProperties.swift
 ┃ ┣ 📜 CoreDataManager.swift
 ┃ ┗ 📜 DictionaryCache.swift
 ┣ 📂 Helpers
 ┣ 📂 Network
 ┃ ┣ 📜 APIErrorResponse.swift
 ┃ ┣ 📜 DictionaryApi.swift
 ┃ ┣ 📜 NetworkError.swift
 ┃ ┗ 📜 NetworkManager.swift
 ┣ 📂 Scenes
 ┃ ┣ 📂 Details
 ┃ ┃ ┣ 📂 View
 ┃ ┃ ┃ ┗ 📜 WordDetailsView.swift
 ┃ ┃ ┗ 📂 ViewModel
 ┃ ┃ ┃ ┗ 📜 WordDetailsViewModel.swift
 ┃ ┣ 📂 Search
 ┃ ┃ ┣ 📂 Model
 ┃ ┃ ┃ ┗ 📜 DictionaryWordModel.swift
 ┃ ┃ ┣ 📂 Service
 ┃ ┃ ┃ ┗ 📜 DictionaryService.swift
 ┃ ┃ ┣ 📂 View
 ┃ ┃ ┃ ┣ 📂 View Items
 ┃ ┃ ┃ ┃ ┣ 📜 WordRowView.swift
 ┃ ┃ ┃ ┃ ┗ 📜 SearchView.swift
 ┃ ┃ ┃ ┗ 📂 ViewModel
 ┃ ┃ ┃ ┃ ┗ 📜 SearchViewModel.swift
 ┃ ┃ ┗ 📜 SplashScreenView.swift
 ┣ 📂 Assets
 ┣ 📂 Tests
 ┃ ┣ 📜 MockCoreDataManager.swift
 ┃ ┗ 📜 MockDictionaryService.swift
 ┗ 📜 README.md
```

---
## 🛠️ Technologies Used
- **SwiftUI** – UI framework
- **Combine** – Reactive programming for API calls
- **Moya** – Network layer for API requests
- **Core Data** – Caching mechanism for offline mode
- **Unit Testing** – XCTest framework for ViewModels & Services

---
## 🔍 How to Run
1. Clone the repository
2. Open `WordDefinitions.xcodeproj`
3. Ensure **Xcode 15+** is installed
4. Run `⌘ + R` to build and run the app on the simulator


---
## 📜 License
This project is open-source and available under the **MIT License**.

