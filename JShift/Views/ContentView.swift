import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .shift
    @State private var isWelcomePresented = false
    @Environment(\.openURL) private var openURL
    private let AVAIABLE_OB_VERSION = "3"
    
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
                        .init(title: "給料表示", description: "給料が0円のバイトを表示しないオプションを追加しました。設定画面の詳細から確認してみてください。", symbolName: "lightbulb.max.fill", tintColor: UIColor(.yellow)),
                        .init(title: "勤務日", description: "勤務期間が誤っている不具合やその他の軽微な不具合を修正しました。", symbolName: "calendar"),
                        .init(title: "Github", description: "アプリのコミットハッシュを取得できない不具合を修正しました。", symbolName: "externaldrive.fill.badge.questionmark", tintColor: UIColor(.green))
                    ],
                    boldButtonItem: .init(title: "続ける", action: {
                        isWelcomePresented = false
                    }),
                    linkButtonItem: .init(title: "詳細", action: { openURL(URL(string: "https://github.com/shinking02/JShift/pull/1")!) })
                )
            }
        )
    }
}
