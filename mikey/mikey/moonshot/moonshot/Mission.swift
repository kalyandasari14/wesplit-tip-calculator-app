//
//  Mission.swift
//  moonshot
//
//  Created by kalyan on 2/7/26.
//

import Foundation


struct Mission: Codable, Identifiable {
    struct crewRole: Codable{
        let name: String
        let role: String
        
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [crewRole]
    let description: String
    
    
    var displayName:String{
        "Appolo\(id)"
    }
    
    var image:String{
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        // Tell it exactly what the types are
        if let date = launchDate {
            return date.formatted(date: .abbreviated, time: .omitted)
        } else {
            return "N/A"
        }
    }
}
