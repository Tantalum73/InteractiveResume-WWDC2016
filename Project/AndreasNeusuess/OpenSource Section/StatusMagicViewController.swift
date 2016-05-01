//
//  StatusMagicViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 08.11.15.
//  Copyright © 2015 Anerma. All rights reserved.
//

import UIKit

/// ViewController that tells the user about my contribution to the Status Magic project.
final class StatusMagicViewController: UIViewController, SafariViewControllerPresentable {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func viewOnGitHubButtonPressed(sender: AnyObject) {
        showSafariViewControllerWithURL(NSURL(string: "https://github.com/shinydevelopment/SimulatorStatusMagic"))
    }


}
