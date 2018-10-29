//
//  CustomUITabBarController.swift
//  DynaCare
//
//  Created by Petr Kuznetsov on 29/10/2018.
//  Copyright © 2018 Petr Kuznetsov. All rights reserved.
//

import UIKit

class CustomUITabBarController: UITabBarController {
    
    let customButtonImage = Asset.iconOne.image;
    let customButtonImage1 = Asset.iconTwo.image
    
    override func viewWillAppear(_ animated: Bool) {
        let customButton = UIButton(type: .custom);
        customButton.frame = CGRect(x: 0, y: 0, width: customButtonImage.size.width, height: customButtonImage.size.height);
        customButton.setBackgroundImage(self.customButtonImage, for: .normal);
        customButton.setBackgroundImage(self.customButtonImage1, for: .highlighted);
        
        print("We are doing something here!");
        
        let heightDifference = customButton.frame.size.height - self.tabBar.frame.size.height;
        
        if heightDifference < 0 {
            customButton.center = self.tabBar.center;
        } else {
            var barCenter = self.tabBar.center;
            barCenter.y -= heightDifference/2;
            customButton.center = barCenter;
        }
        
        self.view.addSubview(customButton);
    }
}
