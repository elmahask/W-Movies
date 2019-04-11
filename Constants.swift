//
//  Constants.swift
//  Recently Movies
//
//  Created by jets on 7/30/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import Foundation
class Constants{
    
    static let API_KEY = "2f118a45da8d4c15298e63cbc09bce5a"
    
    static let MAIM_URL = "https://api.themoviedb.org/3"
    
    static var QUERY_STRING = ""
    
    static var MOVIE_ID = ""
    
    static var TRAILLER_KEY = ""
    
    static var PAGE_NUMBER = "";
  
    static let URL_SEARCH =
        MAIM_URL+"/search/movie?api_key=\(API_KEY)&query=\(QUERY_STRING)&page=1"
    
    static let URL_DISCOVER =
        MAIM_URL + "/discover/movie?sort_by=popularity.desc&api_key=" + API_KEY + "&page="+PAGE_NUMBER

    static let URL_MOVIES =
        MAIM_URL + "/movie/\(MOVIE_ID)/videos?api_key=" + API_KEY
    
    static let URL_REVIEWS =
    
        MAIM_URL + "/movie/\(MOVIE_ID)/reviews?api_key=" + API_KEY
    
    static let URL_POPULAR =
        MAIM_URL + "/movie/popular?api_key=" + API_KEY + "&page="+PAGE_NUMBER
    
    static let URL_TOP_RATED =
        MAIM_URL + "/movie/top_rated?api_key=" + API_KEY + "&page=\(PAGE_NUMBER)"
    
    static let URL_MAIN_IMAGE =
        "https://image.tmdb.org/t/p/w500"
    
    static let URL_YOUTUBE =
        "https://www.youtube.com/watch?v=" + TRAILLER_KEY

}
