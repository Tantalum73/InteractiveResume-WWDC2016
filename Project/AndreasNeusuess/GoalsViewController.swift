//
//  GoalsViewController.swift
//  AndreasNeusuess
//
//  Created by Andreas Neusüß on 14.11.15.
//  Copyright © 2015 Anerma. All rights reserved.
//

import UIKit

/// ViewController that presents my goals.
final class GoalsViewController: UIViewController {

    @IBOutlet weak var gradientViewContainingRocket: GradientView!
    @IBOutlet weak var meteor: UIImageView!
    @IBOutlet weak var bigStar1: UIImageView!
    @IBOutlet weak var bigStar2: UIImageView!
    @IBOutlet weak var bigStar3: UIImageView!
    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var smallStars: UIImageView!
    
    
    private var initialOriginOfRocket : CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        meteor.transform = CGAffineTransformTranslate(meteor.transform, 400, -60)
        addMotionEffects()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(4.5, delay: 0, options: [.Repeat], animations: { () -> Void in
            self.meteor.transform = CGAffineTransformTranslate(self.meteor.transform, -self.view.frame.size.width-500, 150)
            
      }) { (finished) -> Void in
                
        }
        
        initialOriginOfRocket = rocketImageView.frame.origin
        super.viewDidAppear(animated)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addMotionEffects() {
        rocketImageView.addMotionEffects(deltaX: 35, deltaY: 35)
        smallStars.addMotionEffects(deltaX: -15, deltaY: -15)
        bigStar1.addMotionEffects(deltaX: 20, deltaY: 20)
        bigStar2.addMotionEffects(deltaX: 15, deltaY: 15)
        bigStar3.addMotionEffects(deltaX: 10, deltaY: 10)
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func doneButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - UIScrollViewDelegate
extension GoalsViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {

        rocketImageView.frame.origin.y = initialOriginOfRocket.y - scrollView.contentOffset.y
        rocketImageView.frame.origin.x = initialOriginOfRocket.x + scrollView.contentOffset.y * 0.5
    }
}
This line will prevent compiling.

Please note the copyright and be so kind to play along.

If you would like to use parts of the app, please contact me :)