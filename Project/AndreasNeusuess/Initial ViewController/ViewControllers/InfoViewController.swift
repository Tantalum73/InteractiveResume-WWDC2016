//
//  InfoViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 11.02.16.
//  Copyright © 2016 Anerma. All rights reserved.
//

import UIKit
import MessageUI

/// InfoViewController is shown when the user taps on the little 'i' in the lower right corner of the initial view.
final class InfoViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.layer.cornerRadius = 10
            scrollView.layer.borderWidth = 1
            scrollView.layer.borderColor = UIColor.colorFromHex(0x979797).CGColor
            scrollView.clipsToBounds = true
        }
    }
    @IBOutlet weak var ironManImageView: UIImageView!
    
    private var bouncyViewControllerForIronMan : BouncyViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bouncyViewControllerForIronMan = BouncyViewController(bouncyView: ironManImageView, imageIsOnTop: false)
        scrollView.delegate = bouncyViewControllerForIronMan
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Button Action Methods
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func githubButtonPressed(sender: AnyObject) {
        let url = NSURL(string: "https://github.com/Tantalum73")
        showSafariViewControllerWithURL(url)
    }
    @IBAction func emailButtonPressed(sender: AnyObject) {
        guard MFMailComposeViewController.canSendMail() else {return}
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.setSubject("Hi Andy 👋")
        mailComposer.setToRecipients(["developer@anerma.de"])
        mailComposer.mailComposeDelegate = self
        
        presentViewController(mailComposer, animated: true, completion: nil)
    }
    @IBAction func twitterButtonPressed(sender: AnyObject) {
        let url = NSURL(string: "https://twitter.com/Klaarname")
        showSafariViewControllerWithURL(url)
    }
    @IBAction func websiteButtonPressed(sender: AnyObject) {
        let url = NSURL(string: "https://anerma.de")
        showSafariViewControllerWithURL(url)
    }

}
//MARK: -

//MARK: SafariViewControllerPresentable
extension InfoViewController: SafariViewControllerPresentable {}

//MARK: MFMailComposeViewControllerDelegate Methods
extension InfoViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}