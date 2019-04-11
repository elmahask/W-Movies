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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(reviewList.count)
        return reviewList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ReviewTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewTableViewCell
        cell.viewName.text = reviewList[indexPath.row].author;
        cell.viewReview.text = reviewList[indexPath.row].content;
        return cell
    }
    
}
