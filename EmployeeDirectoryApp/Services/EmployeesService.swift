//
//  EmployeesService.swift
//  EmployeeDirectoryApp
//
//  Created by Neha on 2024-11-16.
//

import Foundation

protocol EmployeesServiceType{
    
    
    /// This method is responsible for fetching data of type T from given url asynchronously
    /// - Parameters:
    ///   - type: Decodable
    ///   - urlString: String
    /// - Returns: Decodable
    func fetch<T : Decodable>(type: T.Type, from urlString: String) async throws -> T?
    
    
    /// This method fetches a collection of employees asynchronously
    /// - Returns: An array of employee.
    func fetchEmployees() async throws -> [EmployeeModel]
}

final class EmployeesService : EmployeesServiceType{
    struct Paths{
        static let employeesUrl = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    }
    
    func fetch<T>(type: T.Type, from urlString: String) async throws -> T? where T : Decodable {
        guard let url = URL(string: urlString) else{
            throw APIError.invalidRequest("Invalid find request path")
        }
        
        do {
            let (data, _) = try await URLSession
                .shared
                .data(from: url)
            let decoder = JSONDecoder()
            
            return try decoder.decode(type, from: data)
        }catch{
            throw APIError.invalidResponse("Unexpected server responses")
        }
    }
    
    func fetchEmployees() async throws -> [EmployeeModel] {
        let employees = try await fetch(type: EmployeesList.self, from: Paths.employeesUrl)
        guard !employees!.employees.isEmpty else {
            throw APIError.invalidResponse("No Data found")
        }
        return employees?.employees ?? []
    }
    
    
}
