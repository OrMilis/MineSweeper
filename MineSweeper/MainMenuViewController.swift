//
//  ViewController.swift
//  MineSweeper
//
//  Created by Or Milis on 24/03/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var difficultyBtn: UIButton!
    
    var difficulty: UtilManager.Difficulty = UtilManager.Difficulty.NORMAL;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func changeDifficulty(_ sender: Any) {
        difficulty = difficulty.GetNextDifficulty();
        difficultyBtn.setTitle(difficulty.rawValue, for: .normal);
    }
    
    @IBAction func OnPlayBtnClick(_ sender: Any) {
        /*guard let nickname = nameTextBox.text else { return; };
        
        let storyBoard: UIStoryboard = UIStoryboard(name: UtilManager.StoryBoardName, bundle: nil);
        
        guard let gameNavigationVC = storyBoard.instantiateViewController(withIdentifier: "GameNC") as? UINavigationController else { return; };
        
        guard let gameVC = gameNavigationVC.topViewController as? GameViewController else { return; };
        gameVC.setUpGameView(nickname: nickname, difficulty: self.difficulty);
        
        self.present(gameNavigationVC, animated: true, completion: nil);*/
        
        let storyBoard: UIStoryboard = UIStoryboard(name: UtilManager.StoryBoardName, bundle: nil);
        guard let endViewController = storyBoard.instantiateViewController(withIdentifier: UtilManager.LeaderboardViewID) as? LeaderboardViewController else { return; };
        
        self.navigationController?.pushViewController(endViewController, animated: true);
    }
    
}

