# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

JShift is an iOS shift management and salary calculation app built with SwiftUI and SwiftData. The app helps users track work shifts, calculate salaries, and manage multiple job information with Google Sign-In authentication.

## Development Commands

### Build and Test
```bash
# Open project in Xcode (required for development)
open JShift.xcodeproj

# Build project (requires Xcode installation)
xcodebuild -project JShift.xcodeproj -scheme JShift -configuration Debug

# Run tests
xcodebuild test -project JShift.xcodeproj -scheme JShift -destination 'platform=iOS Simulator,name=iPhone 15'

# Clean build
xcodebuild clean -project JShift.xcodeproj -scheme JShift
```

### CI Script
```bash
# Run CI post-clone script
sh ci_scripts/ci_post_clone.sh
```

## Architecture Overview

### Core Architecture
- **Framework**: SwiftUI with MVVM pattern
- **Data Layer**: SwiftData for persistence with schema versioning (JobSchemaV1)
- **State Management**: @Observable pattern with shared AppState
- **Authentication**: Google Sign-In integration
- **Navigation**: TabView-based with three main sections

### Key Data Models
- **Job**: Primary work entity with wages, breaks, salary calculations
- **OneTimeJob**: Single-occurrence work entries  
- **AppState**: Global app state (sign-in status, user info, sync processes)
- **JobUtils**: Supporting types (JobColor, JobSalaryType, JobBreak, JobWage, JobSalary, JobEventSummary)

### App Structure
```
ContentView (TabView)
├── ShiftView - Calendar and shift management
├── SalaryView - Salary calculations and history
└── SettingView - App configuration and job management
```

### Data Flow
1. **Initialization**: JShiftApp creates ModelContainer for SwiftData
2. **State Management**: AppState.shared manages global state via @Observable
3. **Authentication**: GoogleSignInManager handles auth state and restores sessions
4. **Data Persistence**: SwiftData with versioned schemas, RealmSwift for legacy data
5. **UI Updates**: SwiftUI's reactive system with @Environment and @State

### Key Dependencies
- **GoogleSignIn/GoogleSignInSwift**: Authentication
- **SwiftData**: Primary data persistence
- **RealmSwift**: Legacy database operations
- **Charts**: Salary visualization
- **CachedAsyncImage**: Profile image handling
- **PermissionsKit/NotificationPermission**: System permissions
- **Shimmer**: Loading animations
- **RiveRuntime**: Launch screen animations

## Important Notes

### Commit Message Convention
Follow Angular convention with prefixes:
- `feat:` New features
- `fix:` Bug fixes  
- `docs:` Documentation changes
- `style:` Code formatting
- `refactor:` Code restructuring
- `perf:` Performance improvements
- `test:` Testing changes
- `chore:` Build/tool changes

Messages should be under 50 characters including prefix, in English, imperative mood. Do not end with a trailing period.

### SwiftData Schema Management
- Models are versioned (currently JobSchemaV1)
- Schema changes require migration planning
- Both Job and OneTimeJob models share the same container

### Google Sign-In Configuration
- Client ID configured in Info.plist
- URL scheme setup for OAuth callback
- Sign-in state restoration on app launch

### Pull Request Guidelines
When creating PRs for issues:
- Include `close #N` in PR description to auto-close the issue
- Use the same title as the corresponding issue
- Add the `Claude Code` label: `gh pr edit <PR_NUMBER> --add-label "Claude Code"`

### Localization
- UI uses Japanese text (hardcoded strings)
- System SF Symbols for icons
- Tab enum defines Japanese labels with English symbol names