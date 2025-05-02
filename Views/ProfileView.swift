import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showingSignOutAlert = false
    
    var body: some View {
        NavigationView {
            List {
                if let user = viewModel.user {
                    // User Profile Section
                    Section {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.purple)
                            
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .font(.headline)
                                Text(user.email)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    
                    // Premium Status
                    Section {
                        if viewModel.isPremium {
                            Label("Premium Member", systemImage: "star.fill")
                                .foregroundColor(.yellow)
                        } else {
                            Button(action: { viewModel.showPremiumUpgrade = true }) {
                                Label("Upgrade to Premium", systemImage: "star")
                                    .foregroundColor(.purple)
                            }
                        }
                    }
                    
                    // Settings
                    Section(header: Text("Settings")) {
                        NavigationLink(destination: LocationSettingsView()) {
                            Label("Location Settings", systemImage: "location.fill")
                        }
                        
                        Toggle("Daily Notifications", isOn: .constant(true))
                        
                        Toggle("Dark Mode", isOn: .constant(false))
                    }
                    
                    // Support
                    Section(header: Text("Support")) {
                        NavigationLink(destination: HelpFAQView()) {
                            Label("Help & FAQ", systemImage: "questionmark.circle")
                        }
                        
                        NavigationLink(destination: ContactView()) {
                            Label("Contact Us", systemImage: "envelope")
                        }
                        
                        Button(action: { viewModel.rateApp() }) {
                            Label("Rate the App", systemImage: "star")
                        }
                    }
                    
                    // Legal
                    Section(header: Text("Legal")) {
                        NavigationLink(destination: PrivacyPolicyView()) {
                            Label("Privacy Policy", systemImage: "lock.shield")
                        }
                        
                        NavigationLink(destination: TermsOfServiceView()) {
                            Label("Terms of Service", systemImage: "doc.text")
                        }
                    }
                    
                    // Sign Out
                    Section {
                        Button(action: { showingSignOutAlert = true }) {
                            Label("Sign Out", systemImage: "arrow.right.square")
                                .foregroundColor(.red)
                        }
                    }
                } else {
                    // Not Signed In
                    Section {
                        Button(action: { viewModel.showSignIn = true }) {
                            Label("Sign In", systemImage: "person.fill")
                        }
                    }
                }
                
                // App Info
                Section {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(viewModel.appVersion)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Profile")
            .alert("Sign Out", isPresented: $showingSignOutAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Sign Out", role: .destructive) {
                    try? viewModel.signOut()
                }
            } message: {
                Text("Are you sure you want to sign out?")
            }
            .sheet(isPresented: $viewModel.showSignIn) {
                SignInView()
            }
            .sheet(isPresented: $viewModel.showPremiumUpgrade) {
                PremiumUpgradeView()
            }
        }
    }
}

#Preview {
    ProfileView()
} 