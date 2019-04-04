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
    
    private var cellType: cellState;
    private var cellValue: Int;
    
    init(cellType: cellState, cellValue: Int) {
        self.cellType = cellType;
        self.cellValue = cellValue;
    }
    
    public func setAsBomb() {
        self.cellType = cellState.HIDDEN_BOMB;
        self.cellValue = -1;
    }
    
    public func IncrementValue() {
        self.cellValue += 1;
    }
    
    public func GetCellType() -> cellState {
        return self.cellType;
    }
    
    public func GetCellValue() -> Int {
        return self.cellValue;
    }
}
