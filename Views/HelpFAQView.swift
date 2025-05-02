import SwiftUI

struct HelpFAQView: View {
    @State private var searchText = ""
    
    let faqs = [
        FAQ(question: "How does PureSky work?",
            answer: "PureSky combines weather data with cosmic guidance, providing you with both practical weather information and spiritual insights for your day."),
        FAQ(question: "What's included in the free version?",
            answer: "The free version includes basic weather forecasts, daily tarot card readings, moon phase information, and daily affirmations."),
        FAQ(question: "What are the premium features?",
            answer: "Premium features include 3-card tarot spreads, personalized astrology forecasts, 7-day energy planning, premium themes, and daily crystal recommendations."),
        FAQ(question: "How accurate are the weather forecasts?",
            answer: "We use OpenWeatherMap's API for accurate, real-time weather data. The forecasts are updated every 30 minutes."),
        FAQ(question: "How do I change my location?",
            answer: "Go to Profile > Location Settings to enable location access or select a specific city."),
        FAQ(question: "Can I use the app offline?",
            answer: "Basic features like tarot readings and affirmations work offline, but weather and cosmic data require an internet connection."),
        FAQ(question: "How do I cancel my subscription?",
            answer: "You can cancel your subscription through your App Store account settings or by contacting our support team.")
    ]
    
    var filteredFAQs: [FAQ] {
        if searchText.isEmpty {
            return faqs
        }
        return faqs.filter { $0.question.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        List {
            ForEach(filteredFAQs) { faq in
                DisclosureGroup(faq.question) {
                    Text(faq.answer)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 8)
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search FAQs")
        .navigationTitle("Help & FAQ")
    }
}

struct FAQ: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

#Preview {
    NavigationView {
        HelpFAQView()
    }
} 