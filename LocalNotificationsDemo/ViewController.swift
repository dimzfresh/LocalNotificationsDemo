//
//  ViewController.swift
//  LocalNotificationsDemo
//
//  Created by Dmitrii Ziablikov on 02.04.2018.
//  Copyright © 2018 Dmitrii Ziablikov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let userNotificationManager = UserNotificationManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func timeIntervalButtonTapped(_ sender: UIButton) {
        
        userNotificationManager.addDefaultNotification()
        
    }

}

