//
//  GameViewController.swift
//  MineSweeper
//
//  Created by Or Milis on 24/03/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    private let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 0.0, right: 5.0);
    
    var items = [[Int]](repeating: [Int](repeating: 0, count: 10), count:10);
    var index = 0;
    
    //var gameBoard = [[CellData]]();
    var bombPositions = [Int]();
    
    var boardSize = 0;
    var bombCount = 0;
    
    var gameBoard = GameBoard(boardSize: 10, bombCount: 10);
    
    override func viewDidLoad() {
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
        return items.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[0].count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConstManager.GameCellID, for: indexPath) as! GameCollectionCell;
        
        let cellData = gameBoard.getCellDataAt(indexPath: indexPath);
        let cellValue = cellData.GetCellValue();
        
        print("CELL VALUE: ", cellValue);
        cell.cellText.text = "\(cellValue)";
        if(cellValue == -1) {
            cell.cellText.text = "X"
        }
        else if(cellValue == 0){
            cell.cellText.text = ""
        }
        
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
        
        let sizeOfBoard = CGFloat(items.count);
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

