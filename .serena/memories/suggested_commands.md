# JShift - Suggested Development Commands

## System Information
- **Platform**: macOS (Darwin)
- **Project Type**: Xcode iOS project (.xcodeproj)
- **Architecture**: iOS App with SwiftUI

## Build & Development Commands

### ⚠️ Xcode Required
このプロジェクトはXcodeプロジェクト形式のため、以下のコマンドにはXcodeの完全版が必要です。
Command Line Toolsのみでは不十分です。

### Primary Development
```bash
# Xcodeでプロジェクトを開く
open JShift.xcodeproj

# Xcodeから直接実行:
# - Cmd+R: ビルド&実行
# - Cmd+U: テスト実行
# - Cmd+Shift+K: クリーンビルド
```

### Alternative Commands (Xcode installed)
```bash
# プロジェクト情報の表示
xcodebuild -list -project JShift.xcodeproj

# ビルド (Release configuration)
xcodebuild -project JShift.xcodeproj -scheme JShift -configuration Release

# テスト実行
xcodebuild test -project JShift.xcodeproj -scheme JShift -destination 'platform=iOS Simulator,name=iPhone 15'

# アーカイブ作成
xcodebuild archive -project JShift.xcodeproj -scheme JShift -archivePath ./build/JShift.xcarchive
```

### Git Operations
```bash
# 現在のブランチ確認
git branch

# 変更状況確認  
git status

# コミット
git add .
git commit -m "commit message"

# リモートにプッシュ
git push origin <branch-name>
```

### File Operations (macOS)
```bash
# ファイル検索
find . -name "*.swift" -type f

# 内容検索
grep -r "検索文字列" JShift/

# ディレクトリ構造表示
tree JShift/ # (要brew install tree)

# ファイルリスト
ls -la JShift/
```

### Package Dependencies
SwiftパッケージはXcode内で管理:
- File → Add Package Dependencies
- Package.swiftは不使用 (Xcodeプロジェクト形式のため)

### CI/CD
```bash
# CI post-clone script実行
sh ci_scripts/ci_post_clone.sh
```

## Development Notes
1. **Xcode必須**: このプロジェクトはXcodeでの開発が前提
2. **Simulator**: iOS Simulatorでの動作確認が必要
3. **Apple Developer**: 実機テストには開発者アカウントが必要
4. **Code Signing**: 証明書とProvisioning Profileの設定が必要

## Task Completion Commands
コード変更後の推奨手順:
1. Xcodeでビルド確認 (Cmd+B)
2. テスト実行 (Cmd+U)  
3. 実機またはシミュレータでの動作確認
4. Git commit & push