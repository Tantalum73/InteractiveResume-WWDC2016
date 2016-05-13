//
//  OpenSourceTableViewCell.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 08.11.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit

/// A cell used to display an open source project in the overview. It can configure itself using 'configureUIForIndexPath:' with an indexPath.
final class OpenSourceTableViewCell: UITableViewCell {

    @IBOutlet weak var pathImageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
     Method that configures the cells subviews such as labels or ImageViews based on a given indexPath.
     
     - parameter indexPath: The indexPath on which the cell will be displayed.
     */
    func configureUIForIndexPath(indexPath: NSIndexPath) {
        
        let outline : UIImage?
        let image : UIImage?
        let text : String!
        
        switch indexPath.section + indexPath.row {
        case 0:
            //TTITransition
            outline = UIImage(named: "TTITransition Outline")
            image = UIImage(named: "TTITransition Photo")
            text = "Interactive UIViewController Transition"
        case 1:
            //PermissionControlle
            outline = UIImage(named: "PermissionController Outline")
            image = UIImage(named: "PermissionController Photo")
            text = "The right way to ask your user about permissions"
        case 2:
            //Status Magic
            outline = UIImage(named: "Status Magic Outline")
            image = UIImage(named: "Status Magic Photo")
            text = "Clean up the status bar before you submit screenshots"
        case 3:
            //WWDC for Mac
            outline = UIImage(named: "WWDC App Mac Outline")
            image = UIImage(named: "WWDC App Photo")
            text = "Watch the WWDC session videos from you Mac"
        default:
            outline = UIImage(named: "TTITransition Outline")
            image = UIImage(named: "TTITransition Photo")
            text = "Default Text"
        }
        
        pathImageView.image = outline
        backgroundImageView.image = image
        subtitleLabel.text = text
    }


}
