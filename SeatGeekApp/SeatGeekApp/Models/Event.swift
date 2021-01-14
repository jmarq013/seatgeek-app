//
//  Event.swift
//  SeatGeekApp
//
//  Created by Julio Marquez on 12/17/20.
//

import Foundation

struct Event: Decodable {
    var title: String
    var dateTime: String
    var venue: Venue
    var performers: [Performer]
    var isFavorite = false
    var id: Int
    
    private enum CodingKeys: String, CodingKey {
        case title
        case dateTime = "datetime_utc"
        case venue
        case performers
        case id
    }
    
    static func formatDateFromUTC(with string: String, for element: String) -> String {
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ss"
        utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let utcDate = utcDateFormatter.date(from: string)
        
        let dateFormatter = DateFormatter()
        switch element {
        case "date":
            dateFormatter.dateFormat = "EEEE, d MMM YYYY"
        case "time":
            dateFormatter.dateFormat = "h:mm a"
        default:
            dateFormatter.dateFormat = "EEEE, d MMM YYYY h:mm a"
        }
        
        let dateString = dateFormatter.string(from: utcDate!)
        
        return dateString
    }
}
