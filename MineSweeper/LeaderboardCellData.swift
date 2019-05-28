//
//  ListItemData.swift
//  MineSweeper
//
//  Created by ormilis on 28/05/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit

class LeaderboardCellData {
    
    private var name: String;
    private var score: Int;
    private var lat: Float;
    private var lng: Float;
    
    
    init(name: String, score: Int, lat: Float, lng: Float) {
        self.name = name;
        self.score = score;
        self.lat = lat;
        self.lng = lng;
    }
    
    public func GetName() -> String {
        return self.name;
    }
    
    public func GetScore() -> Int {
        return self.score;
    }
    
    public func GetLat() -> Float {
        return self.lat;
    }
    
    public func GetLng() -> Float {
        return self.lng;
    }
    
    public func GetDict() -> [String : Any] {
        return ["score" : self.score,
                "lat" : self.lat,
                "lng" : self.lng]
    }

}
