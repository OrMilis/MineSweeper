//
//  ViewController.swift
//  MineSweeper
//
//  Created by Or Milis on 24/03/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var applyNameBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func nameBtnOnClick(_ sender: Any) {
        guard let nickname = nameTextBox.text else { return; };
        nameLabel.text = nickname;
        
        let storyBoard: UIStoryboard = UIStoryboard(name: UtilManager.StoryBoardName, bundle: nil);
        let gameViewController = storyBoard.instantiateViewController(withIdentifier: UtilManager.GameViewID) as! GameViewController;
        gameViewController.setUpGameView(nickname: nickname, boardSize: 10, bombCount: 20);
        self.present(gameViewController, animated: true, completion: nil);
    }
    
}

