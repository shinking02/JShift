# JShift

SwiftUI 製のシフト管理・給与計算アプリです。Google アカウントでサインインし、Google カレンダーと同期しながら複数バイトの予定や給与を一元管理します。給与形態・締め日・休日／深夜手当・通勤手当・単発案件など、学生バイトの実情に合わせた細かな設定がアプリ内で完結します。

## 画面と機能

### シフトタブ
- Google カレンダーの予定を `CalendarManager` が Realm に同期し、カスタムカレンダー (`CalendarView`) で日別に表示。
- 予定ボトムシート (`ShiftSheetView`) から、Google イベント・単発バイト (`OneTimeJob`)・支給日表示をまとめて確認／編集。
- 過去 N 週間（既定は 3 週間）の実績を AI 的に再提案する「シフト提案」リストを搭載。`詳細設定 > シフトの提案` で無効化や参照期間の変更が可能。
- プル・トゥ・リフレッシュで Google カレンダーを再同期。支給日を ON にしているバイトは指定日に自動でシート内に出現します。
- LaunchScreen では Rive アニメーションを流しつつ Google サインインと初回同期完了を待機。復元済みセッションがあればそのまま `ContentView` に遷移します。

### 給与タブ
- `SalaryView` で月／年単位をワンタップ切り替え。`PagedInfiniteScrollView` によりスワイプで期間を移動できます。
- 給与構成は Apple Charts のドーナツチャートで可視化。通勤手当の含有／除外をトグルで切替。
- `SalaryManager` が Realm のシフト実績と SwiftData の wage 設定から、深夜 25%・休日 35%・通勤手当・休憩控除を考慮した見込み額を自動計算。確定額は `SalaryHistory` に手入力して保存できます。
- 単発バイト (`OneTimeJob`) の実績も同じ画面で集計し、給与 0 円のバイトを隠すオプションも用意しています。

### 設定タブ
- **アプリ情報**: `AppInfoView` が GitHub API から最新コミットを取得し、ビルドと比較して Shimmer エフェクト付きで表示。ワンタップでコミット一覧へ遷移。
- **バイト設定**: カラー、給与形態（時給／日給）、基本給履歴、給与実績、通勤手当、休憩ルール、深夜／休日手当、締め日・支給日、支給日表示の有無までフォームで完結。
- **カレンダー**: デフォルト追加先、同期対象カレンダー、バイト予定のみ表示モードを切替。
- **通知**: PermissionKit / NotificationPermission で権限を案内し、給料日通知を先行実装（現状は UI のみで通知送信は未実装と注記済み）。
- **詳細設定**: シフト提案と参照期間、給与 0 円のバイト表示をトグルで制御。
- **プロフィール**: Google アカウントのアイコン／名前／メールを CachedAsyncImage で表示し、サインアウト操作を提供。
- **開発者向けメニュー**: UserDefaults (JS_* キー) と Realm データのブラウザ、オンボーディング版数・SyncToken・Realm 全削除、擬似クラッシュ（Kill App）などローカル開発に便利なツールを搭載。
- **ライセンス一覧**: `LicenseList` を利用して依存 OSS をアプリ内で参照できます。

## 技術スタック / アーキテクチャ
- **UI**: SwiftUI + Observation。`AppState.shared` を `@Environment(AppState.self)` で共有し、Google サインイン状態や同期完了フラグを一元管理。
- **永続化**: バイト定義・単発案件は SwiftData (`JobSchemaV1`)、Google カレンダーイベントは Realm (`Event` モデル) に保存。`CalendarManager` 以外からの DB 変更は行わないポリシーです。
- **同期**: `CalendarManager` が Google Calendar API (`GoogleAPIClientForREST_Calendar`) を呼び出し、Sync Token を活用して差分取得。invalid token(410) もリカバリします。
- **認証**: GoogleSignIn SDK + `GoogleSignInManager`。アプリ起動時にセッション復元 → アカウントが無ければランチャーにサインインボタンを表示。
- **給与計算**: `SalaryManager` がイベント毎に通常／深夜分を分解し、休憩設定や休日割増・通勤手当を反映。`Storage` (UserDefaults) の各種フラグで UI と計算挙動を切替。
- **アニメーション / UX**: RiveRuntime（起動画面）、SwiftUI Shimmer（AppInfoView）、PagedInfiniteScrollView（給与スワイプ）、OBWelcomeView（アップデート案内）などを活用。

## データフロー概要
1. `JShiftApp` が SwiftData `ModelContainer` を初期化し、`LaunchScreenView` を表示。
2. `GoogleSignInManager.restorePreviousSignIn()` でセッション復元 → 成功時に `AppState` を更新。
3. `CalendarManager.syncGoogleCalendar()` がカレンダー一覧とイベントを並列取得し、Realm へ保存。SyncToken も `Storage` に退避。
4. 同期完了後に `ContentView` が表示され、タブ毎に `@Query` で SwiftData を監視しつつ、Realm イベントを ObservedResults で反映。
5. 給与タブでは `SalaryManager` が Realm イベント + SwiftData 設定を合成し、UI へ渡します。

