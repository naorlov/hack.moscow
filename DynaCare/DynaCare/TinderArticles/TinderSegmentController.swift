//
//  TinderSegmentController.swift
//  DynaCare
//
//  Created by Petr Kuznetsov on 27/10/2018.
//  Copyright © 2018 Petr Kuznetsov. All rights reserved.
//

import Foundation

import UIKit
import ScrollingStackViewController
import ScalingCarousel

class TinderSegmentController: UIViewController {
    
    // MARK: - Properties (Private)
    
    @IBOutlet weak var scalingCarousel: ScalingCarouselView!
    @IBOutlet weak var hideMeButton: UIButton!
    
    var count: Int? {
        didSet {
            configure()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    @IBAction func hideShowButtonTapped(_ sender: Any) {
        
        let shouldHide = !scalingCarousel.isHidden
        
        ScrollingStackViewController.defaultAnimate({
            
            self.scalingCarousel.isHidden = shouldHide
            self.hideMeButton.setTitle(shouldHide ? "Show label" : "Hide label", for: .normal)
            
        }, completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if scalingCarousel != nil {
            scalingCarousel.deviceRotated()
        }
    }
    
    private func configure() {
        
        guard isViewLoaded else { return }
        
//        if let count = count {
//            countLabel.text = "View Controller \(count)"
//        } else {
//            countLabel.text = nil
//        }
        
        scalingCarousel.dataSource = self
        scalingCarousel.delegate = self
        scalingCarousel.translatesAutoresizingMaskIntoConstraints = false
        scalingCarousel.backgroundColor = .white

        scalingCarousel.register(TinderCell.self, forCellWithReuseIdentifier: "cell")

        view.addSubview(scalingCarousel)

        // Constraints
        scalingCarousel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        scalingCarousel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        scalingCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scalingCarousel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
    }
}

extension TinderSegmentController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let scalingCell = cell as? ScalingCarouselCell {
            scalingCell.mainView.backgroundColor = .blue
        }
        DispatchQueue.main.async {
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        }
        
        return cell
    }
}

extension TinderSegmentController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //scalingCarousel.didScroll()
    }
}
