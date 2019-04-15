//
//  GameBoard.swift
//  MineSweeper
//
//  Created by Or Milis on 04/04/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit

class GameBoard {
    var board = [[CellData]]();
    var bombPositions = [(row: Int, col: Int)]();
    
    let boardSize: Int;
    let bombCount: Int;
    
    var isBoardSet = false;
    
    var closedCells: Int;
    
    init(boardSize: Int = 1, bombCount: Int = 1) {
        self.boardSize = boardSize;
        self.bombCount = bombCount;
        self.closedCells = boardSize * boardSize;
        
        for _ in 0...boardSize - 1 {
            var tempArr = [CellData]();
            for _ in 0...boardSize - 1 {
                tempArr.append(CellData());
            }
            board.append(tempArr);
        }
    }
    
    public func setUpBoard(startCellIndex: Int) {
        var emptyCells = [Int]();
        let cellTuple = indexToTuple(index: startCellIndex);
        
        emptyCells += iterateOnCellAreaWithBlock(cellTuple: cellTuple, block: { (row, col)  -> Int in
            return tupleToIndex(tuple: (row, col));
        });
        
        //dump(emptyCells);
        
        placeBombs(emptyCells: emptyCells);
        for bomb in bombPositions {
            calculateBombArea(bombTuple: bomb);
        }
    }
    
    func placeBombs(emptyCells: [Int]) {
        let maxPos = (boardSize * boardSize) - 1;
        var avaliablePositions = Set<Int>(0...maxPos);
        
        for cell in emptyCells {
            avaliablePositions.remove(cell);
        }
        
        for _ in 0...bombCount - 1 {
            guard let bombPos = avaliablePositions.randomElement() else { return; };
            let bombTuple = indexToTuple(index: bombPos);
            
            board[bombTuple.row][bombTuple.col].setAsBomb();
            
            bombPositions.append(bombTuple);
            avaliablePositions.remove(bombPos);
        }
    }
    
    func calculateBombArea(bombTuple: (row: Int, col: Int)) {
        //TO DO: Implemetion of cell values calculation.
        let _ = iterateOnCellAreaWithBlock(cellTuple: bombTuple, block: { row, col -> (row: Int, col: Int) in
            /*print("In Calc Block:");
            print("Row: ", row, "Col: ", col);*/
            let cell = board[row][col];
            if(cell.GetCellType() == CellData.CellState.HIDDEN_VALUE) {
                cell.IncrementValue();
            }
            return (row, col);
        });
    }
    
    public func touchCell(cellIndexPath: IndexPath) -> (modifiedCells: [IndexPath], isWon: Bool, isLost: Bool) {
        
        let isLost: Bool;
        let isWon: Bool = closedCells == bombCount ? true : false;
        let cellIndex = tupleToIndex(tuple: (cellIndexPath.section, cellIndexPath.item));
        
        if(!isBoardSet) {
            isBoardSet = true;
            setUpBoard(startCellIndex: cellIndex);
        }
        
        let modifiedCells: [IndexPath];
        if(isCellBomb(cellIndex: cellIndex)){
            modifiedCells = openAll();
            isLost = true;
        }
        else {
            modifiedCells = openCell(cellIndex: cellIndex);
            isLost = false;
        }
        
        return (modifiedCells, isWon, isLost);
    }
    
    func markCellAsFlag(cellIndexPath: IndexPath) -> (modifiedCells: [IndexPath], placedFlags: Int) {
        var modifiedCells = [IndexPath]();
        var placedFlags = 0;
        
        let cellIndex = tupleToIndex(tuple: (cellIndexPath.section, cellIndexPath.item));
        let cellTuple = indexToTuple(index: cellIndex);
        let cell = board[cellTuple.row][cellTuple.col];
        
        if(!cell.IsCellOpen()) {
            if(cell.GetCellType() == CellData.CellState.FLAG) {
                cell.cancelFlagMark();
                placedFlags = -1;
            }
            else {
                cell.setAsFlag();
                placedFlags = 1;
            }
            modifiedCells.append(cellIndexPath);
        }
        
        return (modifiedCells, placedFlags);
    }
    
