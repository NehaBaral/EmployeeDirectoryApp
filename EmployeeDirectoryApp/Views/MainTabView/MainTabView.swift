//
//  MainTabView.swift
//  EmployeeDirectoryApp
//
//  Created by Neha on 2024-11-16.
//

import SwiftUI

struct MainTabView: View {
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
        }
    }
}

#Preview {
    MainTabView()
}
