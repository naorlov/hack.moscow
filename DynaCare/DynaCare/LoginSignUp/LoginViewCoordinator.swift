//
//  LoginViewCoordinator.swift
//  DynaCare
//
//  Created by Petr Kuznetsov on 27/10/2018.
//  Copyright © 2018 Petr Kuznetsov. All rights reserved.
//


import Foundation
import UIKit
import Alamofire
import AlamofireObjectMapper

enum AMLoginSignupViewMode {
    case login
    case signup
}

class LoginSignUpViewController: UIViewController {
    
    let MainURL = URL(string: "http://35.204.85.94:8888");
    
    let animationDuration = 0.25
    var mode:AMLoginSignupViewMode = .signup
    
    
    //MARK: - background image constraints
    @IBOutlet weak var backImageLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var backImageBottomConstraint: NSLayoutConstraint!
    
    
    //MARK: - login views and constrains
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginContentView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginButtonVerticalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginWidthConstraint: NSLayoutConstraint!
    
    
    //MARK: - signup views and constrains
    @IBOutlet weak var signupView: UIView!
    @IBOutlet weak var signupContentView: UIView!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var signupButtonVerticalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var signupButtonTopConstraint: NSLayoutConstraint!
    
    
    //MARK: - logo and constrains
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoButtomInSingupConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoCenterConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var forgotPassTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var socialsView: UIView!
    
    
    //MARK: - input views
    @IBOutlet weak var loginEmailInputView: AMInputView!
    @IBOutlet weak var loginPasswordInputView: AMInputView!
    @IBOutlet weak var signupEmailInputView: AMInputView!
    @IBOutlet weak var signupPasswordInputView: AMInputView!
    @IBOutlet weak var signupPasswordConfirmInputView: AMInputView!
    
    
    
    //MARK: - controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set view to login mode
        toggleViewMode(animated: false)
        
        //add keyboard notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarFrameChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - button actions
    @IBAction func loginButtonTouchUpInside(_ sender: AnyObject) {
        
        if mode == .signup {
            toggleViewMode(animated: true)
        } else {
            if
                let userLogin = loginEmailInputView.textFieldView.text,
                let userPassword = loginPasswordInputView.textFieldView.text
            {
                let parameters: Parameters = [
                    "username": userLogin,
                    "password": userPassword,
                ]
                
                guard userLogin != "" else {
                    loginEmailInputView.labelView.textColor = .red;
                    return;
                }
                loginEmailInputView.labelView.textColor = .white;
                guard userPassword != "" else {
                    loginPasswordInputView.labelView.textColor = .red;
                    return;
                }
                loginPasswordInputView.labelView.textColor = .white;
                
                // All three of these calls are equivalent
                Alamofire.request(
                    (MainURL?.appendingPathComponent("login"))!,
                    method: .get,
                    parameters: parameters,
                    encoding: URLEncoding.default
                ).responseJSON { [unowned self] response in
                    switch response.result {
                    case .success(let JSON):
                        print("Success with JSON: \(JSON)")
                        
                        let response = JSON as! NSDictionary
                        
                        //example if there is an id
                        let responseStatus = response.object(forKey: "status")! as! String
                        if responseStatus == "OK" {
                            let userToker = response.object(forKey: "token")! as! String;
                            
                            print("We have token here: \(userToker)");
                            
                            UserDefaults.standard.set(userToker, forKey: "Token");
                            
                            let possibleVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabView");
//                            let appDelegate = UIApplication.shared.delegate as! AppDelegate;
//                            appDelegate.window?.rootViewController = possibleVC;
                            self.navigationController?.pushViewController(possibleVC, animated: true);

                            
                        } else {
                            self.loginPasswordInputView.textFieldView.textColor = .red;
                            self.loginEmailInputView.textFieldView.textColor = .red;
                        }
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                    }
                }
                
            }
        }
    }
    
