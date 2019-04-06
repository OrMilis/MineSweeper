//
//  CellData.swift
//  MineSweeper
//
//  Created by Or Milis on 02/04/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit

class CellData {
    
    public enum CellState {
        case HIDDEN_VALUE, VALUE, HIDDEN_BOMB, BOMB, FLAG
    }
    
    private var cellType: CellState = CellState.HIDDEN_VALUE;
    private var cellValue: Int = 0;
    
    public func setAsBomb() {
        self.cellType = CellState.HIDDEN_BOMB;
        self.cellValue = -1;
    }
    
    public func IncrementValue() {
        self.cellValue += 1;
    }
    
    public func OpenCell() {
        self.cellType = CellState.VALUE;
    }
    
    public func GetCellType() -> CellState {
        return self.cellType;
    }
    
    public func GetCellValue() -> Int {
        return self.cellValue;
    }
}
