//
//  CodeViewController.swift
//  DynaCare
//
//  Created by Petr Kuznetsov on 27/10/2018.
//  Copyright © 2018 Petr Kuznetsov. All rights reserved.
//

import UIKit
import ScalingCarousel

class TinderCell: ScalingCarouselCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mainView = UIView(frame: contentView.bounds)
        contentView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                mainView.widthAnchor.constraint(equalToConstant: 30),
                mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
                mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