    @IBAction func signupButtonTouchUpInside(_ sender: AnyObject) {
        
        if mode == .login {
            toggleViewMode(animated: true)
        } else {
            
            let userName = signupEmailInputView.textFieldView;
            let userPassword = signupPasswordInputView.textFieldView;
            let userPasswordConformation = signupPasswordConfirmInputView.textFieldView;
            
            guard userName?.text != "" else {
                signupEmailInputView.labelView.textColor = .red;
                return;
            }
            signupEmailInputView.labelView.textColor = .white;
            guard userPassword?.text != "" else {
                signupPasswordInputView.labelView.textColor = .red;
                return;
            }
            signupPasswordInputView.labelView.textColor = .white;
            guard userPasswordConformation?.text != "" else {
                signupPasswordConfirmInputView.labelView.textColor = .red;
                return;
            }
            signupPasswordConfirmInputView.labelView.textColor = .white;
            
            guard userPassword?.text == userPasswordConformation?.text else {
                signupPasswordInputView.labelView.textColor = .red;
                signupPasswordConfirmInputView.labelView.textColor = .red;
                return;
            }
            signupPasswordConfirmInputView.labelView.textColor = .white;
            signupPasswordInputView.labelView.textColor = .white;
            
            let parameters: Parameters = [
                "username": userName!.text!,
                "password": userPassword!.text!,
            ];
            
            Alamofire.request(
                (MainURL?.appendingPathComponent("register"))!,
                parameters: parameters
            ).responseJSON { [unowned self] response in
                switch response.result {
                case .success(let JSON):
                    print("Success with JSON: \(JSON)")
                    
                    let response = JSON as! NSDictionary
                    
                    //example if there is an id
                    let responseStatus = response.object(forKey: "status")! as! String
                    if responseStatus == "OK" {
                        
                        self.loginEmailInputView.setViewExpandMode(expand: true);
                        self.loginPasswordInputView.setViewExpandMode(expand: true);
                        self.loginEmailInputView.textFieldView.text = userName!.text!;
                        self.loginPasswordInputView.textFieldView.text = userPassword!.text!;
                        
                        self.toggleViewMode(animated: true);
                    } else {
                        self.signupEmailInputView.textFieldView.textColor = .red;
                    }
                    
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
        }
    }
    
    
    
    //MARK: - toggle view
    func toggleViewMode(animated:Bool) {
        
        // toggle mode
        mode = mode == .login ? .signup:.login
        
        // set constraints changes
        backImageLeftConstraint.constant = mode == .login ? 0:-self.view.frame.size.width
        
        
        loginWidthConstraint.isActive = mode == .signup ? true:false
        logoCenterConstraint.constant = (mode == .login ? -1:1) * (loginWidthConstraint.multiplier * self.view.frame.size.width)/2
        loginButtonVerticalCenterConstraint.priority = UILayoutPriority(mode == .login ? 300:900);
        signupButtonVerticalCenterConstraint.priority = UILayoutPriority(mode == .signup ? 300:900);
        
        
        //animate
        self.view.endEditing(true)
        
        UIView.animate(withDuration:animated ? animationDuration:0) {
            
            //animate constraints
            self.view.layoutIfNeeded()
            
            //hide or show views
            self.loginContentView.alpha = self.mode == .login ? 1:0
            self.signupContentView.alpha = self.mode == .signup ? 1:0
            
            
            // rotate and scale login button
            let scaleLogin:CGFloat = self.mode == .login ? 1:0.4
            let rotateAngleLogin:CGFloat = self.mode == .login ? 0: CGFloat(-Double.pi/2)
            
            var transformLogin = CGAffineTransform(scaleX: scaleLogin, y: scaleLogin)
            transformLogin = transformLogin.rotated(by: rotateAngleLogin)
            self.loginButton.transform = transformLogin
            
            
            // rotate and scale signup button
            let scaleSignup:CGFloat = self.mode == .signup ? 1:0.4
            let rotateAngleSignup:CGFloat = self.mode == .signup ? 0: CGFloat(-Double.pi/2)
            
            var transformSignup = CGAffineTransform(scaleX: scaleSignup, y: scaleSignup)
            transformSignup = transformSignup.rotated(by: rotateAngleSignup)
            self.signupButton.transform = transformSignup
        }
        
    }
    
    
    //MARK: - keyboard
    @objc func keyboarFrameChange(notification:NSNotification){
        
        let userInfo = notification.userInfo as! [String:AnyObject]
        
        // get top of keyboard in view
        let topOfKetboard = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue .origin.y
        
        
        // get animation curve for animate view like keyboard animation
        var animationDuration:TimeInterval = 0.25
        var animationCurve:UIView.AnimationCurve = .easeOut
        if let animDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
            animationDuration = animDuration.doubleValue
        }
        
        if let animCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber {
            animationCurve =  UIView.AnimationCurve.init(rawValue: animCurve.intValue)!
        }
        
        
        // check keyboard is showing
        let keyboardShow = topOfKetboard != self.view.frame.size.height
        
        
        //hide logo in little devices
        let hideLogo = self.view.frame.size.height < 667
        
        // set constraints
        backImageBottomConstraint.constant = self.view.frame.size.height - topOfKetboard
        
        logoTopConstraint.constant = keyboardShow ? (hideLogo ? 0:20):50
        logoHeightConstraint.constant = keyboardShow ? (hideLogo ? 0:40):60
        logoBottomConstraint.constant = keyboardShow ? 20:32
        logoButtomInSingupConstraint.constant = keyboardShow ? 20:32
        
        forgotPassTopConstraint.constant = keyboardShow ? 30:45
        
        loginButtonTopConstraint.constant = keyboardShow ? 25:30
        signupButtonTopConstraint.constant = keyboardShow ? 23:35
        
        loginButton.alpha = keyboardShow ? 1:0.7
        signupButton.alpha = keyboardShow ? 1:0.7
        
        
        
        // animate constraints changes
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animationDuration)
        UIView.setAnimationCurve(animationCurve)
        
        self.view.layoutIfNeeded()
        
        UIView.commitAnimations()
        
    }
    
    //MARK: - hide status bar in swift3
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

