//
//  EmployeesViewmodel.swift
//  EmployeeDirectoryApp
//
//  Created by Neha on 2024-11-16.
//

import SwiftUI
import Observation

enum ViewModelError: Error {
    case apiError(APIError)
    case genericError(String)
}

@Observable
final class EmployeesViewmodel {
    private let service : EmployeesServiceType
    private(set) var employees : [EmployeeModel] = []
    private(set) var isLoading : Bool = false
    private(set) var error : ViewModelError?
    private(set) var errorMessage: String?
    var searchTerm: String = ""
    
    var searchResults : [EmployeeModel] = []
    
    var finalListData : [EmployeeModel]{
        return searchTerm.isEmpty ? employees : searchResults
    }
    
    init(service: EmployeesServiceType = EmployeesService()) {
        self.service = service
    }
    
    @MainActor
    func fetchEmployees() async {
        do {
            isLoading = true
            employees = try await service.fetchEmployees()
            isLoading = false
        }catch let apiError as APIError {
            print("Error : \(apiError)")
            isLoading = false
            handleApiError(apiError: apiError)
        }catch {
            
        }
    }
    
    func handleApiError(apiError : APIError) -> String{
        let message: String
               switch apiError {
               case .invalidRequest(let details):
                   message = "Invalid request: \(details)"
               case .invalidResponse(let details):
                   message = "Invalid response: \(details)"
               case .sessionTimeout:
                   message = "Your session has timed out. Please log in again."
               case .noData:
                   message = "No data available."
               case .decodingError:
                   message = "Error processing the data. Please try again."
               }
               self.error = .apiError(apiError)
               self.errorMessage = message
               return message
    }
    
    func clearError() {
            error = nil
    }
    
    func filterSearchResult(){
        searchResults = employees.filter({
            $0.full_name.localizedCaseInsensitiveContains(searchTerm)
        })
    }
    
    func refreshEmployees(){
       
    }
}
