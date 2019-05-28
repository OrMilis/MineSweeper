//
//  LeaderboardViewController.swift
//  MineSweeper
//
//  Created by ormilis on 27/05/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {

    var listData = [LeaderboardCellData]();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listData.append(LeaderboardCellData(name: "Fish", score: 1280, lat: 1.2366, lng: 2.558));
        
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

extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
