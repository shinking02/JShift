# JShift - Code Style & Conventions

## Swift Code Style
- **Naming**: キャメルケース (camelCase) を使用
- **Properties**: `@State`, `@Environment`, `@Observable` の適切な使用
- **Access Modifiers**: `private` を積極的に使用してカプセル化
- **Model Classes**: `@Model` アノテーションでSwiftDataモデルを定義
- **View Architecture**: SwiftUIのViewプロトコルに従った構造化

## File Organization
- **Views**: 機能別にフォルダ分け (`Shift/`, `Salary/`, `Setting/`)
- **Models**: データモデルは `Models/` フォルダ
- **Utilities**: 共通機能は `Lib/` フォルダ
- **Parts**: UIコンポーネントは各機能の `Parts/` サブフォルダ

## Import Organization
標準的な順序:
1. Foundation frameworks
2. SwiftUI/SwiftData
3. Third-party libraries
4. Internal modules

例:
```swift
import Foundation
import SwiftUI
import SwiftData
import GoogleSignIn
```

## Data Management
- **SwiftData**: メインのデータ永続化
- **@Observable**: 状態管理 (AppState)
- **Environment**: データの依存性注入
- **ModelContainer**: SwiftDataコンテナの初期化

## Naming Conventions
- **Files**: PascalCase (ContentView.swift)
- **Classes/Structs**: PascalCase (AppState, ContentView)
- **Properties/Functions**: camelCase (isSignedIn, finishFirstSyncProcess)
- **Constants**: camelCase (AVAIABLE_OB_VERSION)

## View Structure Pattern
```swift
struct SomeView: View {
    @State private var someState = defaultValue
    @Environment(AppState.self) private var appState
    
    var body: some View {
        // View implementation
    }
    
    // Private helper methods
    private func someHelper() {
        // Implementation
    }
}
```

## Error Handling
- `fatalError()` を初期化エラーに使用
- Optional handling with nil coalescing
- Task-based async/await pattern

## Localization
- 日本語文字列をハードコード
- システムアイコンの使用 (`systemImage`)
- 日本語のUI表示に対応