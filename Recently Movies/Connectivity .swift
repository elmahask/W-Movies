//
//  Connectivity .swift
//  Recently Movies
//
//  Created by jets on 8/1/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class Connectivity{
    
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
  }



/*
 if Connectivity.isConnectedToInternet() {
 print("Yes! internet is available.")
 // do some tasks..
 }
 
 */


//or
/*
 
 import Foundation
 import Alamofire
 class Connectivity {
 class var isConnectedToInternet:Bool {
 return NetworkReachabilityManager()!.isReachable
 }
 }
 
 */

/*
 
 if Connectivity.isConnectedToInternet {
 print("Yes! internet is available.")
 // do some tasks..
 }
 
 */
