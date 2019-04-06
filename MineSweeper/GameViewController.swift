//
//  GameViewController.swift
//  MineSweeper
//
//  Created by Or Milis on 24/03/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    private let sectionInsets = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 0.0, right: 4.0);
    
    var bombPositions = [Int]();
    
    var boardSize = 5;
    var bombCount = 10;
    
    var gameBoard: GameBoard = GameBoard(boardSize: 1, bombCount: 1);
    
    override func viewDidLoad() {
        gameBoard = GameBoard(boardSize: boardSize, bombCount: bombCount);
        super.viewDidLoad()
        
        /*for (sectionIndex, section) in items.enumerated() {
            for (itemIndex, _) in section.enumerated() {
                let value = sectionIndex * 10 + itemIndex;
                items[sectionIndex][itemIndex] = value;
                //print(sectionIndex, itemIndex, value, separator: "  ");
            }
        }*/
        // Do any additional setup after loading the view.
    }
    
    func notifyDataSetChanged(collectionView: UICollectionView, indexPathArr: [IndexPath]) {
        collectionView.reloadItems(at: indexPathArr);
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return boardSize;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardSize;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UtilManager.GameCellID, for: indexPath) as! GameCollectionCell;
        
        let cellData = gameBoard.getCellDataAt(indexPath: indexPath);
        let cellValue = cellData.GetCellValue();
        
        let cellText: String;
        let cellTextColor: UtilManager.WarningColor;
        let cellBackgroundColor = UtilManager.GetCellBackgroundColor(isCellOpen: cellData.IsCellOpen());
        
        print("CELL VALUE: ", cellValue);
        
        if(cellValue > 0){
            cellText = "\(cellValue)";
            cellTextColor = UtilManager.WarningColor(rawValue: cellValue) ?? UtilManager.WarningColor.ONE;
            
        }
        else if(cellValue == -1){
            cellText = "X";
            cellTextColor = UtilManager.WarningColor.EIGHT;
        }
        else {
            cellText = "";
            cellTextColor = UtilManager.WarningColor.ONE;
        }
        
        cell.cellText.text = cellText;
        cell.cellText.textColor = cellTextColor.GetColor();
        cell.backgroundColor = cellBackgroundColor;
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let cell = collectionView.cellForItem(at: indexPath) as! GameCollectionCell;
        let modifiedCells = gameBoard.touchCell(cellIndexPath: indexPath);
        
        print("AfterClick: ");
        dump(modifiedCells);
        
        notifyDataSetChanged(collectionView: collectionView, indexPathArr: modifiedCells);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sizeOfBoard = CGFloat(boardSize);
        //print("top: ", collectionView.adjustedContentInset.top);
        let paddingSpace = sectionInsets.left * (sizeOfBoard + 1);
        let availableWidth = collectionView.frame.width - paddingSpace;
        let cellWidth = availableWidth / sizeOfBoard;
        
        return CGSize(width: cellWidth, height: cellWidth);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //print("Width: ", collectionView.frame.width, " Height: ", collectionView.frame.height);
        return sectionInsets;
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left;
    }
}

