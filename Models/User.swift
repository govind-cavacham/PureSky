import Foundation
import UIKit
import SwiftUI
import FirebaseAuth

struct User: Identifiable, Codable {
    let id: String
    let email: String
    var name: String
    var isPremium: Bool
    var preferences: UserPreferences?
    
    init(id: String, email: String, name: String, isPremium: Bool, preferences: UserPreferences? = nil) {
        self.id = id
        self.email = email
        self.name = name
        self.isPremium = isPremium
        self.preferences = preferences
    }
}

struct UserPreferences: Codable {
    var notificationsEnabled: Bool
    var darkModeEnabled: Bool
    var selectedTheme: String
    
    init(notificationsEnabled: Bool = true, darkModeEnabled: Bool = false, selectedTheme: String = "default") {
        self.notificationsEnabled = notificationsEnabled
        self.darkModeEnabled = darkModeEnabled
        self.selectedTheme = selectedTheme
    }
}

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var isPremium = false
    @Published var isLoading = false
    @Published var error: Error?
    @Published var showPremiumUpgrade = false
    @Published var showSignIn = false
    
    init() {
        // Initialize with current user if available
        if let firebaseUser = Auth.auth().currentUser {
            self.user = User(
                id: firebaseUser.uid,
                email: firebaseUser.email ?? "",
                name: firebaseUser.displayName ?? "",
                isPremium: false
            )
        }
        
        #if DEBUG
        // During development, enable premium features
        self.isPremium = true
        #endif
    }
    
    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            await MainActor.run {
                self.user = User(
                    id: result.user.uid,
                    email: result.user.email ?? "",
                    name: result.user.displayName ?? "",
                    isPremium: false
                )
            }
        } catch {
            throw error
        }
    }
    
    func signUp(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            await MainActor.run {
                self.user = User(
                    id: result.user.uid,
                    email: result.user.email ?? "",
                    name: result.user.displayName ?? "",
                    isPremium: false
                )
            }
        } catch {
            throw error
        }
    }
    
    func signOut() throws {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.isPremium = false
        } catch {
            throw error
        }
    }
    
    func upgradeToPremium(plan: String) async throws {
        // Implement RevenueCat purchase logic here
        // For now, just simulate a successful upgrade
        await MainActor.run {
            self.isPremium = true
        }
    }
    
    func saveUserPreferences(_ preferences: UserPreferences) {
        // Save preferences to UserDefaults or Firebase
        UserDefaults.standard.set(preferences.notificationsEnabled, forKey: "notificationsEnabled")
        UserDefaults.standard.set(preferences.darkModeEnabled, forKey: "darkModeEnabled")
        UserDefaults.standard.set(preferences.selectedTheme, forKey: "selectedTheme")
    }
    
    func loadUserPreferences() -> UserPreferences {
        // Load preferences from UserDefaults or Firebase
        return UserPreferences(
            notificationsEnabled: UserDefaults.standard.bool(forKey: "notificationsEnabled"),
            darkModeEnabled: UserDefaults.standard.bool(forKey: "darkModeEnabled"),
            selectedTheme: UserDefaults.standard.string(forKey: "selectedTheme") ?? "default"
        )
    }
    
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    func rateApp() {
        // In a real app, this would open the App Store rating page
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/idYOUR_APP_ID?action=write-review") else { return }
        UIApplication.shared.open(url)
    }
} 