import SwiftUI
import CoreLocation

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var showWelcome = true
    
    var body: some View {
        ZStack {
            // Background
            AppColors.background
                .ignoresSafeArea()
            
            // Main Content
            ScrollView {
                VStack(spacing: 20) {
                    // Current Weather Card
                    if let currentWeather = viewModel.currentWeather {
                        PremiumWeatherCard(
                            temperature: currentWeather.temperature,
                            condition: currentWeather.condition,
                            icon: currentWeather.icon,
                            location: currentWeather.location,
                            date: Date()
                        )
                    }
                    
                    // Weather Details Grid
                    if let currentWeather = viewModel.currentWeather {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 15) {
                            PremiumWeatherDetail(
                                title: "Humidity",
                                value: "\(currentWeather.humidity)%",
                                icon: "humidity.fill"
                            )
                            
                            PremiumWeatherDetail(
                                title: "Wind",
                                value: "\(Int(currentWeather.windSpeed)) km/h",
                                icon: "wind"
                            )
                            
                            PremiumWeatherDetail(
                                title: "Feels Like",
                                value: "\(Int(currentWeather.feelsLike))°",
                                icon: "thermometer"
                            )
                            
                            PremiumWeatherDetail(
                                title: "UV Index",
                                value: "\(currentWeather.uvIndex)",
                                icon: "sun.max.fill"
                            )
                        }
                        .padding(.horizontal)
                    }
                    
                    // Hourly Forecast
                    if let hourlyForecast = viewModel.hourlyForecast {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Hourly Forecast")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(AppGradients.weather)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(hourlyForecast, id: \.hour) { forecast in
                                        VStack(spacing: 8) {
                                            Text(forecast.hour)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                            
                                            Image(systemName: forecast.icon)
                                                .font(.title2)
                                                .foregroundStyle(AppGradients.weather)
                                            
                                            Text("\(Int(forecast.temperature))°")
                                                .font(.headline)
                                        }
                                        .frame(width: 60)
                                        .padding(.vertical, 10)
                                        .background(AppColors.cardBackground)
                                        .cornerRadius(15)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    // Daily Forecast
                    if let dailyForecast = viewModel.dailyForecast {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("7-Day Forecast")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(AppGradients.weather)
                                .padding(.horizontal)
                            
                            ForEach(dailyForecast, id: \.date) { forecast in
                                HStack {
                                    Text(forecast.date)
                                        .frame(width: 100, alignment: .leading)
                                    
                                    Image(systemName: forecast.icon)
                                        .foregroundStyle(AppGradients.weather)
                                    
                                    Spacer()
                                    
                                    Text("\(Int(forecast.highTemp))°")
                                        .fontWeight(.semibold)
                                    
                                    Text("\(Int(forecast.lowTemp))°")
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                                .background(AppColors.cardBackground)
                                .cornerRadius(15)
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            
            // Welcome Animation
            if showWelcome {
                WelcomeAnimation(
                    title: "Weather",
                    subtitle: "Your daily forecast",
                    icon: "cloud.sun.fill",
                    color: AppColors.Weather.primary
                )
                .transition(.opacity)
                .zIndex(1)
            }
        }
        .navigationTitle("Weather")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                IconButton(icon: "arrow.clockwise", color: AppColors.Weather.primary) {
                    withAnimation {
                        viewModel.refreshData()
                    }
                }
            }
        }
        .onAppear {
            // Hide welcome animation after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    showWelcome = false
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationView {
        WeatherView()
    }
} 