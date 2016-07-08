//
//  ViewController.swift
//  Get IP
//
//  Created by Peterlee on 7/8/28 H.
//  Copyright © 28 Heisei Peterlee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var wifiLabel:UILabel?
    @IBOutlet weak var cellularLabel:UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
//        NetworkModel.getIPAddress()
        

        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        wifiLabel?.text = "WiFi:"+NetworkModel.getWiFiIPAddress()
        cellularLabel?.text = "Cellular:"+NetworkModel.getCellularIPAddress()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

