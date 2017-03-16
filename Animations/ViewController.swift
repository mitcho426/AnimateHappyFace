//
//  ViewController.swift
//  Animations
//
//  Created by bwong on 3/15/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var trayView: UIView!
    
    var originalTrayCenter: CGPoint?
    
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    
//    var newlyCreatedFace: UIImageView!
//    var newlyCreatedFaceInitialCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayCenterWhenOpen = trayView.center
        trayCenterWhenClosed = CGPoint(x: trayView.center.x, y: trayView.center.y + 20)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayPanGesture(_ sender: UIPanGestureRecognizer) {
            // Absolute (x,y) coordinates in parentView
            let location = sender.location(in: self.view)
    
            if (sender.state == UIGestureRecognizerState.began) {
                originalTrayCenter = trayView.center
                NSLog("Gesture began at: %@", NSStringFromCGPoint(location));
            } else if (sender.state == UIGestureRecognizerState.changed) {
                NSLog("Gesture changed at: %@", NSStringFromCGPoint(location));
                let translation = sender.translation(in: trayView)
                trayView.center = CGPoint(x: (originalTrayCenter?.x)!, y: (originalTrayCenter?.y)! + translation.y)
            } else if (sender.state == UIGestureRecognizerState.ended) {
                NSLog("Gesture ended at: %@", NSStringFromCGPoint(location));
                let velocity = sender.velocity(in: self.trayView)
                //If the velocity.y is greater than 0, it's moving down. Otherwise, it's moving up.
                if velocity.y >= 0 {
                    self.trayView.center = trayCenterWhenClosed
                } else {
                    self.originalTrayCenter = trayCenterWhenOpen
                }
            }
        }
}

