//
//  TinderViewController.swift
//  DynaCare
//
//  Created by Petr Kuznetsov on 27/10/2018.
//  Copyright © 2018 Petr Kuznetsov. All rights reserved.
//

import Foundation

import UIKit
import ScrollingStackViewController

class TinderViewController: ScrollingStackViewController {
    
    @IBOutlet weak var hideShowButton: UIBarButtonItem!
    
    var segments = [TinderSegmentController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        for x in 1...40 {
            
            let viewController = storyboard.instantiateViewController(withIdentifier: "TinderSegmentController") as! TinderSegmentController;
            
            viewController.count = x
            viewController.view.backgroundColor = UIColor.color(forRow: x)
            
//            NSLayoutConstraint.activate(
//                [
//                    viewController.view.heightAnchor.constraint(equalToConstant: 300),
//                ]
//            )
//            .heightAnchor.constraint(equalToConstant: 100).isActive = true
            
            segments += [viewController]
            
            add(viewController: viewController)
        }
        
        // separators
        spacingColor = UIColor.lightGray
        stackView.spacing = 0.5
        
        borderWidth = 0
    }
    
    var isHiding = false
    
    @IBAction func hideShowTapped(_ sender: Any) {
        
        isHiding = !isHiding
        
        if isHiding {
            
            hideShowButton.title = "Show 5"
            hide(viewController: self.segments[4])
        } else {
            
            hideShowButton.title = "Hide 5"
            show(viewController: self.segments[4])
        }
    }
    
    @IBAction func scrollTo8Tapped(_ sender: Any) {
        
        scrollTo(viewController: segments[7])
    }
}


extension UIColor {
    
    static let possibleColors: [UIColor] =  [
        UIColor(red: 246/255, green: 119/255, blue: 118/255, alpha: 1.0),
        UIColor(red: 250/255, green: 184/255, blue: 146/255, alpha: 1.0),
        UIColor(red: 255/255, green: 249/255, blue: 174/255, alpha: 1.0),
        UIColor(red: 184/255, green: 217/255, blue: 200/255, alpha: 1.0),
        UIColor(red: 114/255, green: 185/255, blue: 226/255, alpha: 1.0),
        ]
    
    static func color(forRow row: Int) -> UIColor {
        let index = (row - 1) % possibleColors.count
        return possibleColors[index]
    }
}
