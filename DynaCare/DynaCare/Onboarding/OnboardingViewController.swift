//
//  OnboardingViewController.swift
//  DynaCare
//
//  Created by Petr Kuznetsov on 27/10/2018.
//  Copyright © 2018 Petr Kuznetsov. All rights reserved.
//

import UIKit
import paper_onboarding

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var skipButton: UIButton!;
    @IBOutlet weak var getStartedButton: UIButton!;
//    Hello! We are DynaCare.
//    
//    
//    Contact your doctor
//    Be more informed
    fileprivate let items = [
        OnboardingItemInfo(
            informationImage: Asset.computer.image,
            title: "Medical Almanac",
            description: "Your pharmaceutical history in the tips of your fingers.",
            pageIcon: Asset.iconOne.image,
            color: UIColor.uiColorFromHex(rgbValue: 0x2979FF),
            titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont
        ),
        OnboardingItemInfo(
            informationImage: Asset.doctor.image,
            title: "Agile Time Tracker",
            description: "Smart calendar, that will effectively blend your private and medical affairs.",
            pageIcon: Asset.iconTwo.image,
            color: UIColor.uiColorFromHex(rgbValue: 0x0F68F4),
            titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont
        ),
        OnboardingItemInfo(
            informationImage: Asset.pills.image,
            title: "Record Drug Usage",
            description: "Start tracking your medicamentation usage, and never miss your prescription time again.",
            pageIcon: Asset.iconThree.image,
            color: UIColor.uiColorFromHex(rgbValue: 0x2052E9),
            titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont
        ),
        OnboardingItemInfo(
            informationImage: Asset.head.image,
            title: "Increase Awareness",
            description: "Great time to stop using unverified information sources, for your own good.",
            pageIcon: Asset.iconFour.image,
            color: UIColor.uiColorFromHex(rgbValue: 0x2C43DD),
            titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont
        )
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skipButton.isHidden = false;
        getStartedButton.isHidden = true;
        getStartedButton.layer.cornerRadius = 4;
        
        setupPaperOnboardingView();
        
        view.bringSubviewToFront(skipButton);
        view.bringSubviewToFront(getStartedButton);
    }
    
    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        // Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
    
    private lazy var loginVC: UIViewController = {
        UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginSignUpController");
    }()
    
    @IBAction func skipButtonTapped(_: UIButton) {
        self.navigationController?.pushViewController(loginVC, animated: true);
    }
}

// MARK: PaperOnboardingDelegate
extension OnboardingViewController: PaperOnboardingDelegate {
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 3 {
            self.getStartedButton.isHidden = false;
        } else {
            getStartedButton.isHidden = true;
        }
    }
}

// MARK: PaperOnboardingDataSource
extension OnboardingViewController: PaperOnboardingDataSource {
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }
    
    func onboardingItemsCount() -> Int {
        return 4
    }
    
}


//MARK: Constants
extension OnboardingViewController {
    
    private static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    private static let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
}

extension UIColor {
    
    class func uiColorFromHex(rgbValue: Int) -> UIColor {
        
        // &  binary AND operator to zero out other color values
        // >>  bitwise right shift operator
        // Divide by 0xFF because UIColor takes CGFloats between 0.0 and 1.0
        
        let red =   CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(rgbValue & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
