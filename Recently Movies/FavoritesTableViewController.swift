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
    var movirList : Array<Movie> = []
    //var arr :[MovieEntity] = []
    var arr : Movie = Movie()
    //var moviesObject = Movie!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let coredata:CoreDataCRUD = CoreDataCRUD()
        movirList = coredata.getFavouriteMovies()
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movirList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CustomMoviesViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomMoviesViewCell
        let x = movirList[indexPath.row]

        cell.viewTitle.text = x.title
        cell.viewRating.text = String(x.rating)
        cell.viewReleaseYear.text = x.releaseYear
        cell.viewImage.sd_setImage(with: URL(string:x.image) , placeholderImage: UIImage(named: "Splash"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsView : DetailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsVCID") as! DetailsViewController
        detailsView.movie = movirList[indexPath.row]
        self.navigationController?.pushViewController(detailsView, animated: true);
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let coredata:CoreDataCRUD = CoreDataCRUD()
            coredata.deleteData(movieId: movirList[indexPath.row].id!)
            self.movirList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }else{
            print("Cannot Delete")
        }
    }
}

//        let xx = x.movieReviews
//        let xy = x.movieTraillers
//
//        for (xz,zz) in zip(xx,xy){
//            let movieReviews = MovieReview()
//            let movieTraillers = MovieTrailler()
//
//            print("Author \(xz.author)")
//            print("Author \(zz.name)")
//            print("data\(arr.image)")
//            movieReviews.author = xz.author;
//            movieReviews.content = xz.content;
//            movieReviews.id = xz.id;
//            arr.movieReviews.append(movieReviews)
//
//            movieTraillers.key = zz.key;
//            movieTraillers.name = zz.name;
//            arr.movieTraillers.append(movieTraillers)
//
//            print(arr.movieReviews.count)
//            print(arr.movieTraillers.count)
//        }
//        arr.id = x.id;
//        arr.title = x.title;
//        arr.image = x.image;
//        arr.rating = x.rating;
//        arr.overView = x.overView;
//        arr.releaseYear = x.releaseYear;

