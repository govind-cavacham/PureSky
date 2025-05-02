import Foundation
import CoreLocation
import SwiftUI

@MainActor
class WeatherViewModel: NSObject, ObservableObject {
    @Published var weather: Weather?
    @Published var error: Error?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var currentWeather: WeatherData?
    @Published var hourlyForecast: [HourlyForecast]?
    @Published var dailyForecast: [DailyForecast]?
    
    private let locationManager = CLLocationManager()
    private let apiKey = Config.weatherAPIKey
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        print("WeatherViewModel initialized with API key: \(apiKey)")
        
        // Initialize with sample data for now
        loadSampleData()
    }
    
    func fetchWeather(latitude: Double, longitude: Double) async {
        print("Fetching weather for coordinates: \(latitude), \(longitude)")
        isLoading = true
        errorMessage = nil
        
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(latitude),\(longitude)&days=7&aqi=no&alerts=no"
        print("API URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            self.errorMessage = "Unable to create weather request"
            self.isLoading = false
            return
        }
        
        do {
            print("Making API request...")
            let (data, httpResponse) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = httpResponse as? HTTPURLResponse {
                print("API Response Status Code: \(httpResponse.statusCode)")
                
                // Handle specific HTTP status codes
                switch httpResponse.statusCode {
                case 401:
                    self.errorMessage = "Weather API key is invalid. Please try again later."
                    self.isLoading = false
                    return
                case 429:
                    self.errorMessage = "Too many requests. Please try again later."
                    self.isLoading = false
                    return
                case 500...599:
                    self.errorMessage = "Weather service is temporarily unavailable. Please try again later."
                    self.isLoading = false
                    return
                default:
                    break
                }
            }
            
            print("Received data: \(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")")
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let weatherResponse = try decoder.decode(WeatherAPIResponse.self, from: data)
            print("Successfully decoded weather response")
            
            let weather = Weather(
                location: weatherResponse.location.name,
                temperature: weatherResponse.current.tempC,
                condition: weatherResponse.current.condition.text,
                humidity: weatherResponse.current.humidity,
                windSpeed: weatherResponse.current.windKph,
                feelsLike: weatherResponse.current.feelslikeC,
                sunrise: weatherResponse.forecast.forecastday.first?.astro.sunrise ?? "",
                sunset: weatherResponse.forecast.forecastday.first?.astro.sunset ?? "",
                uvIndex: weatherResponse.current.uv,
                visibility: weatherResponse.current.visKm,
                hourlyForecast: createHourlyForecast(from: weatherResponse.forecast.forecastday.first?.hour ?? []),
                dailyForecast: createDailyForecast(from: weatherResponse.forecast.forecastday)
            )
            
            print("Created weather object with temperature: \(weather.temperature)°")
            
            DispatchQueue.main.async {
                self.weather = weather
                self.isLoading = false
                print("Weather updated in UI")
            }
        } catch {
            print("Error fetching weather: \(error.localizedDescription)")
            self.error = error
            self.errorMessage = "Unable to fetch weather data. Please try again later."
            self.isLoading = false
        }
    }
    
    private func createHourlyForecast(from hourly: [HourlyData]) -> [HourlyForecast] {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        
        return hourly.map { hour in
            HourlyForecast(
                hour: formatter.string(from: hour.time),
                temperature: hour.tempC,
                icon: getWeatherIcon(from: hour.condition.code),
                condition: hour.condition.text
            )
        }
    }
    
    private func createDailyForecast(from daily: [ForecastDay]) -> [DailyForecast] {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        
        return daily.map { day in
            DailyForecast(
                date: formatter.string(from: day.date),
                highTemp: day.day.maxtempC,
                lowTemp: day.day.mintempC,
                icon: getWeatherIcon(from: day.day.condition.code),
                condition: day.day.condition.text
            )
        }
    }
    
    private func getWeatherIcon(from code: Int) -> String {
        // WeatherAPI.com condition codes mapping
        switch code {
        case 1000: return "sun.max.fill" // Clear
        case 1003: return "cloud.sun.fill" // Partly cloudy
        case 1006, 1009: return "cloud.fill" // Cloudy
        case 1030, 1135, 1147: return "cloud.fog.fill" // Mist, Fog
        case 1063, 1180...1195: return "cloud.rain.fill" // Rain
        case 1066, 1210...1225: return "cloud.snow.fill" // Snow
        case 1069, 1204...1207: return "cloud.sleet.fill" // Sleet
        case 1087, 1273...1276: return "cloud.bolt.fill" // Thunder
        default: return "cloud.fill"
        }
    }
    
    func refreshData() {
        isLoading = true
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadSampleData()
            self.isLoading = false
        }
    }
    
    private func loadSampleData() {
        // Sample current weather
        currentWeather = WeatherData(
            temperature: 72,
            condition: "Sunny",
            icon: "sun.max.fill",
            location: "San Francisco",
            humidity: 65,
            windSpeed: 8,
            feelsLike: 74,
            uvIndex: 6
        )
        
        // Sample hourly forecast
        hourlyForecast = [
            HourlyForecast(hour: "Now", temperature: 72, icon: "sun.max.fill", condition: "Sunny"),
            HourlyForecast(hour: "1 PM", temperature: 73, icon: "sun.max.fill", condition: "Sunny"),
            HourlyForecast(hour: "2 PM", temperature: 74, icon: "sun.max.fill", condition: "Sunny"),
            HourlyForecast(hour: "3 PM", temperature: 73, icon: "sun.max.fill", condition: "Sunny"),
            HourlyForecast(hour: "4 PM", temperature: 72, icon: "sun.max.fill", condition: "Sunny"),
            HourlyForecast(hour: "5 PM", temperature: 70, icon: "sun.max.fill", condition: "Sunny")
        ]
        
        // Sample daily forecast
        let calendar = Calendar.current
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        
        dailyForecast = (0...6).map { dayOffset in
            let date = calendar.date(byAdding: .day, value: dayOffset, to: today)!
            return DailyForecast(
                date: formatter.string(from: date),
                highTemp: Double.random(in: 70...80),
                lowTemp: Double.random(in: 60...70),
                icon: "sun.max.fill",
                condition: "Sunny"
            )
        }
    }
}

