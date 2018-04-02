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
        
        timeIntervalButton.layer.borderColor = UIColor.darkGray.cgColor
        timeIntervalButton.layer.borderWidth = 0.8
        timeIntervalButton.layer.cornerRadius = 5
        timeIntervalButton.layer.masksToBounds = true

//        center.getDeliveredNotifications { (notofications) in
//
//        }

    }

    @IBAction func timeIntervalButtonTapped(_ sender: UIButton) {
        
        userNotificationManager.addDefaultNotification()
        
    }

}

