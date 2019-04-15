//
//  GameViewController.swift
//  MineSweeper
//
//  Created by Or Milis on 24/03/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var flagLabel: UILabel!
    
    private let sectionInsets = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 0.0, right: 4.0);
    
    var nickname: String = "";
    
    var timer: Timer = Timer();
    
    var timerCounter: Int = 0;
    var flagCounter: Int = 0;
    
    var difficulty: UtilManager.Difficulty = UtilManager.Difficulty.NORMAL;
    var boardSize = 5;
    var bombCount = 10;
    
    var gameBoard: GameBoard = GameBoard();
    
    public func setUpGameView(nickname: String, difficulty: UtilManager.Difficulty) {
        self.nickname = nickname;
        
        self.difficulty = difficulty;
        let boardSettings = difficulty.GetBoardSettings();
        
        self.boardSize = boardSettings.boardSize;
        self.bombCount = boardSettings.bombCount;
        
        startGame();
    }
    
    public func startGame() {
        
        self.gameBoard = GameBoard(boardSize: self.boardSize, bombCount: self.bombCount);
        self.flagCounter = bombCount;
        
        if(timerCounter > 0) {
            self.timerCounter = 0;
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
                self.timerCounter += 1;
                let timerText = self.timerCounter > 999 ? 999 : self.timerCounter;
                self.timerLabel.text = String(format: "%03d", timerText);
            });
            
            self.timer.fire();
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.timerCounter += 1;
            let timerText = self.timerCounter > 999 ? 999 : self.timerCounter;
            self.timerLabel.text = String(format: "%03d", timerText);
        });
        
        self.timer.fire();
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.nameLabel.text = nickname;
        self.flagLabel.text = String(format: "%02d", self.flagCounter);
        self.gameCollectionView.reloadData();
    }
    
    @IBAction func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        if(sender.state == UIGestureRecognizer.State.began) {
            let touchPoint = sender.location(in: gameCollectionView);
            guard let indexPath = gameCollectionView.indexPathForItem(at: touchPoint) else { return; };
            
            if(flagCounter > 0){
                let pressData = gameBoard.markCellAsFlag(cellIndexPath: indexPath);
                
                flagCounter -= pressData.placedFlags;
                flagLabel.text = String(format: "%02d", flagCounter);
                
                notifyDataSetChanged(collectionView: gameCollectionView, indexPathArr: pressData.modifiedCells);
            }
        }
    }
    
    func endGame(gameStatus: String) {
        self.timer.invalidate();
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            let storyBoard: UIStoryboard = UIStoryboard(name: UtilManager.StoryBoardName, bundle: nil);
            guard let endViewController = storyBoard.instantiateViewController(withIdentifier: UtilManager.EndGameID) as? EndGameViewController else { return; };
            endViewController.setupView(nickname: self.nickname, gameStatus: gameStatus, difficulty: self.difficulty);
            
            self.navigationController?.pushViewController(endViewController, animated: true);
        });
    }
    
    func notifyDataSetChanged(collectionView: UICollectionView, indexPathArr: [IndexPath]) {
        collectionView.reloadItems(at: indexPathArr);
    }
    
    @IBAction func OnBackBtnClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
        let cellType = cellData.GetCellType();
        
        var cellText = "";
        var cellTextColor = UtilManager.WarningColor.ONE;
        let cellBackgroundColor = UtilManager.GetCellBackgroundColor(isCellOpen: cellData.IsCellOpen());
        
        //print("CELL VALUE: ", cellValue);
        if(cell.cellImage.image != nil) {
            cell.cellImage.image = nil;
        }
        
        switch cellType {
        case CellData.CellState.FLAG:
            cellText = "";
            cellTextColor = UtilManager.WarningColor.ONE;
            cell.cellImage.image = UIImage(named: "FlagIcon");
        case CellData.CellState.BOMB:
            cellText = "";
            cellTextColor = UtilManager.WarningColor.EIGHT;
            cell.cellImage.image = UIImage(named: "Mine");
        case CellData.CellState.VALUE:
            if(cellValue > 0){
                cellText = "\(cellValue)";
                cellTextColor = UtilManager.WarningColor(rawValue: cellValue) ?? UtilManager.WarningColor.ONE;
            }
            else {
                cellText = "";
                cellTextColor = UtilManager.WarningColor.ONE;
            }
        default:
            break;
        }
        
        cell.cellText.text = cellText;
        cell.cellText.textColor = cellTextColor.GetColor();
        cell.backgroundColor = cellBackgroundColor;
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let cell = collectionView.cellForItem(at: indexPath) as! GameCollectionCell;
        let pressData = gameBoard.touchCell(cellIndexPath: indexPath);
        
        /*print("AfterClick: ");
        dump(pressData.modifiedCells);*/
        
        notifyDataSetChanged(collectionView: collectionView, indexPathArr: pressData.modifiedCells);
        
        if(pressData.isLost) {
            endGame(gameStatus: "LOST");
        }
        else if(pressData.isWon) {
            endGame(gameStatus: "WON");
        }
        
        
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

