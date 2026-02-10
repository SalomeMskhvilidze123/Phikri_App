Phikri (ფიქრი)
A modular iOS application focused on emotional tracking and thought journaling, built with Clean Architecture and Domain-Driven Design (DDD) principles.

 Architecture & Modularity
The project is strictly decoupled into independent modules using Swift Package Manager (SPM) to ensure high testability and separation of concerns.

1. PhikriDomain (Core Module)
The heart of the application. It contains purely business logic and is dependency free.

Entities: Pure data models like Thought.

Repository Protocols: Abstract interfaces that define data requirements.

Use Cases: Specific business logic orchestrators.

2. PhikriData (Infrastructure Module)
Handles data persistence using Core Data.

Implementation: Conforms to Domain repository protocols using Dependency Inversion.

Data Mapping: Converts internal ThoughtEntity (Managed Objects) into clean Thought models for the Domain.

Error Translation: Maps low-level persistence errors into user centric meaningful DomainError types.

3. PhikriApp (Main Target)
The composition root and UI layer.

UI: Built with SwiftUI using the MVVM pattern.

Dependency Injection: Injects concrete repository implementations from PhikriData into the Domain's logic.

 Tech Stack
Language: Swift 5.9+

UI Framework: SwiftUI

Persistence: Core Data

Architecture: Clean Architecture + Modular SPM

Concurrency: Swift Concurrency (Async/Await)