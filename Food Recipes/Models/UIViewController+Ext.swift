//
//  UIViewController+Ext.swift
//  Food Recipes
//
//  Created by Alex Paul on 5/25/23.
//

import Foundation
import UIKit
extension UIViewController{
    
    func setUpNavigationBarApperance(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
}
