//
//  EmployeeDetailView.swift
//  EmployeeDirectoryApp
//
//  Created by Neha on 2024-11-17.
//

import SwiftUI

struct EmployeeDetailView: View {
    let employee : EmployeeModel
    @State private var shouldLoadImage = false
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                ZStack(alignment: .leading){
                    AsyncImage(url: URL(string: employee.photo_url_small ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 250) // Height for consistency
                        case .success(let image):
                            image.resizable()
                                .frame(height: 250) // Height for consistency
                                .clipped() // Ensure the image is clipped to its frame
                                .cornerRadius(20)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFill()
                                .frame(height: 250) // Height for consistency
                                .clipped()
                            
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    Text(employee.full_name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .offset(y : 100)
                        .padding(.leading, 8)
                        .shadow(color: .black, radius: 2, x: 0, y: 0)
                }
                
                Text(employee.biography ?? "Not Available")
                    .padding(.top, 8)
                
                HStack{
                    Text("Team : ")
                        .foregroundColor(.brown)
                        .fontWeight(.semibold)
                    
                    Text(employee.team)
                }.padding(.top, 8)
                
                HStack{
                    Text("Employee Type :")
                        .foregroundColor(.brown)
                        .fontWeight(.semibold)
                    
                    Text(employee.employeeType)
                }.padding(.top, 8)
                
                Text("Contact Information")
                    .padding(.top, 16)
                    .fontWeight(.semibold)
                Label(employee.email_address, systemImage: "envelope.circle.fill")
                    .imageScale(.large)
                    .foregroundColor(.indigo)
                    .padding(.top,4)
                Label(employee.phone_number ?? "Not available", systemImage: "phone.circle.fill")
                    .imageScale(.large)
                    .foregroundColor(.orange)
                    .padding(.top,4)
                
                Button(action: {
                    shouldLoadImage = !shouldLoadImage
                }){
                    Text("Tab to Load Image")
                    
                }.padding(.top, 8)
                    .buttonStyle(.bordered)
                
                if shouldLoadImage {
                    AsyncImage(url: URL(string: employee.photo_url_large ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 250)// Height for consistency
                        case .success(let image):
                            image.resizable()
                                .frame(height: 250) // Height for consistency
                                .clipped() // Ensure the image is clipped to its frame
                                .cornerRadius(20)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFill()
                                .frame(height: 250) // Height for consistency
                                .clipped()
                            
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                
                Spacer()
            }.padding(.horizontal, 16)
            
        }
    }
}

