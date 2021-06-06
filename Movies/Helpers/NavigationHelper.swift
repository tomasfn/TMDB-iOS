//
//  NavigationHelper.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import Foundation
import UIKit

class NavigationHelper {
    
    static let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)

    class func homeViewController() -> HomeViewController {
        let homeVc = mainStoryboard.instantiateViewController(withIdentifier: HomeViewController.nameOfClass) as! HomeViewController
        return homeVc
    }
    
    class func detailViewController() -> DetailViewController {
        let detailVc = mainStoryboard.instantiateViewController(withIdentifier: DetailViewController.nameOfClass) as! DetailViewController
        return detailVc
    }
}
