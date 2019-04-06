//
//  GridViewController.swift
//  Recently Movies
//
//  Created by jets on 7/23/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

private let reuseIdentifier = "Cell"
private let poster_URL = "https://image.tmdb.org/t/p/w500"
private let API_KEY = "2f118a45da8d4c15298e63cbc09bce5a"
private let API_URL = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key="+API_KEY;

class GridViewController: UICollectionViewController {
    
    var flag = true;
    @IBAction func btnChangeMovie(_ sender: UIBarButtonItem) {
        if(flag){
            movieList = movieList.sorted(by: { (Float($0.popularity) ) > (Float($1.popularity) )
            })
            for obj in movieList {
                print("Sorted popularity: \(obj.popularity)")
            }
            self.collectionView?.reloadData()
            flag = false
            print(flag)
        }else{
            movieList = movieList.sorted(by: { (Float($0.rating) ) > (Float($1.rating) )
            })
            //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "remove", style: .plain, target: self, action:nil)
            for objs in movieList {
                print("Sorted popularity: \(objs.rating)")
            }
            self.collectionView?.reloadData()
            flag = true
            print(flag)
        }
    }

    //var movies = [Movie]()
    var movieList:Array<Movie> = []
    var responseJson:[[String: Any]]=[]
    struct Storyboard {
        static let photoCell = "Grid"
        static let leftAndRightPaddings: CGFloat = 2.0
        static let numberOfItemPerRow: CGFloat = 3.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionViewWidth = collectionView?.frame.width;
        let itemWidth = (collectionViewWidth! - Storyboard.leftAndRightPaddings)/Storyboard.numberOfItemPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)

        
        DispatchQueue.main.async {
            Alamofire.request(Constants.URL_DISCOVER).responseJSON { (response) in
                if let responseValue = response.result.value as! [String: Any]? {
                    self.responseJson = responseValue["results"] as! [[String: Any]]
                    for item in self.responseJson{
                        let movie : Movie! = Movie()
                        movie.id = item["id"] as? Int
                        movie.title = (item["title"] as! String)
                        movie.overView = item["overview"] as! String
                        movie.rating = (item["vote_average"] as! Float)
                        movie.popularity = item["popularity"] as! Float
                        movie.releaseYear = item["release_date"] as! String
                        movie.image = Constants.URL_MAIN_IMAGE + String(describing: item["poster_path"]!)
                        print(movie.image)
                        self.movieList.append(movie)
                    
                        self.collectionView?.reloadData()
                    }
                }
            }
            
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.movieList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> CustomCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.photoCell, for: indexPath) as! CustomCollectionViewCell
        cell.viewImageGrid.sd_setImage(with: URL(string:movieList[indexPath.item].image), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsView : DetailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsViewController
        detailsView.movie = movieList[indexPath.item];
        self.navigationController?.pushViewController(detailsView, animated: true);
    }
}
