//
//  GameBoard.swift
//  MineSweeper
//
//  Created by Or Milis on 04/04/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit

class GameBoard {
    var board = [[CellData]](repeating: [CellData](repeating: CellData(cellType: CellData.cellState.HIDDEN_VALUE, cellValue: 0), count: 10), count: 10);
    var bombPositions = [(row: Int, col: Int)]();
    
    let boardSize: Int;
    let bombCount: Int;
    
    init(boardSize: Int, bombCount: Int) {
        self.boardSize = boardSize;
        self.bombCount = bombCount;
    }
    
    public func setUpBoard() {
        print("Before: ")
        printBoard();
        
        placeBombs();
        /*for bombPosition in bombPositions {
            calculateBombArea(bombRow: bombPosition.row, bombCol: bombPosition.col);
        }*/
        
        print("After: ")
        printBoard();
     
    }
    
    func printBoard() {
        for (_, subArr) in board.enumerated() {
            for(_, cellData) in subArr.enumerated() {
                print(cellData.GetCellValue(), " ", terminator: "");
            }
            print();
        }
    }
    
    func placeBombs() {
        let maxPos = (boardSize * boardSize) - 1;
        var avaliablePositions = Set<Int>(0...maxPos);
        
        var remainingBomb = bombCount;
        
        for _ in 0...bombCount {
            guard let bombPos = avaliablePositions.randomElement() else { return; };
            let bombRowCol = (row: bombPos / 10, col: bombPos % 10);
            board[bombRowCol.row][bombRowCol.col].setAsBomb();
            
            remainingBomb -= 1;
            print();
            print("CurrentBomb Pos: ", bombPos);
            print("remainingBombs: ", remainingBomb);
            printBoard();
            print();
            
            bombPositions.append(bombRowCol);
            avaliablePositions.remove(bombPos);
        }
    }
    
    func calculateBombArea(bombRow: Int, bombCol: Int) {
        //TO DO: Implemetion of cell values calculation.
        let bombLeftUpCorner = (row: bombRow - 1, col: bombCol - 1);
        let bombRightDownCorner = (row: bombRow + 1, col: bombCol + 1);
        for row in bombLeftUpCorner.row...bombRightDownCorner.row {
            for col in bombLeftUpCorner.col...bombRightDownCorner.col {
                if(row < 0 || row >= boardSize || col < 0 || col >= boardSize) { continue; };
                
                let cell = board[row][col];
                if(cell.GetCellType() == CellData.cellState.HIDDEN_VALUE) {
                    cell.IncrementValue();
                }
            }
        }
    }
    
    
}
