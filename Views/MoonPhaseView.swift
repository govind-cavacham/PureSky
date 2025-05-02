import SwiftUI

struct MoonPhaseView: View {
    @StateObject private var viewModel = MoonViewModel()
    @State private var showWelcome = true
    @State private var isAnimating = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if showWelcome {
                    WelcomeAnimation(
                        title: "Moon Phase",
                        subtitle: "Connect with lunar energy",
                        icon: "moon.stars.fill",
                        color: AppColors.Moon.primary
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
                        VStack(spacing: 20) {
                            // Current Phase Card
                            VStack(spacing: 15) {
                                if let phase = viewModel.currentPhase {
                                    Image(systemName: phase.iconName)
                                        .font(.system(size: 80))
                                        .foregroundStyle(AppGradients.moon)
                                        .shadow(color: AppColors.Moon.primary.opacity(0.5), radius: 20)
                                        .scaleEffect(isAnimating ? 1.1 : 1.0)
                                        .rotationEffect(.degrees(isAnimating ? 5 : -5))
                                    
                                    Text(phase.name)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(AppGradients.moon)
                                    
                                    Text(phase.description)
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                } else {
                                    ProgressView()
                                        .tint(AppColors.Moon.primary)
                                }
                            }
                            .cardStyle()
                            
                            // Moon Details
                            if let phase = viewModel.currentPhase {
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("Moon Details")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundStyle(AppGradients.moon)
                                    
                                    DetailRow(title: "Illumination", value: "\(Int(phase.illumination * 100))%")
                                    DetailRow(title: "Age", value: String(format: "%.1f days", phase.age))
                                    DetailRow(title: "Distance", value: String(format: "%.0f km", phase.distance))
                                }
                                .cardStyle()
                                .transition(.move(edge: .trailing).combined(with: .opacity))
                                
                                // Upcoming Events
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("Upcoming Events")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundStyle(AppGradients.moon)
                                    
                                    DetailRow(title: "Next Full Moon", value: viewModel.formatDate(phase.nextFullMoon))
                                    DetailRow(title: "Next New Moon", value: viewModel.formatDate(phase.nextNewMoon))
                                }
                                .cardStyle()
                                .transition(.move(edge: .trailing).combined(with: .opacity))
                                
                                // Astrological Info
                                if let astroInfo = viewModel.astrologicalInfo {
                                    VStack(alignment: .leading, spacing: 15) {
                                        Text("Astrological Info")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundStyle(AppGradients.moon)
                                        
                                        DetailRow(title: "Moon Sign", value: astroInfo.moonSign)
                                        DetailRow(title: "Rising Sign", value: astroInfo.risingSign)
                                        DetailRow(title: "Planetary Aspects", value: astroInfo.planetaryAspects)
                                    }
                                    .cardStyle()
                                    .transition(.move(edge: .trailing).combined(with: .opacity))
                                }
                                
                                // Crystal Recommendation
                                if let crystal = viewModel.dailyCrystal {
                                    VStack(alignment: .leading, spacing: 15) {
                                        Text("Crystal of the Day")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundStyle(AppGradients.moon)
                                        
                                        Text(crystal.name)
                                            .font(.headline)
                                            .foregroundStyle(AppGradients.moon)
                                        
                                        Text(crystal.properties)
                                            .font(.body)
                                            .foregroundColor(.secondary)
                                        
                                        HStack {
                                            Text("Element: \(crystal.element.rawValue.capitalized)")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                            
                                            Spacer()
                                            
                                            Text("Chakra: \(crystal.chakra.rawValue.capitalized)")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .cardStyle()
                                    .transition(.move(edge: .trailing).combined(with: .opacity))
                                }
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Moon Phase")
                    .background(AppColors.background)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            IconButton(icon: "arrow.clockwise", color: AppColors.Moon.primary) {
                                withAnimation {
                                    viewModel.refreshData()
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    @State private var isAnimating = false
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
                .foregroundStyle(AppGradients.moon)
        }
        .opacity(isAnimating ? 1 : 0)
        .onAppear {
            withAnimation(.easeIn(duration: 0.5)) {
                isAnimating = true
            }
        }
    }
}

struct MoonPhaseView_Previews: PreviewProvider {
    static var previews: some View {
        MoonPhaseView()
    }
} 