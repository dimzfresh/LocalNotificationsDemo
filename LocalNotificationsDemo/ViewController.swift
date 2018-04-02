//
//  ViewController.swift
//  LocalNotificationsDemo
//
//  Created by Dmitrii Ziablikov on 02.04.2018.
//  Copyright © 2018 Dmitrii Ziablikov. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var timeIntervalButton: UIButton!
    
    internal let center = UNUserNotificationCenter.current()
    let userNotificationManager = UserNotificationManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyMainDesign()
        
    }
    
    func applyMainDesign() {
        
        for subview in view.subviews {
            
            guard let button = subview as? UIButton else { continue }
            
            button.layer.borderColor = UIColor.darkGray.cgColor
            button.layer.borderWidth = 0.8
            button.layer.cornerRadius = 5
            button.layer.masksToBounds = true
        }
    }

    @IBAction func timeIntervalButtonTapped(_ sender: UIButton) {
        
        userNotificationManager.addDefaultNotification()
        
    }

}

