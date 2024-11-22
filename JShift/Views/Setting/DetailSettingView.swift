import SwiftUI

struct DetailSettingView: View {
    @State private var isEnableEventSuggest: Bool = false
    @State private var suggestEventIntervalWeek: Int = 0
    @State private var isEnableDisplayZeroSalaryJob: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Toggle("シフトの提案", isOn: $isEnableEventSuggest)
                        .onChange(of: isEnableEventSuggest) {
                            Storage.setIsDisableEventSuggest(!isEnableEventSuggest)
                        }
                    if isEnableEventSuggest {
                        Picker("提案に使用する期間", selection: $suggestEventIntervalWeek) {
                            ForEach(1...5, id: \.self) { week in
                                Text("\(week)週間")
                            }
                        }
                        .onChange(of: suggestEventIntervalWeek) {
                            Storage.setEventSuggestIntervalWeek(suggestEventIntervalWeek)
                        }
                    }
                }
                Section {
                    Toggle("給与が0円のバイトを表示", isOn: $isEnableDisplayZeroSalaryJob)
                        .onChange(of: isEnableDisplayZeroSalaryJob) {
                            Storage.setIsDisableDisplayZeroSalaryJob(!isEnableDisplayZeroSalaryJob)
                        }
                }
            }
            .navigationTitle("詳細")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                isEnableEventSuggest = !Storage.getIsDisableEventSuggest()
                suggestEventIntervalWeek = Storage.getEventSuggestIntervalWeek() == 0 ? 3 : Storage.getEventSuggestIntervalWeek()
                isEnableDisplayZeroSalaryJob = !Storage.getIsDisableDisplayZeroSalaryJob()
            }
        }
    }
}
