import SwiftUI

struct PremiumUpgradeView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var selectedPlan: SubscriptionPlan = .monthly
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Environment(\.dismiss) private var dismiss
    
    enum SubscriptionPlan: String, CaseIterable {
        case monthly = "Monthly"
        case yearly = "Yearly"
        
        var price: String {
            switch self {
            case .monthly: return Config.premiumMonthlyPrice
            case .yearly: return Config.premiumYearlyPrice
            }
        }
        
        var savings: String? {
            switch self {
            case .monthly: return nil
            case .yearly: return "Save 44%"
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    VStack(spacing: 15) {
                        Image(systemName: "star.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.yellow)
                        
                        Text("Upgrade to Premium")
                            .font(.title)
                            .bold()
                        
                        Text("Unlock all features and get personalized cosmic guidance")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top)
                    
                    // Features
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Premium Features")
                            .font(.headline)
                        
                        FeatureRow(icon: "moon.stars.fill", title: "Advanced Tarot Readings", description: "Get detailed daily tarot readings with personalized interpretations")
                        FeatureRow(icon: "chart.bar.fill", title: "Extended Forecasts", description: "Access 7-day weather forecasts with detailed cosmic insights")
                        FeatureRow(icon: "person.fill", title: "Personalized Guidance", description: "Receive custom affirmations and spiritual guidance")
                        FeatureRow(icon: "bell.fill", title: "Priority Notifications", description: "Get instant alerts for important cosmic events")
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    
                    // Subscription Plans
                    VStack(spacing: 20) {
                        Text("Choose Your Plan")
                            .font(.headline)
                        
                        ForEach(SubscriptionPlan.allCases, id: \.self) { plan in
                            PlanCard(plan: plan, isSelected: selectedPlan == plan) {
                                selectedPlan = plan
                            }
                        }
                    }
                    .padding()
                    
                    // Upgrade Button
                    Button(action: handleUpgrade) {
                        Text("Upgrade Now")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    // Trial Info
                    Text("Start with a \(Config.freeTrialDays)-day free trial")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
            .navigationBarItems(trailing: Button("Close") { dismiss() })
            .alert("Subscription", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func handleUpgrade() {
        Task {
            do {
                try await viewModel.upgradeToPremium(plan: selectedPlan.rawValue)
                dismiss()
            } catch {
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.purple)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.subheadline)
                    .bold()
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct PlanCard: View {
    let plan: PremiumUpgradeView.SubscriptionPlan
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(plan.rawValue)
                        .font(.headline)
                    Text(plan.price)
                        .font(.title3)
                        .bold()
                    if let savings = plan.savings {
                        Text(savings)
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }
                
                Spacer()
                
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isSelected ? .purple : .gray)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.purple : Color.gray.opacity(0.3), lineWidth: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    PremiumUpgradeView()
} 