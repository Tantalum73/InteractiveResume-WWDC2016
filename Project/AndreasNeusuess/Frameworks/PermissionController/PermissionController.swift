//
//  PermissionController.swift
//  ClubNews
//
//  Created by Andreas Neusüß on 28.04.15.
//  Copyright © 2016 Andreas Neusuess. All rights reserved.
//

import UIKit
import MapKit
import EventKit

//protocol PermissionExplanationProtocol {
//    func explanationDidFinishWithPermissionGranted(permissionGranted : Bool)
//    func showPermissionFailedAlert()
//    
//}

enum PermissionInterestedIn {
    case Location, Calendar, Notification
}
class PermissionController: NSObject, CLLocationManagerDelegate {
//    var delegate : PermissionExplanationProtocol?
    private var locationManager : CLLocationManager?
    private var eventStore : EKEventStore?
    private var currentViewControllerView: UIView?
    
    private var calendarSuccessBlock : (()->())?
    private var calendarFailureBlock: (()->())?
    
    private var successBlock : (()->())?
    private var failureBlock: (()->())?
    /**
    Checks if the user agreed to let the app use the location.
    Requests the permission if it is not already granted.
    - returns: true if user agreed false if not
    
    */

/**
Use this method to present the permission view.
The user will be asked to give the permission by a dialog.

When the user already granted his permission, the button is not enabled (early version, later: checkmark indication).

- returns: Bool that is true, when requested permission is already granted.
If other permissions are missing, the PermissionView will be displayed.
    
- parameter viewController: The UIViewController on which the PermissionView shall be presented.
    
- parameter interestedInPermission: Indicates in which action the reuest is interested in. This value decides, whether the permission requesting was successful or not and therefore which completion block will be called.
    
- parameter successBlock: This block will be executed on the main thread if the user dismissed the PermissionView and gave the desired permission.
    
- parameter failureBlock: This block will be executed on the main thread if the user dismissed the PermissionView and did not gave the desired permission.
*/
    

    func presentPermissionViewIfNeededInViewController(viewController: UIViewController, interestedInPermission: PermissionInterestedIn?, successBlock: (()->())?, failureBlock: (()->())? ) -> Bool {
        
        let status = stateOfPermissions()
        
        let allPermissionsGranted = status.permissionLocationGranted && status.permissionCalendarGranted && status.permissionNotificationGranted
        
        self.successBlock = successBlock
        self.failureBlock = failureBlock
        
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        
        if !allPermissionsGranted {
            //presenting
            let explanationViewController = ModalExplanationViewController()
            explanationViewController.permissionActionHandler = self
            explanationViewController.presentExplanationViewControllerOnViewController(viewController, nameOfNibs: ["PermissionView"], completion: { (_: Bool) -> () in
                
                if let interest = interestedInPermission {
                    let currentState = self.stateOfPermissions()
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        //TODO: maybe in the future: accept more than one desiredPermission
                        switch interest {
                        case .Location :
                            if currentState.permissionLocationGranted {
                                successBlock?()
                            }
                            else {
                                failureBlock?()
                            }
                            break
                            
                        case .Calendar:
                            if currentState.permissionCalendarGranted {
                                successBlock?()
                            }
                            else {
                                failureBlock?()
                            }
                            break
                            
                        case .Notification:
                            if currentState.permissionNotificationGranted {
                                successBlock?()
                            }
                            else {
                                failureBlock?()
                            }
                            break
                            
                        }
                    })
                }
            })
            return true
        }
                
        successBlock?()
        return true
    }
    
    
    //MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        NSNotificationCenter.defaultCenter().postNotificationName("LocalizationAuthorizationStatusChanged", object: manager)
        NSNotificationCenter.defaultCenter().postNotificationName("AuthorizationStatusChanged", object: nil)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        switch status {
        case .AuthorizedAlways:
            defaults.setBool(true, forKey: "LocationPermission")
            defaults.setBool(false, forKey: "LocationPermissionAskedOnce")
            break
        case .AuthorizedWhenInUse:
            defaults.setBool(false, forKey: "LocationPermission")
            defaults.setBool(false, forKey: "LocationPermissionAskedOnce")
            break
        case .Denied:
            defaults.setBool(false, forKey: "LocationPermission")
            defaults.setBool(true, forKey: "LocationPermissionAskedOnce")
            break
        case .NotDetermined:
            defaults.setBool(false, forKey: "LocationPermission")
            defaults.setBool(false, forKey: "LocationPermissionAskedOnce")
            break
        case .Restricted:
            defaults.setBool(false, forKey: "LocationPermission")
            defaults.setBool(true, forKey: "LocationPermissionAskedOnce")
            break
        }
        
        defaults.synchronize()
    }

    
    private func sendUserToSettings() {
        let url = NSURL(string: UIApplicationOpenSettingsURLString)!
        
        if UIApplication.sharedApplication().canOpenURL(url) {
            
            UIApplication.sharedApplication().openURL(url)
        }

    }
}

