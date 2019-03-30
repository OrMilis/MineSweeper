//
//  GameViewController.swift
//  MineSweeper
//
//  Created by Or Milis on 24/03/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var items = [[Int]](repeating: [Int](repeating: 0, count: 10), count:10);
    var index = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (sectionIndex, section) in items.enumerated() {
            for (itemIndex, _) in section.enumerated() {
                let value = sectionIndex * 10 + itemIndex;
                items[sectionIndex][itemIndex] = value;
                print(sectionIndex, itemIndex, value, separator: "  ");
            }
        }
        // Do any additional setup after loading the view.
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[0].count;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCollectionCell;
        
        let item = items[indexPath.section][indexPath.item];
        print("item: ", item);
        cell.cellText.text = "\(item)";
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GameCollectionCell;
        guard let cellText = cell.cellText.text else { return; };
        print(cellText);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfBoard = items.count;
        print("top: ", collectionView.layoutMargins.top);
        let spacingSize = collectionView.layoutMargins.top * CGFloat(numberOfBoard + 1);
        let cellWidth = (collectionView.bounds.width - spacingSize) / 10;
        let cellHeight = cellWidth;
        
        return CGSize(width: cellWidth, height: cellHeight);
    }

}

