//
//  MenuViewController.swift
//  Jarvis
//
//  Created by James Hart on 9/27/16.
//  Copyright © 2016 James Hart. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, GuillotineMenu {
    
    var dismissButton: UIButton?
    var titleLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        dismissButton = {
            let button = UIButton(frame: .zero)
            button.setImage(UIImage(named: "ic_menu"), for: .normal)
            button.addTarget(self, action: #selector(dismissButtonTapped(_:)), for: .touchUpInside)
            return button
        }()
        
        titleLabel = {
            let label = UILabel()
            label.numberOfLines = 1;
            //label.text = "Activity"
            label.font = UIFont.boldSystemFont(ofSize: 17)
            label.textColor = UIColor.white
            label.sizeToFit()
            return label
        }()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissButtonTapped(_ sender: UIButton) {
        presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func RemoteButton(_ sender: UIButton) {
        var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        var vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "RemoteVC") as! UINavigationController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func closeMenu(_ sender: UIButton) {
        presentingViewController!.dismiss(animated: true, completion: nil)
    }
    

}

extension MenuViewController: GuillotineAnimationDelegate {
    
    func animatorDidFinishPresentation(_ animator: GuillotineTransitionAnimation) {
        print("menuDidFinishPresentation")
    }
    func animatorDidFinishDismissal(_ animator: GuillotineTransitionAnimation) {
        print("menuDidFinishDismissal")
    }
    
    func animatorWillStartPresentation(_ animator: GuillotineTransitionAnimation) {
        print("willStartPresentation")
    }
    
    func animatorWillStartDismissal(_ animator: GuillotineTransitionAnimation) {
        print("willStartDismissal")
    }
}