    func openCell(cellIndex: Int) -> [IndexPath] {
        let cellTuple = indexToTuple(index: cellIndex);
        var indexPathArr = [IndexPath]();
        
        //print("In OpenCell(): cellIndex = ", cellIndex);
        
        let cell = board[cellTuple.row][cellTuple.col];
        let cellType = cell.GetCellType();
        
        //print("OpenCell(): cellType = ", cellType);
        
        switch cellType {
        case CellData.CellState.HIDDEN_VALUE:
            
            cell.OpenCell();
            closedCells -= 1;
            indexPathArr.append(IndexPath(item: cellTuple.col, section: cellTuple.row));
            
            if(cell.GetCellValue() > 0) {
                return indexPathArr;
            }
            else {
                let blockIndexPathArr =
                    iterateOnCellAreaWithBlock(cellTuple: cellTuple, block: { row, col -> [IndexPath] in
                        let tempTuple = (row, col);
                        /*print("In OpenCell Block: ");
                        print("Tuple: ", tempTuple);*/
                        return openCell(cellIndex: tupleToIndex(tuple: tempTuple));
                    });
                for indexPathSubArr in blockIndexPathArr {
                    for indexPath in indexPathSubArr {
                        indexPathArr.append(indexPath);
                    }
                }
            }
            return indexPathArr;
        default:
            return indexPathArr;
        }
    }
    
    func openAll() -> [IndexPath]{
        var indexPathArr = [IndexPath]();
        for (section, cellSubArr) in board.enumerated() {
            for (item, cell) in cellSubArr.enumerated() {
                cell.OpenCell();
                indexPathArr.append(IndexPath(item: item, section: section));
            }
        }
        return indexPathArr;
    }
    
    func isCellBomb(cellIndex: Int) -> Bool {
        let cellTuple = indexToTuple(index: cellIndex);
        let cellData = board[cellTuple.row][cellTuple.col];
        
        return cellData.GetCellType() == CellData.CellState.HIDDEN_BOMB ? true : false;
    }
    
    public func getCellDataAt(indexPath: IndexPath) -> CellData {
        return board[indexPath.section][indexPath.item];
    }
    
    //GameBoard Util Functions
    
    func indexToTuple(index: Int) -> (row: Int, col: Int) {
        return (index / boardSize, index % boardSize);
    }
    
    func tupleToIndex(tuple: (row: Int, col: Int)) -> Int {
        return tuple.row * boardSize + tuple.col;
    }
    
    func iterateOnCellAreaWithBlock<T>(cellTuple: (row: Int, col: Int), block: (_ blockRow: Int, _ blockCol: Int) -> T) -> [T] {
        
        var genericArr = [T]();
        
        let cellLeftUpCorner = (row: cellTuple.row - 1, col: cellTuple.col - 1);
        let cellRightDownCorner = (row: cellTuple.row + 1, col: cellTuple.col + 1);
        
        for row in cellLeftUpCorner.row...cellRightDownCorner.row {
            for col in cellLeftUpCorner.col...cellRightDownCorner.col {
                if(isNotDefinedInArray(cellTuple: (row, col))) { continue; };

                genericArr.append(block(row, col));
            }
        }
        
        return genericArr;
    }
    
    func isNotDefinedInArray(cellTuple: (row: Int, col: Int)) -> Bool {
        return cellTuple.row < 0 || cellTuple.row >= boardSize
            || cellTuple.col < 0 || cellTuple.col >= boardSize;
    }
    
    func printBoard() {
        for subArr in board {
            for cell in subArr {
                let cellValue = cell.GetCellValue();
                let str = String(format: "%02d", cellValue);
                print(str, " ", terminator: "");
            }
            print();
        }
    }
    
}
