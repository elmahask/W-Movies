//
//  FavoritesTableViewController.swift
//  Recently Movies
//
//  Created by jets on 7/22/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import UIKit
import CoreData

class FavoritesTableViewController: UITableViewController {

    var managedContext : NSManagedObjectContext?
    var movieList:Array<NSManagedObject>!
     var arr :[MovieEntity] = []
    //var moviesObject = Movie!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let coredata:CoreDataCRUD = CoreDataCRUD()
        movieList = coredata.getFavouriteMovies()
        arr = movieList as! [MovieEntity]
        
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return self.movieList.count
        return self.arr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CustomMoviesViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomMoviesViewCell
        let x = arr[indexPath.row]
        
        //cell.viewTitle?.text = arr[indexPath.row].value(forKey: "title") as? String
        cell.viewTitle.text = x.title
        cell.viewRating.text = String(x.rating)
        
        print(String(x.rating))
    
        //print(arr[indexPath.row].value(forKey: "title") as? String!)
        
        //cell.viewRating?.text! = String(describing: arr[indexPath.row].value(forKey: "rating"))
        
        //cell.viewImage?.sd_setImage(with: URL(string:arr[indexPath.row].value(forKey: "image")as! String) , placeholderImage: UIImage(named: "placeholder.png"))
        cell.viewImage.sd_setImage(with: URL(string:x.image!) , placeholderImage: UIImage(named: "placeholder.png"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsView : DetailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsViewController
        detailsView.movieList = [arr[indexPath.row]];
        self.navigationController?.pushViewController(detailsView, animated: true);
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        let coredata:CoreDataCRUD = CoreDataCRUD()
            coredata.deleteData(movie: arr[indexPath.row])
            self.arr.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
     }
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegue" ,
            let nextScene = segue.destination as? VehicleDetailsTableViewController ,
            let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedVehicle = vehicles[indexPath.row]
            nextScene.currentVehicle = selectedVehicle
        }
     }
     
     
    */

}
