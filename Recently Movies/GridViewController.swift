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

enum dataType {
    case discover
    case popular
    case topRate
}

class GridViewController: UICollectionViewController {
    
    @IBOutlet weak var changeButton: UIBarButtonItem!
    var flag = true;
    var page = 1;
    

    //var movieList = [Movie]()
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
        
        if Connectivity.isConnectedToInternet() {
            self.switchFetch(order: .discover)
        }else{
            alarm()
            self.switchFetch(order: .discover)
        }
    }
    
    
    func switchFetch(order:dataType) {
        switch order {
            
            case .discover:
                movieList.removeAll()
                fetchJson(typeURL: Constants.URL_DISCOVER+Constants.PAGE_NUMBER)
                print(Constants.URL_DISCOVER)
            
            case .popular:
                movieList.removeAll()
                fetchJson(typeURL: Constants.URL_POPULAR+Constants.PAGE_NUMBER)
            
            case .topRate:
                movieList.removeAll()
                fetchJson(typeURL: Constants.URL_TOP_RATED+Constants.PAGE_NUMBER)
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
        cell.viewImageGrid.sd_setImage(with: URL(string:movieList[indexPath.item].image), placeholderImage: UIImage(named: "Splash"))
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsView : DetailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsVCID") as! DetailsViewController
         print(movieList[indexPath.item].id ?? 0)
        detailsView.movie = movieList[indexPath.item];
        self.navigationController?.pushViewController(detailsView, animated: true);
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //If we reach the end of the collection.
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
        {
            //Add ten more rows and reload the table content.
            page += 1;
            Constants.PAGE_NUMBER = String(page)
            //if Connectivity.isConnectedToInternet(){
                fetchJson(typeURL:Constants.URL_DISCOVER+Constants.PAGE_NUMBER)
            //}else{
             //   alarm()
            //}
        }
    }
    
    @IBAction func btnChangeMovie(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "Sort Movies By", message: nil, preferredStyle: .actionSheet)
        actionSheet.view.tintColor = UIColor.orange
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        let sortByRating = UIAlertAction(title: "Top Rated", style: .default) { action in
            self.switchFetch(order: .topRate)
        }
        
        let sortByPopularity = UIAlertAction(title: "Popular", style: .default) { action in
            self.switchFetch(order: .popular)
        }
        
        actionSheet.addAction(sortByRating)
        actionSheet.addAction(sortByPopularity)
        
        present(actionSheet, animated: true, completion: nil)
        if Connectivity.isConnectedToInternet() == false {
            self.alarm()
        }
    }

    
    func fetchJson(typeURL:String){
        DispatchQueue.main.async {
            Alamofire.request(typeURL).responseJSON { (response) in
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
                        self.movieList.append(movie)
                       
                    }
                     self.collectionView?.reloadData()
                }
            }
        }
    }
    
    
    func alarm(){
//        if Connectivity.isConnectedToInternet() == false {
            let actionSheet = UIAlertController(title: "Please Check Your Internet Connection", message: "You are not connected", preferredStyle: .actionSheet)
            actionSheet.view.tintColor = UIColor.orange
            actionSheet.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            present(actionSheet, animated: true, completion: nil)
        }
//    }

}
