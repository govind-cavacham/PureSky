import Foundation

struct TarotCard: Identifiable, Codable {
    let id: Int
    let name: String
    let imageName: String
    let meaning: String
    let dailyMessage: String
    let category: CardCategory
    let uprightMeaning: String
    let reversedMeaning: String
    var isReversed: Bool
    
    enum CardCategory: String, Codable {
        case majorArcana = "Major Arcana"
        case wands = "Wands"
        case cups = "Cups"
        case swords = "Swords"
        case pentacles = "Pentacles"
    }
}

class TarotViewModel: ObservableObject {
    @Published var dailyCard: TarotCard?
    @Published var selectedCards: [TarotCard] = []
    @Published var isPremium: Bool = false
    @Published var isReadingInProgress = false
    @Published var showInterpretation = false
    
    private let cards: [TarotCard] = [
        // Major Arcana
        TarotCard(
            id: 0,
            name: "The Fool",
            imageName: "fool",
            meaning: "New beginnings, innocence, spontaneity",
            dailyMessage: "Embrace new opportunities with an open heart",
            category: .majorArcana,
            uprightMeaning: "New beginnings, innocence, spontaneity, free spirit",
            reversedMeaning: "Recklessness, risk-taking, inconsideration",
            isReversed: false
        ),
        TarotCard(
            id: 1,
            name: "The Magician",
            imageName: "magician",
            meaning: "Manifestation, resourcefulness, power",
            dailyMessage: "You have all the tools you need to succeed",
            category: .majorArcana,
            uprightMeaning: "Manifestation, resourcefulness, power, inspired action",
            reversedMeaning: "Manipulation, poor planning, untapped talents",
            isReversed: false
        ),
        TarotCard(
            id: 2,
            name: "The High Priestess",
            imageName: "high_priestess",
            meaning: "Intuition, unconscious, inner voice",
            dailyMessage: "Trust your intuition and inner wisdom",
            category: .majorArcana,
            uprightMeaning: "Intuition, unconscious, inner voice, divine feminine",
            reversedMeaning: "Secrets, disconnected from intuition, withdrawal",
            isReversed: false
        ),
        TarotCard(
            id: 3,
            name: "The Empress",
            imageName: "empress",
            meaning: "Femininity, beauty, nature, nurturing",
            dailyMessage: "Nurture yourself and others with love and care",
            category: .majorArcana,
            uprightMeaning: "Femininity, beauty, nature, nurturing, abundance",
            reversedMeaning: "Creative block, dependence on others, emptiness",
            isReversed: false
        ),
        TarotCard(
            id: 4,
            name: "The Emperor",
            imageName: "emperor",
            meaning: "Authority, structure, control, fatherhood",
            dailyMessage: "Take charge of your situation with confidence",
            category: .majorArcana,
            uprightMeaning: "Authority, structure, control, fatherhood, stability",
            reversedMeaning: "Domination, excessive control, rigidity, inflexibility",
            isReversed: false
        ),
        // Add more cards here...
    ]
    
    init() {
        selectDailyCard()
    }
    
    func performReading(numberOfCards: Int) {
        isReadingInProgress = true
        selectedCards = []
        
        // Simulate card shuffling and selection
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            var availableCards = self.cards
            for _ in 0..<numberOfCards {
                if let randomIndex = availableCards.indices.randomElement() {
                    var card = availableCards[randomIndex]
                    // 50% chance of reversed card
                    card.isReversed = Bool.random()
                    self.selectedCards.append(card)
                    availableCards.remove(at: randomIndex)
                }
            }
            self.isReadingInProgress = false
            self.showInterpretation = true
        }
    }
    
    private func selectDailyCard() {
        if let card = cards.randomElement() {
            var dailyCard = card
            dailyCard.isReversed = Bool.random()
            self.dailyCard = dailyCard
        }
    }
    
    func refreshDailyCard() {
        selectDailyCard()
    }
    
    func getInterpretation(for cards: [TarotCard]) -> String {
        var interpretation = ""
        
        if cards.count == 1 {
            let card = cards[0]
            interpretation = card.isReversed ? card.reversedMeaning : card.uprightMeaning
        } else if cards.count == 2 {
            let card1 = cards[0]
            let card2 = cards[1]
            
            interpretation = "First Card (\(card1.name)): "
            interpretation += card1.isReversed ? card1.reversedMeaning : card1.uprightMeaning
            interpretation += "\n\nSecond Card (\(card2.name)): "
            interpretation += card2.isReversed ? card2.reversedMeaning : card2.uprightMeaning
            
            // Add relationship interpretation
            interpretation += "\n\nRelationship: "
            if card1.category == card2.category {
                interpretation += "These cards share the same element, suggesting a strong connection between their meanings."
            } else {
                interpretation += "These cards represent different aspects of your situation, offering a balanced perspective."
            }
        }
        
        return interpretation
    }
} 