extension PermissionController: PermissionAskingProtocol {
    func stateOfPermissions() -> StatusOfPermissions {
        var status = StatusOfPermissions()
        let defaults = NSUserDefaults.standardUserDefaults()

        if defaults.boolForKey("LocationPermission") == true || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways {
            status.permissionLocationGranted = true
        }
        if NSUserDefaults.standardUserDefaults().boolForKey("CalendarPermission") == true || EKEventStore.authorizationStatusForEntityType(EKEntityType.Event) == EKAuthorizationStatus.Authorized {
            status.permissionCalendarGranted = true
        }
        let registeredNotificationSettigns = UIApplication.sharedApplication().currentUserNotificationSettings()
        
        if registeredNotificationSettigns?.types.rawValue != 0 || defaults.boolForKey("NotificationPermission") == true {
            //Some notifications are registered or already asked (probably both)
            
            status.permissionNotificationGranted = true
        }
        return status
    }
    func permissionButtonLocationPressed() {
        let status = CLLocationManager.authorizationStatus()
        let userWasAskedOnce = NSUserDefaults.standardUserDefaults().boolForKey("LocationPermissionAskedOnce")
        
        if userWasAskedOnce && status != CLAuthorizationStatus.AuthorizedAlways && status !=  CLAuthorizationStatus.AuthorizedWhenInUse {
            
            sendUserToSettings()
            return
        }
        
        self.locationManager?.requestAlwaysAuthorization()
    }
    func permissionButtonCalendarPressed() {
        let status = EKEventStore.authorizationStatusForEntityType(EKEntityType.Event)
        if status == EKAuthorizationStatus.Denied {
            sendUserToSettings()
            return
        }
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "CalendarPermissionWasAskedOnce")
        
        self.eventStore = EKEventStore()
        self.eventStore?.requestAccessToEntityType(EKEntityType.Event, completion: { (granted: Bool, error: NSError?) -> Void in
            
            let defaults = NSUserDefaults.standardUserDefaults()

            
            
            if granted {
                defaults.setBool(true, forKey: "CalendarPermission")
            }
            else {
                
                defaults.setBool(false, forKey: "CalendarPermission")
            }
            defaults.synchronize()
            dispatch_async(dispatch_get_main_queue(), {NSNotificationCenter.defaultCenter().postNotificationName("AuthorizationStatusChanged", object: nil)
            })
            
        })

    }
    func permissionButtonNotificationPressed() {
        
//        NSNotificationCenter.defaultCenter().postNotificationName("AuthorizationStatusChanged", object: nil)
        let defaults = NSUserDefaults.standardUserDefaults()
        let registeredNotificationSettigns = UIApplication.sharedApplication().currentUserNotificationSettings()
        
        if registeredNotificationSettigns?.types.rawValue == 0 && defaults.boolForKey("NotificationPermissionWasAskedOnce") == true {
            //Some notifications are registered or already asked (probably both)
            
            sendUserToSettings()
            return
        }
        
        defaults.setBool(true, forKey: "NotificationPermissionWasAskedOnce")
        
        let desiredNotificationSettigns = UIUserNotificationSettings(forTypes: [UIUserNotificationType.Alert, .Badge, .Sound] , categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(desiredNotificationSettigns)
    }
}

