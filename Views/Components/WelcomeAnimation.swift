import SwiftUI

struct WelcomeAnimation: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    @State private var isAnimating = false
    @State private var showContent = false
    
    var body: some View {
        ZStack {
            // Starry background
            StarryBackground()
            
            VStack(spacing: 20) {
                // Icon with glow effect
                Image(systemName: icon)
                    .font(.system(size: 60))
                    .foregroundColor(color)
                    .shadow(color: color.opacity(0.5), radius: 20)
                    .scaleEffect(isAnimating ? 1.1 : 0.9)
                    .rotationEffect(.degrees(isAnimating ? 5 : -5))
                
                // Title with fade in
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 20)
                
                // Subtitle with fade in
                Text(subtitle)
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 20)
            }
            .padding()
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
            
            withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
                showContent = true
            }
        }
    }
}

struct StarryBackground: View {
    @State private var phase = 0.0
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let starCount = 100
                let timeNow = timeline.date.timeIntervalSinceReferenceDate
                
                for i in 0..<starCount {
                    let x = size.width * Double.random(in: 0...1)
                    let y = size.height * Double.random(in: 0...1)
                    let size = Double.random(in: 1...3)
                    let opacity = (sin(timeNow + Double(i)) + 1) / 2
                    
                    context.opacity = opacity
                    context.fill(
                        Path(ellipseIn: CGRect(x: x, y: y, width: size, height: size)),
                        with: .color(.white)
                    )
                }
            }
        }
    }
}

struct FloatingElement: View {
    let icon: String
    let color: Color
    @State private var isAnimating = false
    
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 30))
            .foregroundColor(color)
            .shadow(color: color.opacity(0.5), radius: 10)
            .offset(y: isAnimating ? -10 : 10)
            .opacity(isAnimating ? 0.8 : 0.4)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 2)
                    .repeatForever(autoreverses: true)
                ) {
                    isAnimating = true
                }
            }
    }
}

struct WelcomeAnimation_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeAnimation(
            title: "Welcome to Tarot",
            subtitle: "Discover your path through the cards",
            icon: "moon.stars.fill",
            color: .purple
        )
    }
} 