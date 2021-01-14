//
//  EventService.swift
//  SeatGeekApp
//
//  Created by Julio Marquez on 1/6/21.
//

import Foundation
import UIKit

struct EventService: Decodable {
    var events: [Event]?
    
    static func fetchEvents(completion: @escaping (Result<EventService, Error>) -> Void) {
        var urlComponents = URLComponents(string: "https://api.seatgeek.com/2/events")!
        let clientId = "MjE0NTM3NjN8MTYwODM5NzQzNy43NTY4MzY3"
        urlComponents.queryItems = ["client_id": clientId].map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let eventService = try jsonDecoder.decode(EventService.self, from: data)
                    completion(.success(eventService))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    enum EventError: Error, LocalizedError {
        case imageDataMissing
    }
    
    static func fetchImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.scheme = "https"
        
        let task = URLSession.shared.dataTask(with: urlComponents!.url!) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(EventError.imageDataMissing))
            }
        }
        
        task.resume()
    }
}
