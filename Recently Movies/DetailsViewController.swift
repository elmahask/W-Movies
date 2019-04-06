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

private let poster_URL = "https://image.tmdb.org/t/p/w500"
private let API_KEY = "2f118a45da8d4c15298e63cbc09bce5a"
private let API_URL = "https://api.themoviedb.org/3/movie/299537/videos?api_key="+API_KEY;
private let REVIEWS_URL = "https://api.themoviedb.org/3/movie/299537/reviews?api_key="+API_KEY
//https://api.themoviedb.org/3/movie/299537/reviews?api_key=2f118a45da8d4c15298e63cbc09bce5a


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
    @IBAction func btnAddFavorite(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are You Want to add to Favorite?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:{ action in
            let coreData:CoreDataCRUD = CoreDataCRUD()
            //if()
            coreData.addTOFavourite(movie: self.movie)
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            if(movie != nil){
                imagePoster.sd_setImage(with: URL(string:movie.image), placeholderImage: UIImage(named: "placeholder.png"))
                viewTitle.text = movie.title
                viewOverView.text = movie.overView
                viewRating.text = "Rating : ".appending(String(describing: movie.rating))
                viewYear.text = "Relearse Year : ".appending(String(describing: movie.releaseYear))
                let videoID = String(describing: movie.id!)
                print("Ditails \(movie.id)")
               // getReviews(videoID: videoID)
                DispatchQueue.main.async {
                    self.getTraillers(videoID: videoID)
//                    self.getReviews(videoID: videoID)
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
            print("Count : \(self.movie.trailer.key.count)")
            return self.movie.trailer.key.count
        }
        else{
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = movie.trailer.name[indexPath.row]
        print("Name : \(self.movie.trailer.name[indexPath.row])")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let youtubeURL = NSURL(string:"https://www.youtube.com/watch?v=\(movie.trailer.key[indexPath.row])")
        if(UIApplication.shared.canOpenURL(youtubeURL as! URL)){
            UIApplication.shared.openURL(youtubeURL as! URL)
        }else{
            print("Cannot open youtube")
        }
    }
    
    func getTraillers(videoID:String){
        
            Alamofire.request("https://api.themoviedb.org/3/movie/"+videoID+"/videos?api_key=2f118a45da8d4c15298e63cbc09bce5a").responseJSON { (response) in
                if let responseValue = response.result.value as! [String: Any]? {
                    self.responseJson = responseValue["results"] as! [[String: Any]]
                    for item in self.responseJson{
                        print(item["key"] as! String)
                        
                        self.movie.trailer.key.append(item["key"] as! String)
                        self.movie.trailer.name.append(item["name"] as! String)
                        //self.movie.trailer.append([item["name"] as! String])
                        //self.movieList.append(item["key"] as! String)
                        self.tabelView?.reloadData()
                    }
                }
            }
            
        
    }
    
    func getReviews(videoID:String){
        
            Alamofire.request("https://api.themoviedb.org/3/movie/"+videoID+"/reviews?api_key=2f118a45da8d4c15298e63cbc09bce5a").responseJSON { (response) in
                if let responseValue = response.result.value as! [String: Any]? {
                    self.responseJson = responseValue["results"] as! [[String: Any]]
                    for item in self.responseJson{
                        print(item["id"] as! String)
                        self.movie.review.id.append(item["id"] as! String)
                        self.movie.review.author.append(item["author"] as! String)
                        self.movie.review.content.append(item["content"] as! String)
                        self.tabelView?.reloadData()
                    }
                }
            }
            
        
    }
    
}

