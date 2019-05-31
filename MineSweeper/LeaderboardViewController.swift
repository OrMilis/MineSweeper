//
//  LeaderboardViewController.swift
//  MineSweeper
//
//  Created by ormilis on 27/05/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class LeaderboardViewController: UIViewController {

    var ref: DatabaseReference! = Database.database().reference();
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    var listData = [LeaderboardCellData]();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*listData.append(LeaderboardCellData(name: "Fish1", score: 1280, lat: 1.2366, lng: 2.558));
        listData.append(LeaderboardCellData(name: "Fish2", score: 231, lat: 3.256, lng: 25.366));
        listData.append(LeaderboardCellData(name: "Fish3", score: 5223, lat: 13.2236, lng: 2.2441));
        
        */
        
        self.ref.child("users").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            for child in snapshot.children {
                guard let temp = child as? DataSnapshot else { continue };
                guard let tempDict = temp.value as? NSDictionary else { continue };
                guard let score = tempDict.value(forKey: "score") as? Int else { continue };
                guard let lat = tempDict.value(forKey: "lat") as? Double else { continue };
                guard let lng = tempDict.value(forKey: "lng") as? Double else { continue };
                guard let difficulty = tempDict.value(forKey: "difficulty") as? String else { continue };
                
                let cellData = LeaderboardCellData(name: temp.key, score: score, lat: lat, lng: lng, difficulty: difficulty);
                self.listData.append(cellData)
                self.mapView.addAnnotation(cellData);
                print(tempDict);
            }
            self.tableView.reloadData();
            self.centerMapOnLocation(location: CLLocation(latitude: self.listData[0].GetLat(), longitude: self.listData[0].GetLng()));
        })
        
        // Do any additional setup after loading the view.
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000000;
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius);
        self.mapView.setRegion(coordinateRegion, animated: true)
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
        cell.lat.text = String(format: "%.3f", cellData.GetLat());
        cell.lng.text = String(format: "%.3f", cellData.GetLng());
        cell.difficulty.text = cellData.GetDifficulty();
        
        return cell;
    }
    
}
