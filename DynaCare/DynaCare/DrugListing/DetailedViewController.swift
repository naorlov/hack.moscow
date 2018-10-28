//
//  DetailedViewController.swift
//  DynaCare
//
//  Created by Petr Kuznetsov on 28/10/2018.
//  Copyright © 2018 Petr Kuznetsov. All rights reserved.
//

import Foundation
import Kingfisher

import UIKit

class DetailViewController: UIViewController {
    let MainURL = URL(string: "http://35.204.85.94:8888")!;
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var candyImageView: UIImageView!
    
    var detailCandy: DrugModel? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let detailCandy = detailCandy {
            if let detailDescriptionLabel = detailDescriptionLabel, let candyImageView = candyImageView {
                detailDescriptionLabel.text = detailCandy.name
                print(detailCandy.pictureURL);
                let url = (MainURL.appendingPathComponent(detailCandy.pictureURL!))
                
                candyImageView.kf.setImage(with: url);
//                candyImageView.image .kf.setImage(with: url);
                title = detailCandy.activeIngridient
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

