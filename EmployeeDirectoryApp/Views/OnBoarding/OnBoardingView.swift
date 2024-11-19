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
            Text("Welcome to Employee List")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.vertical, 16)
                .padding(.top, 8)
            
            Spacer()
                .frame(height: 80)
            
            Image("onboarding_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text("Manage your employees efficiently and stay updated with real-time information.")
            .font(.body)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .foregroundColor(.white)
            
            Spacer()
            Button(action: {
                onBoardingRequired = false
            }) {
                Text("Get Started")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(width: 200, height: 50)
                .background(Color(red: 223/255, green: 43/255, blue: 12/255))
                .cornerRadius(10)
            }.padding(.bottom, 50)
        }
        .padding()
        .background(Color(red: 12/255, green: 192/255, blue: 223/255))
        .edgesIgnoringSafeArea(.all)
    }
}
