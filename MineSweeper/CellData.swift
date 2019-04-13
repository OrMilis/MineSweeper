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
    private var isCellOpen = false;
    
    public func setAsBomb() {
        self.cellType = CellState.HIDDEN_BOMB;
        self.cellValue = -1;
    }
    
    public func setAsFlag() {
        self.cellType = CellState.FLAG;
    }
    
    public func cancelFlagMark() {
        if (cellValue != -1) {
            cellType = CellState.HIDDEN_VALUE;
        }
        else {
            cellType = CellState.HIDDEN_BOMB;
        }
    }
    
    public func IncrementValue() {
        self.cellValue += 1;
    }
    
    public func OpenCell() {
        switch cellType {
        case .HIDDEN_VALUE:
            self.cellType = CellState.VALUE;
        case .HIDDEN_BOMB:
            self.cellType = CellState.BOMB;
        default:
            break;
        }
        
        self.isCellOpen = true;
    }
    
    public func GetCellType() -> CellState {
        return self.cellType;
    }
    
    public func GetCellValue() -> Int {
        return self.cellValue;
    }
    
    public func IsCellOpen() -> Bool {
        return self.isCellOpen;
    }
}
