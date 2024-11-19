//
//  MainTabView.swift
//  EmployeeDirectoryApp
//
//  Created by Neha on 2024-11-16.
//

import SwiftUI

struct MainTabView: View {
    @AppStorage("onboardingRequired3") var onboardingRequired: Bool = true
    var body: some View {
        TabView {
            EmployeesView()
                .tabItem{
                    Label("Employees",systemImage: "person.3")
                }
            
            SettingsView()
                .tabItem{
                    Label("Settings",systemImage: "gear")
                }
        }.sheet(isPresented: $onboardingRequired, onDismiss: {
            onboardingRequired = false
        }, content: {
            OnBoardingView(onBoardingRequired: $onboardingRequired)
        })
    }
}

#Preview {
    MainTabView()
}
