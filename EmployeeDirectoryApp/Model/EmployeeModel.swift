//
//  EmployeeModel.swift
//  EmployeeDirectoryApp
//
//  Created by Neha on 2024-11-16.
//

import SwiftUI

struct EmployeeModel: Decodable, Identifiable {
    var id: String { uuid }
    var uuid : String
    var full_name : String
    var phone_number : String?
    var email_address : String
    var biography : String?
    var photo_url_small : String?
    var photo_url_large : String?
    var team : String
    var employee_type : String
    
    var employeeType : String{
        switch(employee_type){
        case "FULL_TIME":
            return "Full time"
            
        case "PART_TIME":
            return "Part time"
            
        case "CONTRACTOR":
            return "Contractor"
            
        default:
            return employee_type
        }
    }
}

struct EmployeesList : Decodable {
    let employees : [EmployeeModel]
}
