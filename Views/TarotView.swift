import SwiftUI

struct TarotView: View {
    @StateObject private var viewModel = TarotViewModel()
    @State private var selectedReadingType: ReadingType = .oneCard
    @State private var showWelcome = true
    
    enum ReadingType {
        case oneCard
        case twoCards
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if showWelcome {
                    WelcomeAnimation(
                        title: "Welcome to Tarot",
                        subtitle: "Discover your path through the cards",
                        icon: "moon.stars.fill",
                        color: AppColors.Tarot.primary
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
                            // Daily Card Section
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Daily Card")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(AppGradients.tarot)
                                
                                if let card = viewModel.dailyCard {
                                    DailyCardView(card: card)
                                        .transition(.scale.combined(with: .opacity))
                                }
                            }
                            .cardStyle()
                            
                            // Reading Section
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Tarot Reading")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(AppGradients.tarot)
                                
                                Picker("Reading Type", selection: $selectedReadingType) {
                                    Text("One Card").tag(ReadingType.oneCard)
                                    Text("Two Cards").tag(ReadingType.twoCards)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                
                                if viewModel.isReadingInProgress {
                                    ProgressView("Shuffling cards...")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .tint(AppColors.Tarot.primary)
                                } else if viewModel.selectedCards.isEmpty {
                                    PrimaryButton(title: "Start Reading") {
                                        withAnimation {
                                            viewModel.performReading(numberOfCards: selectedReadingType == .oneCard ? 1 : 2)
                                        }
                                    }
                                } else {
                                    // Display selected cards
                                    VStack(spacing: 20) {
                                        ForEach(viewModel.selectedCards) { card in
                                            CardView(card: card)
                                                .transition(.scale.combined(with: .opacity))
                                        }
                                        
                                        if viewModel.showInterpretation {
                                            InterpretationView(interpretation: viewModel.getInterpretation(for: viewModel.selectedCards))
                                                .transition(.move(edge: .bottom).combined(with: .opacity))
                                        }
                                        
                                        PrimaryButton(title: "New Reading") {
                                            withAnimation {
                                                viewModel.selectedCards = []
                                                viewModel.showInterpretation = false
                                            }
                                        }
                                    }
                                }
                            }
                            .cardStyle()
                        }
                        .padding()
                    }
                    .navigationTitle("Tarot")
                    .background(AppColors.background)
                }
            }
        }
    }
}

struct DailyCardView: View {
    let card: TarotCard
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 15) {
            Image(card.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .rotationEffect(.degrees(card.isReversed ? 180 : 0))
                .shadow(color: AppColors.Tarot.primary.opacity(0.3), radius: 10)
                .scaleEffect(isAnimating ? 1.05 : 1.0)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(card.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(AppGradients.tarot)
                
                if card.isReversed {
                    Text("Reversed")
                        .font(.subheadline)
                        .foregroundColor(.red)
                }
                
                Text(card.dailyMessage)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}

struct CardView: View {
    let card: TarotCard
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 15) {
            Image(card.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .rotationEffect(.degrees(card.isReversed ? 180 : 0))
                .shadow(color: AppColors.Tarot.primary.opacity(0.3), radius: 10)
                .scaleEffect(isAnimating ? 1.05 : 1.0)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(card.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(AppGradients.tarot)
                
                if card.isReversed {
                    Text("Reversed")
                        .font(.subheadline)
                        .foregroundColor(.red)
                }
            }
        }
        .padding()
        .glassBackground()
        .onAppear {
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}

struct InterpretationView: View {
    let interpretation: String
    @State private var isAnimating = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Interpretation")
                .font(.headline)
                .foregroundStyle(AppGradients.tarot)
            
            Text(interpretation)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassBackground()
        .opacity(isAnimating ? 1 : 0)
        .onAppear {
            withAnimation(.easeIn(duration: 0.5)) {
                isAnimating = true
            }
        }
    }
}

struct TarotView_Previews: PreviewProvider {
    static var previews: some View {
        TarotView()
    }
} 