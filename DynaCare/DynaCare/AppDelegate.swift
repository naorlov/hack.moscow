//
//  AppDelegate.swift
//  DynaCare
//
//  Created by Petr Kuznetsov on 27/10/2018.
//  Copyright © 2018 Petr Kuznetsov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private lazy var navigationController: UINavigationController = {
        UINavigationController(rootViewController: self.onboardingContoller);
    }()

    private var onboardingContoller: UIViewController = {
        let infoViewController = UIStoryboard
            .init(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "OnboardingController") as! OnboardingViewController;
        infoViewController.modalPresentationStyle = .overCurrentContext;
        return infoViewController;
    }()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds);
        
        if let window = window {
            navigationController.isToolbarHidden = true;
            navigationController.isNavigationBarHidden = true;
            window.rootViewController = navigationController;
            window.makeKeyAndVisible()
        }
        
        return true;
    }
}
