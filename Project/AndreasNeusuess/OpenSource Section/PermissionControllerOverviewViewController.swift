//
//  PermissionControllerOverviewViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 08.11.15.
//  Copyright © 2015 Anerma. All rights reserved.
//

import UIKit

/// ViewController that introduces my PermissionController project.
final class PermissionControllerOverviewViewController: UIViewController, SafariViewControllerPresentable {
    private let permissionController = PermissionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tryPermissionControllerPressed(sender: AnyObject) {
        permissionController.presentPermissionViewIfNeededInViewController(self, interestedInPermission: .Location, successBlock: { () -> () in
            print("Permission for your location granted. Thank you 🙃")
            }) { () -> () in
                print("You declined permission to use your location 😞")
        }
    }
    
    @IBAction func blogPostAskAboutPermissionButtonPressed(sender: AnyObject) {
        showSafariViewControllerWithURL(NSURL(string: "https://anerma.de/blog/asking-about-permissions"))
    }
    @IBAction func permissionControllerInDetailButtonPressed(sender: AnyObject) {
        showSafariViewControllerWithURL(NSURL(string: "https://anerma.de/blog/open-source-project-permissioncontroller"))
    }
    
    @IBAction func viewOnGitHubButtonPressed(sender: AnyObject) {
        showSafariViewControllerWithURL(NSURL(string: "https://github.com/Tantalum73/PermissionController"))
    }
    
}
