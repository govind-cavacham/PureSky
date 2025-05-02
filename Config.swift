import Foundation

enum Config {
    // API Keys
    static let weatherAPIKey = "b1703b267cd747a68f943735250205" // WeatherAPI.com key
    static let revenueCatAPIKey = "YOUR_REVENUECAT_API_KEY"
    
    // Firebase Configuration
    static let firebaseConfig: [String: Any] = [:]
    
    // App Settings
    static let defaultLocation = "Mumbai, IN"
    static let refreshInterval: TimeInterval = 1800 // 30 minutes
    
    // Premium Features
    static let premiumMonthlyPrice = "₹299"
    static let premiumYearlyPrice = "₹1999"
    static let freeTrialDays = 3
    
    // Notification Settings
    static let morningNotificationTime = "08:00"
    static let eveningNotificationTime = "20:00"
    
    // Theme Colors
    static let primaryColor = "purple"
    static let secondaryColor = "indigo"
    static let accentColor = "pink"
    
    // URLs
    static let privacyPolicyURL = "https://puresky.app/privacy"
    static let termsOfServiceURL = "https://puresky.app/terms"
    static let supportEmail = "support@puresky.app"
    
    // App Store
    static let appStoreID = "YOUR_APP_STORE_ID"
    static let appStoreURL = "https://apps.apple.com/app/id\(appStoreID)"
} 