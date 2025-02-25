import Foundation

enum UserDefaultsKeys {
    static let googleSyncTokens = "JS_GOOGLE_SYNC_TOKENS"
    static let lastSeenOnboardingVersion = "JS_LAST_SEEN_ONBOARDING_VERSION"
    static let defaultCalendarId = "JS_DEFAULT_CALENDAR_ID"
    static let disableCalendarIds = "JS_DISABLE_CALENDAR_IDS"
    static let isShowOnlyJobEvent = "JS_IS_SHOW_ONLY_JOBEVENT"
    static let enableSalaryPaymentNotification = "JS_ENABLE_SALARY_PAYMENT_NOTIFICATION"
    static let isDisableEventSuggest = "JS_IS_DISABLE_EVENT_SUGGEST"
    static let eventSuggestIntervalWeek = "JS_EVENT_SUGGEST_INTERVAL_WEEK"
    static let isDisableDisplayZeroSalaryJob = "JS_IS_DISABLE_DISPLAY_ZERO_SALARY_JOB"
}

struct Storage {
    static func getDisableCalendarIds() -> [String] {
        return UserDefaults.standard.stringArray(forKey: UserDefaultsKeys.disableCalendarIds) ?? []
    }
    static func setDisableCalendarIds(_ ids: [String]) {
        UserDefaults.standard.set(ids, forKey: UserDefaultsKeys.disableCalendarIds)
    }
    static func getIsShowOnlyJobEvent() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isShowOnlyJobEvent)
    }
    static func setIsShowOnlyJobEvent(_ isShowOnlyJobEvent: Bool) {
        UserDefaults.standard.set(isShowOnlyJobEvent, forKey: UserDefaultsKeys.isShowOnlyJobEvent)
    }
    static func getDefaultCalendarId() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.defaultCalendarId) ?? ""
    }
    static func setDefaultCalendarId(_ id: String) {
        UserDefaults.standard.set(id, forKey: UserDefaultsKeys.defaultCalendarId)
    }
    static func getEnableSalaryPaymentNotification() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsKeys.enableSalaryPaymentNotification)
    }
    static func setEnableSalaryPaymentNotification(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKeys.enableSalaryPaymentNotification)
    }
    static func getLastSeenOnboardingVersion() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.lastSeenOnboardingVersion) ?? ""
    }
    static func setLastSeenOnboardingVersion(_ version: String) {
        UserDefaults.standard.set(version, forKey: UserDefaultsKeys.lastSeenOnboardingVersion)
    }
    private static func getGoogleSyncTokens() -> [String: String] {
        return UserDefaults.standard.dictionary(forKey: UserDefaultsKeys.googleSyncTokens) as? [String: String] ?? [:]
    }
    private static func setGoogleSyncTokens(_ tokens: [String: String]) {
        UserDefaults.standard.set(tokens, forKey: UserDefaultsKeys.googleSyncTokens)
    }
    static func getGoogleSyncToken(for calendarId: String) -> String {
        return getGoogleSyncTokens()[calendarId] ?? ""
    }
    static func setGoogleSyncToken(for calendarId: String, token: String) {
        var tokens = getGoogleSyncTokens()
        tokens[calendarId] = token
        setGoogleSyncTokens(tokens)
    }
    static func getIsDisableEventSuggest() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isDisableEventSuggest)
    }
    static func setIsDisableEventSuggest(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKeys.isDisableEventSuggest)
    }
    static func getEventSuggestIntervalWeek() -> Int {
        return UserDefaults.standard.integer(forKey: UserDefaultsKeys.eventSuggestIntervalWeek)
    }
    static func setEventSuggestIntervalWeek(_ value: Int) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKeys.eventSuggestIntervalWeek)
    }
    static func getIsDisableDisplayZeroSalaryJob() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isDisableDisplayZeroSalaryJob)
    }
    static func setIsDisableDisplayZeroSalaryJob(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKeys.isDisableDisplayZeroSalaryJob)
    }
}