// WeatherAPI.com Response Models
struct WeatherAPIResponse: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
}

struct Current: Codable {
    let tempC: Double
    let feelslikeC: Double
    let humidity: Int
    let windKph: Double
    let uv: Double
    let visKm: Double
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case feelslikeC = "feelslike_c"
        case humidity
        case windKph = "wind_kph"
        case uv
        case visKm = "vis_km"
        case condition
    }
}

struct Condition: Codable {
    let text: String
    let code: Int
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    let date: Date
    let day: Day
    let astro: Astro
    let hour: [HourlyData]
    
    enum CodingKeys: String, CodingKey {
        case date = "date_epoch"
        case day, astro, hour
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let epoch = try container.decode(Int.self, forKey: .date)
        date = Date(timeIntervalSince1970: TimeInterval(epoch))
        day = try container.decode(Day.self, forKey: .day)
        astro = try container.decode(Astro.self, forKey: .astro)
        hour = try container.decode([HourlyData].self, forKey: .hour)
    }
}

struct Day: Codable {
    let maxtempC: Double
    let mintempC: Double
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case condition
    }
}

struct Astro: Codable {
    let sunrise: String
    let sunset: String
}

struct HourlyData: Codable {
    let time: Date
    let tempC: Double
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case time = "time_epoch"
        case tempC = "temp_c"
        case condition
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let epoch = try container.decode(Int.self, forKey: .time)
        time = Date(timeIntervalSince1970: TimeInterval(epoch))
        tempC = try container.decode(Double.self, forKey: .tempC)
        condition = try container.decode(Condition.self, forKey: .condition)
    }
}

extension WeatherViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("Location authorization status changed: \(manager.authorizationStatus.rawValue)")
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            if let location = manager.location {
                print("Location authorized, fetching weather for: \(location.coordinate.latitude), \(location.coordinate.longitude)")
                Task {
                    await fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                }
            } else {
                print("Location authorized but no location available")
            }
        case .denied, .restricted:
            print("Location access denied or restricted")
            error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Location access denied"])
        case .notDetermined:
            print("Location authorization not determined")
            break
        @unknown default:
            print("Unknown location authorization status")
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("Location updated: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            Task {
                await fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
        self.error = error
    }
} 