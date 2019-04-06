//
//  SplashViewController.swift
//  Recently Movies
//
//  Created by jets on 7/23/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        perform(#selector(mainScrren), with: self, afterDelay: 1)
    }
    
    func mainScrren(){
        performSegue(withIdentifier: "mainScreen", sender: self)
    }

}
