//
//  EmployeeCache.swift
//  EmployeeDirectoryApp
//
//  Created by Neha on 2024-12-07.
//
import SwiftUI
import Observation

class EmployeeCache {
    private let cache = NSCache<NSString, AnyObject>()
   
   func setObject(_ object: AnyObject, forKey key: String) {
       cache.setObject(object, forKey: key as NSString)
   }
   
   func getObject(forKey key: String) -> AnyObject? {
       return cache.object(forKey: key as NSString)
   }
   
   func removeObject(forKey key: String) {
       cache.removeObject(forKey: key as NSString)
   }
}
