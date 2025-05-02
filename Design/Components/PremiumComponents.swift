import SwiftUI

// MARK: - Premium Card
struct PremiumCard<Content: View>: View {
    let content: Content
    @State private var isAnimating = false
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.ultraThinMaterial)
                    
                    // Premium gradient overlay
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.2),
                                    Color.white.opacity(0.05)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    // Animated border
                    RoundedRectangle(cornerRadius: 25)
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.5),
                                    Color.white.opacity(0.2),
                                    Color.white.opacity(0.5)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
            )
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            .scaleEffect(isAnimating ? 1.02 : 1.0)
            .onAppear {
                withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    isAnimating = true
                }
            }
    }
}

// MARK: - Premium Button
struct PremiumButton: View {
    let title: String
    let icon: String?
    let action: () -> Void
    @State private var isPressed = false
    
    init(title: String, icon: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .semibold))
                }
                
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                ZStack {
                    // Main gradient
                    LinearGradient(
                        colors: [
                            AppColors.primary,
                            AppColors.secondary
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    
                    // Shine effect
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.2),
                            Color.white.opacity(0)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: AppColors.primary.opacity(0.3), radius: 10, x: 0, y: 5)
            .scaleEffect(isPressed ? 0.98 : 1.0)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Premium Text Field
struct PremiumTextField: View {
    let title: String
    let icon: String
    @Binding var text: String
    let isSecure: Bool
    
    init(title: String, icon: String, text: Binding<String>, isSecure: Bool = false) {
        self.title = title
        self.icon = icon
        self._text = text
        self.isSecure = isSecure
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
            
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(AppColors.primary)
                    .frame(width: 24)
                
                if isSecure {
                    SecureField("", text: $text)
                        .font(.system(size: 16))
                } else {
                    TextField("", text: $text)
                        .font(.system(size: 16))
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
            )
        }
    }
}

// MARK: - Premium Weather Card
struct PremiumWeatherCard: View {
    let temperature: Double
    let condition: String
    let icon: String
    let location: String
    let date: Date
    
    var body: some View {
        PremiumCard {
            VStack(spacing: 20) {
                // Location and Date
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(location)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(date.formatted(.dateTime.month().day().weekday()))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Text("\(Int(temperature))°")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundStyle(AppGradients.weather)
                }
                
                // Weather Icon
                Image(systemName: icon)
                    .font(.system(size: 60))
                    .foregroundStyle(AppGradients.weather)
                    .frame(height: 80)
                
                // Condition
                Text(condition)
                    .font(.title3)
                    .fontWeight(.medium)
            }
        }
    }
}

// MARK: - Premium Weather Detail
struct PremiumWeatherDetail: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundStyle(AppGradients.weather)
            
            Text(value)
                .font(.system(size: 20, weight: .semibold))
            
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
        )
    }
}

// MARK: - Button Style
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

// MARK: - Preview
struct PremiumComponents_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            PremiumButton(title: "Sign In", icon: "arrow.right") {}
            
            PremiumTextField(
                title: "Email",
                icon: "envelope",
                text: .constant("")
            )
            
            PremiumWeatherCard(
                temperature: 72,
                condition: "Sunny",
                icon: "sun.max.fill",
                location: "San Francisco",
                date: Date()
            )
            
            HStack {
                PremiumWeatherDetail(
                    title: "Humidity",
                    value: "65%",
                    icon: "humidity"
                )
                
                PremiumWeatherDetail(
                    title: "Wind",
                    value: "8 mph",
                    icon: "wind"
                )
            }
        }
        .padding()
        .background(Color(.systemBackground))
    }
} 