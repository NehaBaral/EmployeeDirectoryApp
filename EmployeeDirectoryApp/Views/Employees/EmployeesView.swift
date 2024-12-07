//
//  EmployeesView.swift
//  EmployeeDirectoryApp
//
//  Created by Neha on 2024-11-16.
//

import SwiftUI

struct EmployeesView: View {
    @State var viewModel : EmployeesViewmodel
    
    init(viewModel: EmployeesViewmodel = EmployeesViewmodel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack{
            if viewModel.isLoading {
                ProgressView("Fetching employees...")
                    .progressViewStyle(CircularProgressViewStyle())
            }else if viewModel.errorMessage != nil  {
                showErrorView
            }else {
                listViewContent
            }
        }
        .onAppear() {
            Task {
                await viewModel.fetchEmployees()
            }
        }
        
    }
    
    @ViewBuilder
    var showErrorView : some View{
        VStack {
            Text(viewModel.errorMessage!)
                .foregroundColor(.red)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
                }
    }
    
    @ViewBuilder
    var listViewContent : some View{
        List(viewModel.finalListData){employee in
            NavigationLink(destination: EmployeeDetailView(employee: employee)){
                HStack{
                    AsyncImage(url: URL(string: employee.photo_url_small ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 100, height: 100) // Height for consistency
                        case .success(let image):
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100) // Height for consistency
                                .clipped() // Ensure the image is clipped to its frame
                                .cornerRadius(20)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100) // Height for consistency
                                .clipped()
                            
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    VStack(alignment: .leading){
                        Text(employee.full_name)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            
                        Text(employee.team)
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                }
            }
        }.navigationTitle("Employees")
            .searchable(text: $viewModel.searchTerm, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search for Employees")
            .onChange(of: viewModel.searchTerm){
                viewModel.filterSearchResult()
            }
            .listStyle(.plain)
            .refreshable {
                await viewModel.refreshEmployees()
            }

    }
}

#Preview {
    EmployeesView()
}
