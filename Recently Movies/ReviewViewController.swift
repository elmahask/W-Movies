//
//  ReviewViewController.swift
//  Recently Movies
//
//  Created by jets on 8/2/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import UIKit

class ReviewViewController: UITableViewController {

    var reviewList :[MovieReview] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //print(reviewList.count)
        if reviewList.count > 0 {
            return reviewList.count
        }else{
            return 1
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ReviewTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewTableViewCell
        if reviewList.count > 0 {
            cell.viewName.text = reviewList[indexPath.row].author;
            cell.viewReview.text = reviewList[indexPath.row].content;
        }
        else{
            cell.viewName.text = "Author";
            cell.viewReview.text = "No Review Available Now";
        }
        return cell
    }
    
}