## ディレクトリ構成
```
.
├── JShift/                 # アプリ本体（SwiftUI, SwiftData, Realm, Lib）
│   ├── Lib/                # GoogleSignIn, Calendar/Salary Manager, Storage, Utilities
│   ├── Models/             # AppState, CalendarManager, Realm/SwiftData モデル
│   ├── Views/              # Shift / Salary / Setting / Launch / Onboarding など
│   └── Assets, RiveAssets  # 画像・Rive ファイル
├── JShiftTests/            # ユニットテスト（Swift Testing プレースホルダ）
├── JShiftUITests/          # UI テストターゲット（テンプレート）
├── ci_scripts/             # Xcode Cloud / CI 用スクリプト
├── JShift.xcodeproj/       # Xcode プロジェクト & SPM 設定
└── LICENSE
```

## 開発環境
- macOS Sonoma 以降
- Xcode 16.x（iOS 18 SDK, Swift 5）
- CocoaPods は未使用。すべて Swift Package Manager で解決されます。

## セットアップ手順
1. リポジトリを取得
   ```bash
   git clone https://github.com/shinking02/JShift.git
   cd JShift
   ```
2. 初回は Xcode で `ci_scripts/ci_post_clone.sh` を呼び出す設定に合わせ、必要なら手動実行してパッケージプラグインの指紋チェックをスキップします。
   ```bash
   sh ci_scripts/ci_post_clone.sh
   ```
3. `open JShift.xcodeproj` でプロジェクトを開き、Swift Package の解決を待ちます。
4. 自前の Google API 資格情報を設定（次節参照）。
5. 任意で `Info.plist` の `CommitHash` をビルドスクリプトなどで差し替えると、AppInfoView のステータス判定が正しくなります。

## Google 認証 / カレンダー API 設定
1. Google Cloud Console で iOS 用 OAuth クライアントを作成し、`GIDClientID` と URL Scheme を `JShift/Info.plist` に設定。
2. Google Calendar API を有効にし、`GoogleSignInManager` が要求する `https://www.googleapis.com/auth/calendar` スコープを許可してください。
3. URL Types に OAuth のリダイレクト URI（`com.googleusercontent.apps.<CLIENT_ID>`）を追加。
4. `CalendarManager` はユーザーの全カレンダーを同期し、`設定 > カレンダー` で有効／無効を切替できるため、不要なカレンダーを OFF にしておくと Realm の肥大化を防げます。

## ビルド & テスト
```bash
# プロジェクトを開く
open JShift.xcodeproj

# Debug ビルド
xcodebuild -project JShift.xcodeproj -scheme JShift -configuration Debug

# 単体テスト（Swift Testing ベース）
xcodebuild test -project JShift.xcodeproj -scheme JShift \
  -destination 'platform=iOS Simulator,name=iPhone 15'

# クリーン
xcodebuild clean -project JShift.xcodeproj -scheme JShift
```
テストターゲットは雛形のみです。給与計算やカレンダー同期のロジックにテストを追加する場合は `JShiftTests/` 以下で `Testing` パッケージの API（`#expect` など）を利用してください。

## 開発時のヒント
- **Developer 設定**: シミュレータでも `設定 > 開発者向け` から UserDefaults / Realm の中身を確認したり、SyncToken をリセットできます。
- **App 情報カード**: `設定` 先頭の GitHub カードで最新コミットとの差分を即確認可能。Shimmer が消えれば比較完了です。
- **通知機能**: UI は実装済みですが、現状はサーバレス通知が未配信なためドキュメントどおり「開発段階」です。
- **ローカライズ**: すべて日本語固定。多言語化が必要な場合は `String` のハードコード部分から着手してください。

## 依存パッケージ（一部）
- GoogleSignIn / GoogleSignInSwift — OAuth サインイン。
- GoogleAPIClientForREST_Calendar — カレンダー一覧・イベント取得。
- RealmSwift — Google カレンダーイベントのローカルキャッシュ。
- SwiftData — `Job` / `OneTimeJob` などアプリ内データモデル。
- Charts — 給与チャート描画。
- RiveRuntime — 起動画面アニメーション。
- CachedAsyncImage — プロフィール画像のキャッシュ表示。
- LicenseList — OSS ライセンスビュー。
- PermissionsKit + NotificationPermission — 権限ダイアログ誘導。
- SwiftUI Shimmer — AppInfoView のローディング演出。

## 既知の制限 / TODO
- 通知配信は UI のみで、バックエンド連携はこれからです。
- ユニットテスト・UI テストはいずれもテンプレート状態です。給与計算や Google 同期の回帰防止にはテスト追加が必要です。
- UI テキストは日本語固定で、英語などのローカライズは未対応です。

## ライセンス
本リポジトリは [Apache License 2.0](LICENSE) で提供されています。

