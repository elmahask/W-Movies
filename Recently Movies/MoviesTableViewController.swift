//
//  MoviesTableViewController.swift
//  Recently Movies
//
//  Created by jets on 7/22/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CustomMoviesViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomMoviesViewCell
        
        
        //cell.viewTitle.text = String(describing: movieList[indexPath.row].title!)
        //cell.viewRating.text = String(describing: movieList[indexPath.row].rating!)
        //let img = UIImage(named:movies[indexPath.row].image!)
        //cell.imageView?.image = img;
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsView : DetailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsViewController
        //secondView.movie = movieList[indexPath.row];
        self.navigationController?.pushViewController(detailsView, animated: true);
    }

    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        //DetailsViewController detailsView =
        // Pass the selected object to the new view controller.
    }
    */

}
