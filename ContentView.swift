//
//  ContentView.swift
//  PureSky
//
//  Created by Govind Pathak on 02/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            WeatherView()
                .tabItem {
                    Image(systemName: "cloud.sun.fill")
                    Text("Weather")
                }
                .tag(0)
            
            TarotView()
                .tabItem {
                    Image(systemName: "sparkles")
                    Text("Tarot")
                }
                .tag(1)
            
            MoonPhaseView()
                .tabItem {
                    Image(systemName: "moon.stars.fill")
                    Text("Moon")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(3)
        }
        .accentColor(.purple)
    }
}

#Preview {
    ContentView()
}
