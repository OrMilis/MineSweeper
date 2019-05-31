//
//  ConstManager.swift
//  MineSweeper
//
//  Created by Or Milis on 02/04/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit

final class UtilManager {
    public static let StoryBoardName: String = "Main";
    public static let MainMenuID: String = "MainMenu";
    public static let GameViewID: String = "GameView";
    public static let EndGameID: String = "EndGame";
    public static let GameCellID: String = "GameCell";
    public static let LeaderboardViewID: String = "LeaderboardView";
    public static let LeaderboardCellID: String = "LeaderboardCell";
    
    public enum Difficulty: String {
        case EASY = "Easy", NORMAL = "Normal", HARD = "Hard";
        
        func GetBoardSettings() -> (boardSize: Int, bombCount: Int){
            switch self {
            case .EASY:
                return (5, 5);
            case .NORMAL:
                return (10, 20);
            case .HARD:
                return (10, 30);
            }
        }
        
        func GetNextDifficulty() -> Difficulty {
            switch self{
            case .EASY:
                return .NORMAL;
            case .NORMAL:
                return .HARD;
            case .HARD:
                return .EASY;
            }
        }
        
        func GetValue() -> Int {
            switch self {
            case .EASY:
                return 3;
            case .NORMAL:
                return 2;
            case .HARD:
                return 1;
            }
        }
        
        func GetReverseValue() -> Int {
            switch self {
            case .EASY:
                return 1;
            case .NORMAL:
                return 2;
            case .HARD:
                return 3;
            }
        }
    }
    
    public enum WarningColor : Int {
        
        case ONE = 1,
        TWO = 2,
        THREE = 3,
        FOUR = 4,
        FIVE = 5,
        SIX = 6,
        SEVEN = 7,
        EIGHT = 8
                
        func GetColor() -> UIColor {
            switch self {
            case .ONE:
                return UIColor(rgb: 0x58C7D8);
            case .TWO:
                return UIColor(rgb: 0x67C39F);
            case .THREE:
                return UIColor(rgb: 0x67BE5B);
            case .FOUR:
                return UIColor(rgb: 0x73BF44);
            case .FIVE:
                return UIColor(rgb: 0xA3CD3D);
            case .SIX:
                return UIColor(rgb: 0xE5E63D);
            case .SEVEN:
                return UIColor(rgb: 0xE69E38);
            case .EIGHT:
                return UIColor(rgb: 0xE55639);
            }
        }
    }
    
    public static func GetCellBackgroundColor(isCellOpen: Bool)  -> UIColor {
        if(isCellOpen){
            return UIColor(rgb: 0xE5DAD1);
        }
        return UIColor(rgb: 0xFEF2E8);
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
    
    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: (rgb) & 0xFF, a: a)
    }
}
