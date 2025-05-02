import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
    }
}

struct LocationSettingsView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var isLocationEnabled = true
    @State private var selectedLocation = "Current Location"
    
    var body: some View {
        List {
            Section(header: Text("Location Access")) {
                Toggle("Enable Location", isOn: $isLocationEnabled)
                    .onChange(of: isLocationEnabled) { newValue in
                        if newValue {
                            locationManager.requestLocationPermission()
                        }
                    }
                
                if isLocationEnabled {
                    Picker("Location", selection: $selectedLocation) {
                        Text("Current Location").tag("Current Location")
                        Text("Mumbai, IN").tag("Mumbai, IN")
                        Text("Delhi, IN").tag("Delhi, IN")
                        Text("Bangalore, IN").tag("Bangalore, IN")
                    }
                }
            }
            
            Section(header: Text("About Location")) {
                Text("PureSky uses your location to provide accurate weather forecasts and cosmic guidance for your area.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Location Settings")
    }
}

#Preview {
    NavigationView {
        LocationSettingsView()
    }
} 