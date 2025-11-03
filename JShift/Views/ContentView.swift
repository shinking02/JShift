import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .shift
    @State private var isWelcomePresented = false
    @Environment(\.openURL) private var openURL
    private let AVAIABLE_OB_VERSION = "5(last)"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ShiftView(isWelcomePresented: $isWelcomePresented)
                .tag(Tab.shift)
                .tabItem {
                    Label(Tab.shift.rawValue, systemImage: Tab.shift.symbol)
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.bar, for: .tabBar)
            SalaryView()
                .tag(Tab.salary)
                .tabItem {
                    Label(Tab.salary.rawValue, systemImage: Tab.salary.symbol)
                }
            SettingView()
                .tag(Tab.setting)
                .tabItem {
                    Label(Tab.setting.rawValue, systemImage: Tab.setting.symbol)
                }
        }
        .onAppear {
            isWelcomePresented = Storage.getLastSeenOnboardingVersion() != AVAIABLE_OB_VERSION
        }
        .sheet(
            isPresented: $isWelcomePresented,
            onDismiss: {
                Storage.setLastSeenOnboardingVersion(AVAIABLE_OB_VERSION)
            },
            content: {
                OBWelcomeView(
                    title: "アップデート内容",
                    detailText: "",
                    bulletedListItems: [
                        .init(title: "iOS 26に対応 🎉", description: "iOS 26対応と軽微な不具合の修正", symbolName: "apple.logo", tintColor: UIColor(.green)),
                    ],
                    boldButtonItem: .init(title: "続ける", action: {
                        isWelcomePresented = false
                    }),
                    linkButtonItem: .init(title: "詳細", action: { openURL(URL(string: "https://github.com/shinking02/JShift/pull/12")!) })
                )
            }
        )
    }
}
