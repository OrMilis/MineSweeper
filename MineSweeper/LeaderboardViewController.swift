//
//  LeaderboardViewController.swift
//  MineSweeper
//
//  Created by ormilis on 27/05/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit
import FirebaseDatabase

class LeaderboardViewController: UIViewController {

    var ref: DatabaseReference! = Database.database().reference();
    
    var listData = [LeaderboardCellData]();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*listData.append(LeaderboardCellData(name: "Fish1", score: 1280, lat: 1.2366, lng: 2.558));
        listData.append(LeaderboardCellData(name: "Fish2", score: 231, lat: 3.256, lng: 25.366));
        listData.append(LeaderboardCellData(name: "Fish3", score: 5223, lat: 13.2236, lng: 2.2441));*/
        
        //self.ref.child("users").child(listData[0].GetName()).setValue(listData[0].GetDict());
        
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: UtilManager.LeaderboardCellID, for: indexPath) as! LeaderboardCell;
        let cellData = listData[indexPath.row];
        cell.name.text = cellData.GetName();
        cell.score.text = "\(cellData.GetScore())";
        cell.lat.text = "\(cellData.GetLat())";
        cell.lng.text = "\(cellData.GetLng())";
        
        return cell;
    }
    
}
