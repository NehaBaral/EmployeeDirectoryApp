//
//  OnBoardingView.swift
//  EmployeeDirectoryApp
//
//  Created by Neha on 2024-11-18.
//

import SwiftUI

struct OnBoardingView: View {
    @Binding var onBoardingRequired: Bool
    
    var body: some View {
        VStack{
            Text("Hello World")
            Spacer()
            Button("Next"){
                onBoardingRequired = false
            }
        }
    }
}
