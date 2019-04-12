//
//  ViewController.swift
//  Recently Movies
//
//  Created by jets on 7/22/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import CoreData

class DetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var movie : Movie!
    //var movieList:Movie!
    
    var trailler : [MovieTrailler]=[]
    var review : MovieReview?
    var reviewList : [MovieReview] = []
    
    var responseJson:[[String: Any]]=[]
    var reviewJson:[[String: Any]]=[]
    var managedContext : NSManagedObjectContext!
    let coreData : CoreDataCRUD = CoreDataCRUD()
    
    var isExist : Bool = false;
    
    @IBOutlet weak var changeFavorite: UIBarButtonItem!
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var viewRating: UILabel!
    @IBOutlet weak var viewOverView: UITextView!
    @IBOutlet weak var viewYear: UILabel!
    

    override func viewWillAppear(_ animated: Bool) {
        if(isExist){
            let image = UIImage(named: "Star-Fill")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            changeFavorite.image = image
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        isExist = coreData.isExist(id: movie)
        
        imagePoster.sd_setImage(with: URL(string:movie.image), placeholderImage: UIImage(named: "Splash"))
        viewTitle.text = movie.title
        viewOverView.text = movie.overView
        viewRating.text = "Rating : ".appending(String(describing: movie.rating))
        viewYear.text = "Relearse Year : ".appending(String(describing: movie.releaseYear))
        Constants.MOVIE_ID = String(describing: movie.id!)
        
        DispatchQueue.main.async {
            self.getTraillers(URL_Trailler: Constants.URL_MOVIES)
            self.getReviews(URL_Review: Constants.URL_REVIEWS)
        }

    }
    
    
    @IBAction func btnAddFavorite(_ sender: Any) {
        let alert = UIAlertController(title: "Are you want to complete this action?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:{ action in
            if(self.coreData.isExist(id: self.movie)){
                let image = UIImage(named: "Star")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
                self.changeFavorite.image = image
                self.coreData.deleteData(movieId: self.movie.id!);
            }
            else{
                self.coreData.addTOFavourite(movie: self.movie)
                let image = UIImage(named: "Star-Fill")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
                self.changeFavorite.image = image
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func viewReviews(_ sender: Any) {
        let reviewsView : ReviewViewController = storyboard?.instantiateViewController(withIdentifier: "ReviewsVCID") as! ReviewViewController
       // if reviewList.count == 0 {
            //reviewsView.reviewList = reviewList
        //}
//        else{
            reviewsView.reviewList = movie.movieReviews
//        }
        self.navigationController?.pushViewController(reviewsView, animated: true);
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.movieTraillers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TraillerCell", for: indexPath)
        cell.textLabel?.text = movie.movieTraillers[indexPath.row].name
        //print(movie.movieTraillers[indexPath.row].name ?? 0)
        cell.imageView?.sd_setImage(with: URL(string:""), placeholderImage: UIImage(named: "play-48"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Constants.TRAILLER_KEY = (movie.movieTraillers[indexPath.row].key)!
        
        let YOUTUBE = NSURL(string:Constants.URL_YOUTUBE)
        
        if(UIApplication.shared.canOpenURL(YOUTUBE as! URL)){
            UIApplication.shared.open(YOUTUBE as! URL, options: [:], completionHandler: nil)
        }else{
            print("Cannot open youtube")
        }
    }
    
    func getTraillers(URL_Trailler:String){
        Alamofire.request(URL_Trailler).responseJSON { (response) in
            if let responseValue = response.result.value as! [String: Any]? {
                self.responseJson = responseValue["results"] as! [[String: Any]]
                for item in self.responseJson{
                    let trailler : MovieTrailler = MovieTrailler()
                    trailler.key = item["key"] as? String
                    trailler.name = item["name"] as? String
                    self.movie.movieTraillers.append(trailler)
                    self.trailler.append(trailler)
                    //print("movieTraillers \(self.movie.movieTraillers.count)")
                }
                self.tabelView?.reloadData()
            }
        }
    }
    

    
    func getReviews(URL_Review:String){
        Alamofire.request(URL_Review).responseJSON { (response) in
            if let responseValue = response.result.value as! [String: Any]? {
                self.reviewJson = responseValue["results"] as! [[String: Any]]
                for item in self.reviewJson{
                    let review : MovieReview = MovieReview()
                    review.id = item["id"] as? String
                    review.author = item["author"] as? String
                    review.content = item["content"] as? String
                    print(review.author ?? item["author"] ?? "author")
                    self.movie.movieReviews.append(review)
                    self.reviewList.append(review)
                    print("reviewList \(self.reviewList.count)")
                     //print("review \(review.author)")
                }
            }
        }
    }

}

