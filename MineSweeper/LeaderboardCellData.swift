//
//  ListItemData.swift
//  MineSweeper
//
//  Created by ormilis on 28/05/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit
import MapKit

class LeaderboardCellData: NSObject, MKAnnotation {
    
    private var name: String;
    private var score: Int;
    private var lat: Double;
    private var lng: Double;
    private var difficulty: String;
    var coordinate: CLLocationCoordinate2D
    
    init(name: String, score: Int, lat: Double, lng: Double, difficulty: String) {
        self.name = name;
        self.score = score;
        self.lat = lat;
        self.lng = lng;
        self.difficulty = difficulty;
        
        self.coordinate = CLLocationCoordinate2D(latitude: self.lat, longitude: self.lng);
    }
    
    public func SetName(name: String) {
        self.name = name;
    }
    
    public func SetScore(score: Int) {
        self.score = score;
    }
    
    public func SetLat(lat: Double) {
        self.lat = lat;
        updateCoordinate();
    }
    
    public func SetLng(lng: Double) {
        self.lng = lng;
        updateCoordinate();
    }
    
    public func SetDifficulty(difficulty: String) {
        self.difficulty = difficulty;
    }
    
    private func updateCoordinate() {
        self.coordinate = CLLocationCoordinate2D(latitude: self.lat, longitude: self.lng);
    }
    
    public func GetName() -> String {
        return self.name;
    }
    
    public func GetScore() -> Int {
        return self.score;
    }
    
    public func GetLat() -> Double {
        return self.lat;
    }
    
    public func GetLng() -> Double {
        return self.lng;
    }
    
    public func GetDifficulty() -> String {
        return self.difficulty;
    }
    
    public func GetDict() -> [String : Any] {
        return ["score" : self.score,
                "lat" : self.lat,
                "lng" : self.lng,
                "difficulty" : self.difficulty]
    }
    
    var title: String? {
        return self.name
    }
    
    var subtitle: String? {
        return difficulty + ": " + String(self.score)
    }

}
