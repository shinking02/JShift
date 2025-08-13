# JShift - Project Overview

## Project Purpose
JShiftは日本語対応のシフト管理・給与計算iOSアプリです。アルバイトやパートタイムの勤務時間を記録し、給与を自動計算する機能を提供します。

## Key Features
- シフト管理とカレンダー表示
- 給与計算と履歴表示 
- 複数のジョブ設定管理
- Google認証によるサインイン機能
- 通知機能
- 年間給与チャート表示
- 単発バイト記録機能

## Tech Stack
- **Language**: Swift
- **Framework**: SwiftUI
- **Data Persistence**: SwiftData (Core Data successor)
- **Architecture**: MVVM with @Observable
- **Deployment Target**: iOS

## Key Dependencies
- **GoogleSignIn**: Google認証
- **SwiftData**: データ永続化
- **Charts**: グラフ表示
- **RealmSwift**: 一部データベース操作
- **PermissionsKit/NotificationPermission**: 通知許可管理
- **CachedAsyncImage**: 画像キャッシュ
- **Shimmer**: アニメーション効果
- **LicenseList**: ライセンス表示
- **RiveRuntime**: アニメーション（起動画面）

## Project Structure
```
JShift/
├── JShiftApp.swift           # アプリエントリーポイント
├── Models/                   # データモデル
│   ├── AppState.swift        # アプリ状態管理
│   ├── SwiftData/           # SwiftDataスキーマ
│   │   ├── JobSchemaV1.swift # Job/OneTimeJobモデル
│   │   ├── JobUtils.swift    
│   │   └── JobExtension.swift
│   ├── Event.swift
│   ├── CalendarManager.swift
│   └── UserCalendar.swift
├── Views/                    # UI層
│   ├── ContentView.swift     # メインタブビュー
│   ├── Shift/               # シフト関連UI
│   ├── Salary/              # 給与関連UI  
│   └── Setting/             # 設定関連UI
└── Lib/                     # ユーティリティ
    ├── GoogleSignInManager.swift
    ├── SalaryManager.swift
    ├── Storage.swift
    └── その他ヘルパー
```

## Current Version
Version 1.0.5 (MARKETING_VERSION in project settings)