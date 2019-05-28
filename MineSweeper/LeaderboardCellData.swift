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

}
