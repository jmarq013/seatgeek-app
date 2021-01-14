//
//  Venue.swift
//  SeatGeekApp
//
//  Created by Julio Marquez on 1/6/21.
//

import Foundation

struct Venue: Decodable {
    var state: String
    var city: String
    
    private enum CodingKeys: String, CodingKey {
        case state
        case city
    }
}
