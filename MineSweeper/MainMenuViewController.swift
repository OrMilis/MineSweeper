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
        guard let nickname = nameTextBox.text else { return; };
        
        let storyBoard: UIStoryboard = UIStoryboard(name: UtilManager.StoryBoardName, bundle: nil);
        let gameViewController = storyBoard.instantiateViewController(withIdentifier: UtilManager.GameViewID) as! GameViewController;
        gameViewController.setUpGameView(nickname: nickname, difficulty: self.difficulty);
        self.present(gameViewController, animated: true, completion: nil);
    }
    
}

