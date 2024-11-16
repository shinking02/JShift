import GoogleSignIn
import SwiftData
import SwiftUI

@main
struct JShiftApp: App {
    @State private var appState: AppState = .shared
    private let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Job.self, OneTimeJob.self)
        } catch {
            fatalError("Failed to initialize model container.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .onAppear {
                    Task {
                        await GoogleSignInManager.restorePreviousSignIn()
                    }
                }
                .environment(appState)
                .modelContainer(container)
        }
    }
}
