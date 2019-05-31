//
//  ViewController.swift
//  MineSweeper
//
//  Created by Or Milis on 24/03/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainMenuViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var difficultyBtn: UIButton!
    @IBOutlet weak var leaderboardBtn: UIButton!
    
    var difficulty: UtilManager.Difficulty = UtilManager.Difficulty.NORMAL;
    
    let locationManager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization();
        difficultyBtn.titleLabel?.adjustsFontSizeToFitWidth = true;
        leaderboardBtn.titleLabel?.adjustsFontSizeToFitWidth = true;
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0];
        
        print(location.coordinate.latitude, " ", location.coordinate.longitude);
    }
    
    @IBAction func changeDifficulty(_ sender: Any) {
        difficulty = difficulty.GetNextDifficulty();
        difficultyBtn.setTitle(difficulty.rawValue, for: .normal);
    }
    
    @IBAction func OnPlayBtnClick(_ sender: Any) {
        guard let nickname = nameTextBox.text else { return; };
        
        let storyBoard: UIStoryboard = UIStoryboard(name: UtilManager.StoryBoardName, bundle: nil);
        
        guard let gameNavigationVC = storyBoard.instantiateViewController(withIdentifier: "GameNC") as? UINavigationController else { return; };
        
        guard let gameVC = gameNavigationVC.topViewController as? GameViewController else { return; };
        gameVC.setUpGameView(nickname: nickname, difficulty: self.difficulty);
        
        self.present(gameNavigationVC, animated: true, completion: nil);
        
        
    }
    
    @IBAction func onLeaderboardBtnClick(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: UtilManager.StoryBoardName, bundle: nil);
        guard let endViewController = storyBoard.instantiateViewController(withIdentifier: UtilManager.LeaderboardViewID) as? LeaderboardViewController else { return; };
        
        self.navigationController?.pushViewController(endViewController, animated: true);
    }
}

