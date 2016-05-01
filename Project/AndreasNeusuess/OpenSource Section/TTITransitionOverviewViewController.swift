//
//  TTITransitionOverviewViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 08.11.15.
//  Copyright © 2015 Anerma. All rights reserved.
//

import UIKit

/// ViewController that displays general information about my TTITransition project.
final class TTITransitionOverviewViewController: UIViewController, SafariViewControllerPresentable {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewOnGitHubButtonPressed(sender: AnyObject) {
        showSafariViewControllerWithURL(NSURL(string: "https://github.com/Tantalum73/TTITransition"))
    }

}
