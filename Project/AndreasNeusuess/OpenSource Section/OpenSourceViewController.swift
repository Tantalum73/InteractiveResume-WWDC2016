//
//  OpenSourceViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 06.11.15.
//  Copyright © 2015 Anerma. All rights reserved.
//

import UIKit

/// ViewController that displays my contribution to the open source community. Acts as UITableViewDelegate and UITableViewDataSource.
final class OpenSourceViewController: SectionSuperViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - UITableViewDelegate & DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OpenSourceCell", forIndexPath: indexPath) as! OpenSourceTableViewCell
        
        cell.configureUIForIndexPath(indexPath)
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let identifierForNewViewController : String!
        
        switch indexPath.section + indexPath.row {
        case 0:
            //TTITransition
            identifierForNewViewController = "TTITransitionOverviewViewController"
        case 1:
            //PermissionControlle
            identifierForNewViewController = "PermissionControllerOverview"
        case 2:
            //Status Magic
            identifierForNewViewController = "StatusMagicViewController"
        case 3:
            //WWDC for Mac
            identifierForNewViewController = "WWDCMacAppViewController"
        default:
            identifierForNewViewController = "UNKNOWN"
        }
        
        let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(identifierForNewViewController)
        
        navigationController?.pushViewController(newViewController, animated: true)

    }


}
