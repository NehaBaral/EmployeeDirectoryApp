//
//  SettingsView.swift
//  EmployeeDirectoryApp
//
//  Created by Neha on 2024-11-16.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
            NavigationView {
                Form {
                    Section(header: Text("App Information")) {
                        VStack(alignment: .leading) {
                            Text("App Name: Employee Directory")
                                .font(.headline)
                            Text("It displays a list of employees fetched from a JSON endpoint, search functionality for easy access to employee details. It features an onboarding screen for first-time users. Images are cached locally to optimize performance. It also includes a settings screen that provide information about the app and its developer.")
                                .font(.subheadline)
                        }
                    }
                    
                    Section(header: Text("Student Information")) {
                        VStack(alignment: .leading) {
                            Text("Name: Neha Baral")
                                .font(.headline)
                            Text("Student Number: 1265656")
                                .font(.subheadline)
                        }
                    }
                }
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
            }
            .background(Color(red: 0.95, green: 0.95, blue: 0.95)) // Light gray background
        }
    }

#Preview {
    SettingsView()
}
