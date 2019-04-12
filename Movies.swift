//
//  Movies.swift
//  Recently Movies
//
//  Created by jets on 7/22/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import Foundation


class Movie : NSObject {
    
    var id : Int?
    var title : String = ""
    var image : String = ""
    var overView : String = ""
    var rating : Float = 0
    var popularity : Float = 0
    var releaseYear : String = ""
    var movieReviews : [MovieReview]=[]
    var movieTraillers : [MovieTrailler]=[]    
}
