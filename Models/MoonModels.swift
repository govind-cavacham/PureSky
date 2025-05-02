import Foundation

struct MoonPhase: Identifiable {
    let id: Int
    let name: String
    let iconName: String
    let description: String
    let illumination: Double // 0.0 to 1.0
    let age: Double // Age of the moon in days
    let distance: Double // Distance from Earth in kilometers
    let nextFullMoon: Date
    let nextNewMoon: Date
    
    static func calculateCurrentPhase() -> MoonPhase {
        // Get current date
        let now = Date()
        
        // Calculate moon phase (simplified version)
        let knownNewMoon = Date(timeIntervalSince1970: 947182440) // Known new moon date
        let lunarMonth = 29.530588853 // Length of lunar month in days
        
        let timeSinceKnownNewMoon = now.timeIntervalSince(knownNewMoon)
        let daysSinceKnownNewMoon = timeSinceKnownNewMoon / (24 * 3600)
        let phase = (daysSinceKnownNewMoon.truncatingRemainder(dividingBy: lunarMonth)) / lunarMonth
        
        // Calculate illumination
        let illumination = abs(0.5 - phase) * 2
        
        // Calculate next full and new moons
        let daysUntilNextFullMoon = (0.5 - phase).truncatingRemainder(dividingBy: 1) * lunarMonth
        let daysUntilNextNewMoon = (1 - phase).truncatingRemainder(dividingBy: 1) * lunarMonth
        
        let nextFullMoon = now.addingTimeInterval(daysUntilNextFullMoon * 24 * 3600)
        let nextNewMoon = now.addingTimeInterval(daysUntilNextNewMoon * 24 * 3600)
        
        // Determine phase name and details
        let (name, description, iconName) = getPhaseDetails(phase: phase)
        
        return MoonPhase(
            id: Int(phase * 8), // Convert phase to 0-7 range
            name: name,
            iconName: iconName,
            description: description,
            illumination: illumination,
            age: daysSinceKnownNewMoon.truncatingRemainder(dividingBy: lunarMonth),
            distance: 384400, // Average distance in km
            nextFullMoon: nextFullMoon,
            nextNewMoon: nextNewMoon
        )
    }
    
    private static func getPhaseDetails(phase: Double) -> (String, String, String) {
        switch phase {
        case 0..<0.03, 0.97...1:
            return ("New Moon", "A time for new beginnings and setting intentions", "moon.new")
        case 0.03..<0.22:
            return ("Waxing Crescent", "Growth and development of new ideas", "moon.waxing.crescent")
        case 0.22..<0.28:
            return ("First Quarter", "Taking action and making decisions", "moon.firstquarter")
        case 0.28..<0.47:
            return ("Waxing Gibbous", "Refinement and adjustment of plans", "moon.waxing.gibbous")
        case 0.47..<0.53:
            return ("Full Moon", "Completion, fulfillment, and illumination", "moon.full")
        case 0.53..<0.72:
            return ("Waning Gibbous", "Gratitude and sharing", "moon.waning.gibbous")
        case 0.72..<0.78:
            return ("Last Quarter", "Release and letting go", "moon.lastquarter")
        case 0.78..<0.97:
            return ("Waning Crescent", "Rest, reflection, and preparation", "moon.waning.crescent")
        default:
            return ("Unknown", "Unable to determine moon phase", "moon")
        }
    }
}

struct AstrologicalInfo {
    let moonSign: String
    let risingSign: String
    let planetaryAspects: String
    let date: Date
}

struct Crystal: Identifiable {
    let id: Int
    let name: String
    let properties: String
    let element: CrystalElement
    let chakra: Chakra
    
    enum CrystalElement: String {
        case earth, air, fire, water, ether
    }
    
    enum Chakra: String {
        case root, sacral, solarPlexus, heart, throat, thirdEye, crown
    }
}

@MainActor
class MoonViewModel: ObservableObject {
    @Published var currentPhase: MoonPhase?
    @Published var astrologicalInfo: AstrologicalInfo?
    @Published var dailyCrystal: Crystal?
    @Published var lastUpdated: Date
    
    private let crystals: [Crystal] = [
        Crystal(
            id: 0,
            name: "Amethyst",
            properties: "Calming, spiritual awareness, protection",
            element: .ether,
            chakra: .crown
        ),
        Crystal(
            id: 1,
            name: "Rose Quartz",
            properties: "Love, harmony, emotional healing",
            element: .water,
            chakra: .heart
        ),
        Crystal(
            id: 2,
            name: "Citrine",
            properties: "Abundance, manifestation, joy",
            element: .fire,
            chakra: .solarPlexus
        )
        // Add more crystals...
    ]
    
    init() {
        self.lastUpdated = Date()
        updateMoonPhase()
        updateAstrologicalInfo()
        updateDailyCrystal()
    }
    
    private func updateMoonPhase() {
        currentPhase = MoonPhase.calculateCurrentPhase()
    }
    
    private func updateAstrologicalInfo() {
        // In a real app, this would fetch from an astrology API
        astrologicalInfo = AstrologicalInfo(
            moonSign: "Leo",
            risingSign: "Taurus",
            planetaryAspects: "Moon trine Jupiter",
            date: Date()
        )
    }
    
    private func updateDailyCrystal() {
        // In a real app, this would be based on moon phase and astrological info
        dailyCrystal = crystals.randomElement()
    }
    
    func refreshData() {
        updateMoonPhase()
        updateAstrologicalInfo()
        updateDailyCrystal()
        lastUpdated = Date()
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
} 