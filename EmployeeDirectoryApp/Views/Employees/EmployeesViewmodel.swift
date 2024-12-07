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
    private let employeeCache = EmployeeCache()
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
        isLoading = true
        if let cachedEmployees = employeeCache.getObject(forKey: "employees") as? [EmployeeModel] {
                   self.employees = cachedEmployees
            isLoading = false
               } else {
                   do {
                       let fetchedEmployees = try await service.fetchEmployees()
                       self.employees = fetchedEmployees
                       employeeCache.setObject(fetchedEmployees as AnyObject, forKey: "employees")
                   } catch let apiError as APIError {
                       handleApiError(apiError: apiError)
                   }catch{
                       self.errorMessage = "Something went wrong."
                   }
                   isLoading = false
               }
    }
    
    func handleApiError(apiError : APIError){
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
    }
    
    func filterSearchResult(){
        searchResults = employees.filter({
            $0.full_name.localizedCaseInsensitiveContains(searchTerm)
        })
    }
    
    func refreshEmployees() async{
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
        if let cachedEmployees = employeeCache.getObject(forKey: "employees") as? [EmployeeModel] {
            self.employees = cachedEmployees
            filterSearchResult()
        }
    }
}
