import SwiftUI

// MARK: - Colors
struct AppColors {
    static let primary = Color("PrimaryColor", bundle: nil)
    static let secondary = Color("SecondaryColor", bundle: nil)
    static let accent = Color("AccentColor", bundle: nil)
    static let background = Color("BackgroundColor", bundle: nil)
    static let cardBackground = Color("CardBackgroundColor", bundle: nil)
    
    // Feature-specific colors
    struct Tarot {
        static let primary = Color.purple
        static let secondary = Color.indigo
        static let accent = Color.pink
    }
    
    struct Moon {
        static let primary = Color.blue
        static let secondary = Color.teal
        static let accent = Color.cyan
    }
    
    struct Weather {
        static let primary = Color.orange
        static let secondary = Color.yellow
        static let accent = Color.red
    }
}

// MARK: - Gradients
struct AppGradients {
    static let primary = LinearGradient(
        colors: [AppColors.primary, AppColors.secondary],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let tarot = LinearGradient(
        colors: [AppColors.Tarot.primary, AppColors.Tarot.secondary],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let moon = LinearGradient(
        colors: [AppColors.Moon.primary, AppColors.Moon.secondary],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let weather = LinearGradient(
        colors: [AppColors.Weather.primary, AppColors.Weather.secondary],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// MARK: - Shadows
struct AppShadow {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
}

struct AppShadows {
    static let small = AppShadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    static let medium = AppShadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 4)
    static let large = AppShadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 6)
}

// MARK: - Animations
struct AppAnimations {
    static let spring = Animation.spring(response: 0.3, dampingFraction: 0.7)
    static let easeOut = Animation.easeOut(duration: 0.3)
    static let easeInOut = Animation.easeInOut(duration: 0.3)
}

// MARK: - View Modifiers
struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(AppColors.cardBackground)
            .cornerRadius(20)
            .shadow(color: AppShadows.medium.color, radius: AppShadows.medium.radius, x: AppShadows.medium.x, y: AppShadows.medium.y)
    }
}

struct GlassBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .cornerRadius(20)
    }
}

struct AnimatedGradientBackground: ViewModifier {
    @State private var animateGradient = false
    
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    colors: [
                        AppColors.primary.opacity(0.8),
                        AppColors.secondary.opacity(0.8),
                        AppColors.accent.opacity(0.8)
                    ],
                    startPoint: animateGradient ? .topLeading : .bottomLeading,
                    endPoint: animateGradient ? .bottomTrailing : .topTrailing
                )
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.linear(duration: 5.0).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
            )
    }
}

// MARK: - Extensions
extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }
    
    func glassBackground() -> some View {
        modifier(GlassBackground())
    }
    
    func animatedGradientBackground() -> some View {
        modifier(AnimatedGradientBackground())
    }
}

// MARK: - Custom Shapes
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Custom Buttons
struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(AppGradients.primary)
                .cornerRadius(15)
                .shadow(color: AppShadows.small.color, radius: AppShadows.small.radius, x: AppShadows.small.x, y: AppShadows.small.y)
        }
    }
}

struct IconButton: View {
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(color)
                .frame(width: 44, height: 44)
                .background(color.opacity(0.1))
                .clipShape(Circle())
        }
    }
} 