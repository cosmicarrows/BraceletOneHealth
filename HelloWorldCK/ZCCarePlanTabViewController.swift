//
//  ZCCarePlanTabViewController.swift
//  Bracelet One
//
//  Created by Laurence Wingo on 10/7/18.
//  Copyright © 2018 Cosmic Arrows, LLC. All rights reserved.
//

import Foundation
import UIKit
import CareKit
import SwiftSpinner

class ZCCarePlanTabViewController: UITabBarController, OCKCareCardViewControllerDelegate {
    var careplanManager: ZCCarePlanStoreManager?
    
    override func viewDidLoad() {
    
    }
    
}

extension ZCCarePlanTabViewController {
    func careCardViewController(_ viewController: OCKCareCardViewController, shouldHandleEventCompletionFor interventionActivity: OCKCarePlanActivity) -> Bool {
        return false
    }
    func careCardViewController(_ viewController: OCKCareCardViewController, didSelectButtonWithInterventionEvent interventionEvent: OCKCarePlanEvent) {
        if interventionEvent.activity.title == "Test Glucose Level" {
            let alert = UIAlertController.init(title: "Bluetooth Connectivity", message: "Are you ready to pair with your glucose meter?", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "No", style: .default, handler: nil))
            alert.addAction(UIAlertAction.init(title: "Yes", style: .default, handler: { (alert) in
                SwiftSpinner.show("Scanning for Bluetooth Device", animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(30), execute: {
                    SwiftSpinner.hide()
                    self.careplanManager?.store.update(interventionEvent, with: nil, state: .completed, completion: { (success, event, error) in
                        
                    })
                })
                
                
            }))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController.init(title: "Confirmation", message: "Are you sure you want to mark this event as done?", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "No", style: .default, handler: nil))
            alert.addAction(UIAlertAction.init(title: "Yes", style: .default, handler: { (alert) in
                self.careplanManager?.store.update(interventionEvent, with: nil, state: .completed, completion: { (success, event, error) in

                })
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

extension ZCCarePlanTabViewController: OCKSymptomTrackerViewControllerDelegate{
    
    func symptomTrackerViewController(_ viewController: OCKSymptomTrackerViewController, didSelectRowWithAssessmentEvent assessmentEvent: OCKCarePlanEvent) {
        //lookup the assessment the row represents.
        
    }
    
    
}
