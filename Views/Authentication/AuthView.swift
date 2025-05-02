import SwiftUI

struct AuthView: View {
    @State private var isLogin = true
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showWelcome = true
    
    var body: some View {
        ZStack {
            if showWelcome {
                WelcomeAnimation(
                    title: "Welcome to PureSky",
                    subtitle: "Your spiritual journey begins here",
                    icon: "sparkles",
                    color: AppColors.primary
                )
                .transition(.opacity)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            showWelcome = false
                        }
                    }
                }
            } else {
                ScrollView {
                    VStack(spacing: 32) {
                        // Logo and Title
                        VStack(spacing: 16) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 60))
                                .foregroundStyle(AppGradients.primary)
                            
                            Text("PureSky")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundStyle(AppGradients.primary)
                        }
                        .padding(.top, 40)
                        
                        // Form
                        VStack(spacing: 24) {
                            // Email
                            PremiumTextField(
                                title: "Email",
                                icon: "envelope",
                                text: $email
                            )
                            
                            // Password
                            PremiumTextField(
                                title: "Password",
                                icon: "lock",
                                text: $password,
                                isSecure: true
                            )
                            
                            // Confirm Password (Sign Up only)
                            if !isLogin {
                                PremiumTextField(
                                    title: "Confirm Password",
                                    icon: "lock.shield",
                                    text: $confirmPassword,
                                    isSecure: true
                                )
                            }
                            
                            // Forgot Password (Login only)
                            if isLogin {
                                Button(action: {
                                    // Handle forgot password
                                }) {
                                    Text("Forgot Password?")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(AppColors.primary)
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            
                            // Sign In/Up Button
                            PremiumButton(
                                title: isLogin ? "Sign In" : "Create Account",
                                icon: isLogin ? "arrow.right" : "person.badge.plus"
                            ) {
                                // Handle authentication
                            }
                            
                            // Social Sign In
                            VStack(spacing: 16) {
                                Text("Or continue with")
                                    .font(.system(size: 14))
                                    .foregroundColor(.secondary)
                                
                                HStack(spacing: 20) {
                                    SocialButton(icon: "apple.logo") {
                                        // Handle Apple sign in
                                    }
                                    
                                    SocialButton(icon: "g.circle.fill") {
                                        // Handle Google sign in
                                    }
                                }
                            }
                        }
                        
                        // Toggle Login/Sign Up
                        HStack {
                            Text(isLogin ? "Don't have an account?" : "Already have an account?")
                                .foregroundColor(.secondary)
                            
                            Button(action: {
                                withAnimation {
                                    isLogin.toggle()
                                }
                            }) {
                                Text(isLogin ? "Sign Up" : "Sign In")
                                    .fontWeight(.semibold)
                                    .foregroundColor(AppColors.primary)
                            }
                        }
                        .font(.system(size: 14))
                    }
                    .padding(.horizontal, 24)
                }
                .background(
                    ZStack {
                        AppColors.background
                        
                        // Decorative elements
                        Circle()
                            .fill(AppColors.primary.opacity(0.1))
                            .frame(width: 200)
                            .blur(radius: 50)
                            .offset(x: -150, y: -100)
                        
                        Circle()
                            .fill(AppColors.secondary.opacity(0.1))
                            .frame(width: 200)
                            .blur(radius: 50)
                            .offset(x: 150, y: 100)
                    }
                )
            }
        }
    }
}

struct SocialButton: View {
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.primary)
                .frame(width: 56, height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.ultraThinMaterial)
                )
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
} 