//
//  CellData.swift
//  MineSweeper
//
//  Created by Or Milis on 02/04/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit

class CellData {
    
    public enum cellState {
        case HIDDEN_VALUE, VALUE, BOMB, HIDDEN_BOMB
    }
    
    var cellType: cellState?;
    var cellValue: Int?;
    
    init(cellType: cellState, cellValue: Int) {
        self.cellType = cellType;
        self.cellValue = cellValue;
    }
    
    func setAsBomb() {
        cellType = cellState.BOMB;
        cellValue = -1;
    }
}
