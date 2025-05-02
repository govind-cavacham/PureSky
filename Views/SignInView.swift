import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Logo and Title
                VStack(spacing: 10) {
                    Image(systemName: "cloud.sun.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.purple)
                    
                    Text("PureSky")
                        .font(.largeTitle)
                        .bold()
                    
                    Text(isSignUp ? "Create your account" : "Welcome back")
                        .foregroundColor(.secondary)
                }
                .padding(.top, 50)
                
                // Form Fields
                VStack(spacing: 15) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disabled(isLoading)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(isSignUp ? .newPassword : .password)
                        .disabled(isLoading)
                }
                .padding(.horizontal)
                
                // Sign In/Up Button
                Button(action: handleAuthentication) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text(isSignUp ? "Sign Up" : "Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.purple)
                .cornerRadius(10)
                .disabled(isLoading || email.isEmpty || password.isEmpty)
                .padding(.horizontal)
                
                // Toggle Sign In/Up
                Button(action: { isSignUp.toggle() }) {
                    Text(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up")
                        .foregroundColor(.purple)
                }
                .disabled(isLoading)
                
                Spacer()
                
                // Terms and Privacy
                VStack(spacing: 5) {
                    Text("By continuing, you agree to our")
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Link("Terms of Service", destination: URL(string: Config.termsOfServiceURL)!)
                        Text("and")
                            .foregroundColor(.secondary)
                        Link("Privacy Policy", destination: URL(string: Config.privacyPolicyURL)!)
                    }
                }
                .font(.footnote)
                .padding(.bottom)
            }
            .padding()
            .alert("Authentication", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func handleAuthentication() {
        isLoading = true
        
        Task {
            do {
                if isSignUp {
                    try await viewModel.signUp(email: email, password: password)
                } else {
                    try await viewModel.signIn(email: email, password: password)
                }
                await MainActor.run {
                    isLoading = false
                    dismiss()
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                    alertMessage = error.localizedDescription
                    showAlert = true
                }
            }
        }
    }
}

#Preview {
    SignInView()
} 