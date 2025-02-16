# 📖 Dictionary App
A SwiftUI-based dictionary app that allows users to search for word definitions using an API, with offline caching, structured navigation using **MVVM-C architecture**, and proper **error handling**.

---

## 📌 Features
✅ **MVVM-C Architecture** for clean and maintainable code  
✅ Search for word definitions via **Dictionary API**  
✅ **Core Data caching** for offline access  
✅ **Coordinator-based navigation** for scalability  
✅ **Debounced search** for optimized performance  
✅ **Error handling & toast messages** for API failures  
✅ **Unit-tested** using XCTest  

---

## 📂 Project Structure
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
 ┃ ┃ 📜 MockDictionaryService.swift
 ┗ 📜 README.md


