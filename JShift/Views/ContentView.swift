import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .shift
    @State private var isWelcomePresented = false
    @Environment(\.openURL) private var openURL
    private let AVAIABLE_OB_VERSION = "4"
    
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
                        .init(title: "チャート", description: "年間給与のチャートを復活させました。", symbolName: "chart.bar.xaxis.ascending", tintColor: UIColor(.green)),
                        .init(title: "給与表示", description: "給与の表示順を給与の高い順に変更しました。", symbolName: "arrow.up.arrow.down", tintColor: UIColor(.blue)),
                    ],
                    boldButtonItem: .init(title: "続ける", action: {
                        isWelcomePresented = false
                    }),
                    linkButtonItem: .init(title: "詳細", action: { openURL(URL(string: "https://github.com/shinking02/JShift/commit/2bb25dfe5a226385cea768bd6562368fe5018ade")!) })
                )
            }
        )
    }
}
