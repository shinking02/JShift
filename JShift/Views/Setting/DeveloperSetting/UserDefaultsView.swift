import SwiftUI

struct UserDefaultsView: View {
    var body: some View {
        let keyList = UserDefaults.standard.dictionaryRepresentation()
            .filter { $0.key.starts(with: "JS_") }
            .sorted(by: { $0.key < $1.key })
        List {
            ForEach(keyList, id: \.key) { key, value in
                VStack(alignment: .leading) {
                    Text(key)
                    Text("\(value)")
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("UserDefaults")
        .navigationBarTitleDisplayMode(.inline)
        .overlay {
            if keyList.isEmpty {
                ContentUnavailableView {
                    Label("No Storage Data", image: "custom.doc.badge.exclamationmark")
                } description: {
                    Text("UserDefaults data starting with  JS_ does not exist")
                }
            }
        }
    }
}
