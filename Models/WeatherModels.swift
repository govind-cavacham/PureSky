import Foundation
import SwiftUI
import CoreLocation

// MARK: - Weather Models
struct Weather {
    let location: String
    let temperature: Double
    let condition: String
    let humidity: Int
    let windSpeed: Double
    let feelsLike: Double
    let sunrise: String
    let sunset: String
    let uvIndex: Double
    let visibility: Double
    let hourlyForecast: [HourlyForecast]
    let dailyForecast: [DailyForecast]
}

struct WeatherData {
    let temperature: Double
    let condition: String
    let icon: String
    let location: String
    let humidity: Int
    let windSpeed: Double
    let feelsLike: Double
    let uvIndex: Int
}

struct HourlyForecast {
    let hour: String
    let temperature: Double
    let icon: String
    let condition: String
}

struct DailyForecast {
    let date: String
    let highTemp: Double
    let lowTemp: Double
    let icon: String
    let condition: String
} 