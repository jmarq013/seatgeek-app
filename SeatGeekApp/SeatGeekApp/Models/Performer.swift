//
//  Performer.swift
//  SeatGeekApp
//
//  Created by Julio Marquez on 1/8/21.
//

import Foundation

struct Performer: Decodable {
    var imageUrl: URL
    
    private enum CodingKeys: String, CodingKey {
        case imageUrl = "image"
    }
}
