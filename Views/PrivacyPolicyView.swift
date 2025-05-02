import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Group {
                    Text("Privacy Policy")
                        .font(.title)
                        .bold()
                    
                    Text("Last updated: May 2, 2024")
                        .foregroundColor(.secondary)
                    
                    Text("Welcome to PureSky")
                        .font(.headline)
                    Text("This Privacy Policy explains how we collect, use, and protect your personal information when you use our app.")
                    
                    Text("Information We Collect")
                        .font(.headline)
                    Text("• Location data for weather forecasts\n• Email address for account creation\n• Usage data to improve our services")
                    
                    Text("How We Use Your Information")
                        .font(.headline)
                    Text("• To provide accurate weather forecasts\n• To deliver personalized cosmic guidance\n• To improve our services\n• To communicate with you about updates")
                }
                
                Group {
                    Text("Data Security")
                        .font(.headline)
                    Text("We implement appropriate security measures to protect your personal information from unauthorized access or disclosure.")
                    
                    Text("Third-Party Services")
                        .font(.headline)
                    Text("We use the following third-party services:\n• OpenWeatherMap for weather data\n• Firebase for authentication\n• RevenueCat for subscriptions")
                    
                    Text("Your Rights")
                        .font(.headline)
                    Text("You have the right to:\n• Access your personal data\n• Correct inaccurate data\n• Request deletion of your data\n• Opt-out of communications")
                    
                    Text("Contact Us")
                        .font(.headline)
                    Text("If you have any questions about this Privacy Policy, please contact us at \(Config.supportEmail)")
                }
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
    }
}

#Preview {
    NavigationView {
        PrivacyPolicyView()
    }
} 