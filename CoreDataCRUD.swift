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
        
        do{
            try managedContext?.save()
            print ("data saved")
        }
        catch let error as NSError{
            print(error.userInfo);
        }
    }

    
    func getFavouriteMovies() ->Array<NSManagedObject>
    {
        
        managedContext = myDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        let sortDescriptor = NSSortDescriptor(key: "rating", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        var movies:Array<NSManagedObject>!
        do{
            movies = try managedContext?.fetch(fetchRequest)
            return movies
        }
        catch let error as NSError{
            print(error.userInfo);
            return movies
        }
    }

    
    
    func deleteData(movie:MovieEntity){

        managedContext = myDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(movie.id)")
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
}
