//
//  ViewController.swift
//  Jarvis
//
//  Created by James Hart on 7/29/16.
//  Copyright © 2016 James Hart. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AudioToolbox


class ViewController: UIViewController {
    
    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()
     @IBOutlet fileprivate var barButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar = self.navigationController!.navigationBar
        navBar.barTintColor = UIColor.black
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UIApplication.shared.statusBarStyle = .lightContent
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showMenuAction(_ sender: UIButton) {
        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "MenuViewController")
        menuViewController.modalPresentationStyle = .custom
        menuViewController.transitioningDelegate = self
        
        presentationAnimator.animationDelegate = menuViewController as? GuillotineAnimationDelegate
        presentationAnimator.supportView = navigationController!.navigationBar
        presentationAnimator.presentButton = sender
        present(menuViewController, animated: true, completion: nil)
    }

    

    //MARK - HTTP REQUESTS 
    
    @IBAction func powerOff(_ sender: AnyObject) {
       let HTTP = HTTPHelp()
       HTTP.LRLightsOff()
       AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
    }
    
    
    
    @IBAction func powerOn(_ sender: AnyObject) {
        let HTTP = HTTPHelp()
        HTTP.LRLightsOn()
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    

    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .dismissal
        return presentationAnimator
    }
}

