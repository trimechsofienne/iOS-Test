# TheGoodCorner

TheGoodCorner displays a list of classified ads, supports category filtering, real-time debounced search, and offers a complete detail view.


## 🤖 AI Usage

### Tools used

I used AI tools (ChatGPT) to:
- clarify SwiftUI behaviors (state updates, layout issues, ScrollView rendering)
- validate accessibility best practices (VoiceOver, accessibility labels, header traits)
- review architectural trade-offs (MVVM, Coordinator, dependency injection)
- identify potential edge cases (image loading failures, empty states, filtering logic)
- sanity-check concurrency usage (async/await patterns, MainActor usage, parallel requests with async let)

All suggestions were reviewed and adapted before integration. I did not rely on AI to generate full features, but rather to challenge and refine my decisions.

---

### AI suggestions I rejected or rewrote

One suggestion was to introduce DTOs to strictly separate API models from domain models.

I chose not to adopt this approach because:
- the API contract is simple and stable
- adding DTOs would introduce unnecessary boilerplate
- it would not bring significant value for this scope

Another suggestion was to modularize the project using Swift Package Manager (SPM).

I decided not to use SPM because:
- the project is relatively small
- modularization would increase setup complexity
- a single target with clear folder-based separation is sufficient and easier to navigate

I also simplified some overly complex suggestions around state management to keep the ViewModel readable and focused.

---

### Architectural decisions I owned

I implemented a lightweight architecture combining MVVM with a Coordinator pattern.

Key decisions:

- **MVVM**  
  To separate UI (SwiftUI Views) from business logic (ViewModels)

- **Coordinator pattern**  
  Introduced to handle navigation outside of views and keep them declarative

- **Repository pattern**  
  Used to abstract data access and make the ViewModel easily testable

- **Dependency Injection**  
  All dependencies (repository, baseURL) are injected, avoiding singletons and improving testability

- **Concurrency model**  
  Used `async/await` and structured concurrency (`async let`) for parallel API calls  
  Combine is used only for debounced search input

- **UI state management**  
  Centralized state (`ViewState`) in the ViewModel to handle loading, error, and success states

The focus was on clarity, maintainability, and testability.


## 🚀 Features

- **Architecture**: Built with MVVM + Coordinator + Dependency Injection. No Singletons in Views, highly testable.
- **Concurrency**: Strictly written with Swift `async/await`, structured concurrency (`async let`), and `@MainActor` isolation.
- **Swift 6 Compliant**: All value types are `Sendable` and `nonisolated` where needed for strict concurrency checking.
- **Debounced Search**: Debounced search using Combine.
- **Design System**: Centralized constants for spacing, typography, and colors.
- **Accessibility**: Supports VoiceOver, Dynamic Type, and meaningful accessibility labels.
- **Error Handling**: Graceful fallback for image loading and network failures.

## 🛠 Tech Stack

- **SwiftUI** (iOS 16+)
- **Swift 6** (Strict Concurrency)
- **Combine** (Used strictly for debounce on TextFields)
- **XCTest** (ViewModel logic, API decoding, and Endpoint validation)

## 📁 Project Structure

```text
TheGoodCorner/
├── App/            # Entry point, DIContainer, Coordinator, Configuration
├── Models/         # Decodable/Sendable domain models (Listing, Category)
├── Network/        # Protocol-oriented API Client, Endpoints, HTTP Errors
├── Repositories/   # Data access layer connecting ViewModel to Network
├── Features/       # Modules (Listings, Detail) with Views and ViewModels
├── Shared/         # Reusable Components (ErrorState, AsyncImage, Chips)
├── DesignSystem/   # Tokens (Theme, Typography, Spacing, Icon)
└── Resources/      # LocalizedStrings, Assets, Info.plist
```

## 🧪 Testing

The project includes unit tests for critical paths:
1. **Decoding Tests**: Validates `snake_case` mapping, unknown fields, and `double-nullable` image responses.
2. **Endpoint Tests**: Verifies `URLRequest` parameters and query items.
3. **Repository Tests**: Verifies API endpoint delegation.
4. **ViewModel Tests**: Uses a `MockListingRepository` to validate state transitions (`.idle`, `.loading`, `.error`), category filtering, and category name mapping.


## 👨‍💻 Author

Created by Sofienne Trimech
