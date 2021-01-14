//
//  Favorites.swift
//  SeatGeekApp
//
//  Created by Julio Marquez on 1/11/21.
//

import Foundation

struct Favorites: Codable {
    private static var favoritesKey = "Favorites"
    
    private static func saveToFile(events: Set<Int>) {
        let eventsArray = Array(events)
        UserDefaults.standard.setValue(eventsArray, forKey: favoritesKey)
    }
    
    static func addToFavorites(_ eventID: Int) {
        var favorites = loadFromFile()
        favorites.insert(eventID)
        saveToFile(events: favorites)
    }
    
    static func removeFromFavorties(_ eventID: Int) {
        var favorites = loadFromFile()
        favorites.remove(eventID)
        saveToFile(events: favorites)
    }
    
    static func isFavorite(_ eventID: Int) -> Bool {
        let favorites = loadFromFile()
        return favorites.contains(eventID)
    }
    
    private static func loadFromFile() -> Set<Int> {
        let favoritesArray = UserDefaults.standard.value(forKey: favoritesKey) as! [Int]
        let favoritesSet = Set(favoritesArray)
        return favoritesSet
    }
    
    static func registerFavorites() {
        UserDefaults.standard.register(defaults: ["Favorites": [Int]()])
    }
}
