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
    
    var movieList:[MovieEntity] = []
    
    var responseJson:[[String: Any]]=[]
    
    var managedContext : NSManagedObjectContext!
    
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var viewRating: UILabel!
    @IBOutlet weak var viewOverView: UITextView!
    @IBOutlet weak var viewYear: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(movie != nil){
            
            imagePoster.sd_setImage(with: URL(string:movie.image), placeholderImage: UIImage(named: "placeholder.png"))
            
            viewTitle.text = movie.title
            
            viewOverView.text = movie.overView
            
            viewRating.text = "Rating : ".appending(String(describing: movie.rating))
            
            viewYear.text = "Relearse Year : ".appending(String(describing: movie.releaseYear))
            
            Constants.MOVIE_ID = String(describing: movie.id!)
            
            DispatchQueue.main.async {
                self.getTraillers(videoID: Constants.MOVIE_ID)
                self.getReviews(videoID: Constants.MOVIE_ID)
            }
            
        }else{
            imagePoster.sd_setImage(with: URL(string:movieList[0].image!), placeholderImage: UIImage(named: "placeholder.png"))
            viewTitle.text = movieList[0].title
            viewOverView.text = movieList[0].overView
            viewRating.text = "Rating : ".appending(String(describing: movieList[0].rating))
            viewYear.text = "Relearse Year : ".appending(String(describing: movieList[0].releaseYear))
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.movie != nil{
            return self.movie.trailer.key.count
        }
        else{
            return 0
        }
    }
    
    
    @IBAction func btnAddFavorite(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are You Want to add to Favorite?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:{ action in
            let coreData:CoreDataCRUD = CoreDataCRUD()
            coreData.addTOFavourite(movie: self.movie)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = movie.trailer.name[indexPath.row]
        cell.imageView?.sd_setImage(with: URL(string:""), placeholderImage: UIImage(named: "play-48"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Constants.TRAILLER_KEY = movie.trailer.key[indexPath.row]
        
        let YOUTUBE = NSURL(string:Constants.URL_YOUTUBE)
        
        if(UIApplication.shared.canOpenURL(YOUTUBE as! URL)){
            UIApplication.shared.open(YOUTUBE as! URL, options: [:], completionHandler: nil)
        }else{
            print("Cannot open youtube")
        }
    }
    
    func getTraillers(videoID:String){
        Alamofire.request(Constants.URL_MOVIES).responseJSON { (response) in
            if let responseValue = response.result.value as! [String: Any]? {
                self.responseJson = responseValue["results"] as! [[String: Any]]
                for item in self.responseJson{
                    
                    self.movie.trailer.key.append(item["key"] as! String)
                    self.movie.trailer.name.append(item["name"] as! String)
                    
                    self.tabelView?.reloadData()
                }
            }
        }
        
        
    }
    
    func getReviews(videoID:String){
        Alamofire.request(Constants.URL_REVIEWS).responseJSON { (response) in
            if let responseValue = response.result.value as! [String: Any]? {
                self.responseJson = responseValue["results"] as! [[String: Any]]
                for item in self.responseJson{
                    
                    self.movie.review.id.append(item["id"] as! String)
                    self.movie.review.author.append(item["author"] as! String)
                    self.movie.review.content.append(item["content"] as! String)
                    
                    self.tabelView?.reloadData()
                }
            }
        }
    }
}

