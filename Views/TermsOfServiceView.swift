import SwiftUI

struct TermsOfServiceView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Group {
                    Text("Terms of Service")
                        .font(.title)
                        .bold()
                    
                    Text("Last updated: May 2, 2024")
                        .foregroundColor(.secondary)
                    
                    Text("1. Acceptance of Terms")
                        .font(.headline)
                    Text("By accessing and using PureSky, you agree to be bound by these Terms of Service and all applicable laws and regulations.")
                    
                    Text("2. Description of Service")
                        .font(.headline)
                    Text("PureSky provides weather forecasts, cosmic guidance, and spiritual insights through various features including:\n• Real-time weather updates\n• Tarot readings\n• Moon phase tracking\n• Personalized astrology forecasts")
                    
                    Text("3. User Accounts")
                        .font(.headline)
                    Text("• You must be at least 13 years old to use the service\n• You are responsible for maintaining the confidentiality of your account\n• You agree to provide accurate and complete information")
                }
                
                Group {
                    Text("4. Subscription and Payments")
                        .font(.headline)
                    Text("• Premium features require a subscription\n• Subscriptions automatically renew unless cancelled\n• Refunds are subject to App Store policies")
                    
                    Text("5. User Conduct")
                        .font(.headline)
                    Text("You agree not to:\n• Use the service for any illegal purpose\n• Attempt to gain unauthorized access\n• Interfere with the proper functioning of the service")
                    
                    Text("6. Intellectual Property")
                        .font(.headline)
                    Text("All content and materials available in PureSky are protected by intellectual property rights and are the property of PureSky or its licensors.")
                    
                    Text("7. Limitation of Liability")
                        .font(.headline)
                    Text("PureSky is provided 'as is' without any warranties. We are not liable for any damages arising from the use of our service.")
                    
                    Text("8. Contact Information")
                        .font(.headline)
                    Text("For questions about these Terms, please contact us at \(Config.supportEmail)")
                }
            }
            .padding()
        }
        .navigationTitle("Terms of Service")
    }
}

#Preview {
    NavigationView {
        TermsOfServiceView()
    }
} 