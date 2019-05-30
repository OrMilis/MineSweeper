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
    
    public func GetDict() -> [String : Any] {
        return ["score" : self.score,
                "lat" : self.lat,
                "lng" : self.lng]
    }
    
    var title: String? {
        return self.name
    }
    
    var subtitle: String? {
        return difficulty + ": " + String(self.score)
    }

}
