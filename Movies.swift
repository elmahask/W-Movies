//
//  Movies.swift
//  Recently Movies
//
//  Created by jets on 7/22/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

let APIKey = "2f118a45da8d4c15298e63cbc09bce5a"
let APIURLPrefix = "https://api.themoviedb.org/3"
let imageURLPrefix = "https://image.tmdb.org/t/p"

import Foundation


class Movie : NSObject {
    
    var id : Int?
    var title : String = ""
    var image : String = ""
    var overView : String = ""
    var rating : Float = 0
    var popularity : Float = 0
    var releaseYear : String = ""
    
    struct Trailler {
        var key : Array<String> = []
        var name : Array<String> = []
    }
    struct Review{
        var author : String = ""
        var content : String = ""
        var id : String = ""
    }
    
    var review = Review()
    var trailer = Trailler()
    
}
