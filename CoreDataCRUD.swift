//
//  CoreDataCRUD.swift
//  Recently Movies
//
//  Created by jets on 7/29/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataCRUD {
    
    var managedContext : NSManagedObjectContext?
    let myDelegate = UIApplication.shared.delegate as! AppDelegate

    
    func addTOFavourite(movie:Movie)->Void{
        
        managedContext = myDelegate.persistentContainer.viewContext
        
        let movieEntity = NSEntityDescription.insertNewObject(forEntityName: "MovieEntity", into: managedContext!)
        
        movieEntity.setValue(movie.title, forKey: "title")
        
        movieEntity.setValue(movie.id, forKey: "id")
        
        movieEntity.setValue(movie.image, forKey: "image")
        
        movieEntity.setValue(movie.overView, forKey: "overView")
        
        movieEntity.setValue(movie.releaseYear, forKey: "releaseYear")
        
        movieEntity.setValue(movie.rating, forKey: "rating")
        
        movieEntity.setValue(movie.movieReviews, forKey: "movieReviews")
        
        movieEntity.setValue(movie.movieTraillers, forKey: "movieTraillers")
        
        
        do{
            try managedContext?.save()
            print ("data saved")
        }
        catch let error as NSError{
            print(error.userInfo);
        }
    }

    
    func getFavouriteMovies() ->Array<Movie>
    {
        
        managedContext = myDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
//        let sortDescriptor = NSSortDescriptor(key: "rating", ascending: false)
//        fetchRequest.sortDescriptors = [sortDescriptor]
        //var movies:Array<NSManagedObject>!
        var movieList:[Movie] = []
        do{
            
            let movies = try managedContext?.fetch(fetchRequest)
            //var movie : Movie!
            for data in movies!{
                let movie = Movie()
                movie.id =  data.value(forKey: "id") as? Int
                movie.image = (data.value(forKey: "image") as? String)!
                movie.title = (data.value(forKey: "title")as? String)!
                movie.overView = (data.value(forKey: "overView") as? String)!
                movie.rating = (data.value(forKey: "rating") as? Float)!
                movie.releaseYear = data.value(forKey: "releaseYear") as! String
                movie.movieReviews = (data.value(forKey: "movieReviews") as? [MovieReview])!
                movie.movieTraillers = (data.value(forKey: "movieTraillers") as? [MovieTrailler])!
                movieList.append(movie)
            }
            return movieList
        }
        catch let error as NSError{
            print(error.userInfo);
            return movieList
        }
    }

    
    
    func deleteData(movieId:Int){

        managedContext = myDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        
        fetchRequest.predicate = NSPredicate(format: "id = %d", movieId)
        do
        {
            let test = try managedContext?.fetch(fetchRequest)
            for object in test! {
            //let objectToDelete = test as! NSManagedObject
            managedContext?.delete(object as! NSManagedObject)
            }
            do{
                try managedContext?.save()
                print("Deleted")
            }
            catch let error as NSError
            {
                print(error)
                print("Could not save \(error), \(error.userInfo)")
            }
            
        }
        catch let error as NSError
        {
            print(error)
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func isExist(id:Movie)->Bool
    {
        let myDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = myDelegate.persistentContainer.viewContext
        var movies:Array<NSManagedObject>!
            let fechRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
            print("id =\(id.id!)")
            fechRequest.predicate = NSPredicate(format: "id = %d", id.id!)
            
            do{
                movies = try managedContext.fetch(fechRequest)
                //return movies.count > 0
            }catch let error as NSError{
                print("error code : \(error.code)")
            }
        
        return movies.count > 0
    }
    
    
}
