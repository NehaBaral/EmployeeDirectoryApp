//
//  APIError.swift
//  EmployeeDirectoryApp
//
//  Created by Neha on 2024-11-17.
//

import Foundation

enum APIError: Error {
    case invalidRequest(String)
    case invalidResponse(String)
    case sessionTimeout
    case noData
    case decodingError(Error)
}
