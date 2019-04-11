//
//  MovieTrailler.swift
//  Recently Movies
//
//  Created by jets on 8/1/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import Foundation

public class MovieTrailler : NSObject, NSCoding{
    
    var key : String?
    var name : String?
    
    public func encode(with aCoder: NSCoder){
        aCoder.encode(key, forKey: "key")
        aCoder.encode(name, forKey: "name")
    }
    override init(){}
    
    public required init?(coder aDecoder: NSCoder){
        key = aDecoder.decodeObject(forKey: "key") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
    }
    
}
