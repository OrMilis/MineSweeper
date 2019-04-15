//
//  EndGameViewController.swift
//  MineSweeper
//
//  Created by ormilis on 15/04/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {

    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var gameStatus: UILabel!
    
    var nicknameText: String = "";
    var gameStatusText: String = "";
    var difficulty: UtilManager.Difficulty = UtilManager.Difficulty.NORMAL;
    
    public func setupView(nickname: String, gameStatus: String, difficulty: UtilManager.Difficulty) {
        self.nicknameText = nickname;
        self.gameStatusText = gameStatus;
        self.difficulty = difficulty;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nickname.text = nicknameText;
        self.gameStatus.text = gameStatusText;
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func OnAgainBtnClick(_ sender: Any) {
        guard let gameVc = self.navigationController?.viewControllers[0] as? GameViewController else { return; };
        gameVc.startGame();
        self.navigationController?.popViewController(animated: true);
    }
    
    @IBAction func OnMenuBtnClick(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
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
