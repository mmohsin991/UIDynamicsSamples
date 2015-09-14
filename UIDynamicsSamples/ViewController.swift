//
//  ViewController.swift
//  UIDynamicsSamples
//
//  Created by Mohsin on 14/09/2015.
//  Copyright (c) 2015 Mohsin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    
    
    
    var dynamicAnimator: UIDynamicAnimator!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        self.makeRoundCorner([self.view1])
        
        
        
        let collision = UICollisionBehavior(items: [self.view1])
//        collision.translatesReferenceBoundsIntoBoundary = true
        collision.addBoundaryWithIdentifier("collision", forPath: UIBezierPath(rect: self.view3.frame))
        collision.addBoundaryWithIdentifier("collision1", forPath: UIBezierPath(rect: self.view.frame))
        collision.collisionMode = UICollisionBehaviorMode.Everything
        
        
//        collision.addBoundaryWithIdentifier("collision2", forPath: UIBezierPath(ovalInRect: self.view1.frame))

        
        
        self.dynamicAnimator.addBehavior(collision)
//
        
        
//    self.addCollisonToBoundry([self.view1,self.view3])
        
        self.addDynamicItemBehavior([self.view1])
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addGravity(views: [UIView]){
        
        
        
        self.dynamicAnimator.addBehavior( UIGravityBehavior(items: views))
        
    }

    func addCollisonToBoundry(views: [UIView]){
        
        let collision = UICollisionBehavior(items: views)
        collision.translatesReferenceBoundsIntoBoundary = true
        
        
        self.dynamicAnimator.addBehavior(collision)
        
    }

    func addDynamicItemBehavior(views: [UIView]){
        
        let itemBhavior = UIDynamicItemBehavior(items: views)
        itemBhavior.density = 0.1
        itemBhavior.friction = 0.0
        itemBhavior.elasticity = 0.7
        
        
        self.dynamicAnimator.addBehavior(itemBhavior)
    }
    
    
    func makeRoundCorner(views: [UIView]){
        
        for view in views{
            view.layer.cornerRadius = view.frame.height/2
            view.layer.borderWidth = 1.0

            
            //            view.layer.masksToBounds = true
        }
    }
    
    func pushToView(views : [UIView]){
        let pushBehavior = UIPushBehavior(items: views, mode: UIPushBehaviorMode.Instantaneous)
        pushBehavior.angle = 2.0
        pushBehavior.magnitude = 0.1
        self.dynamicAnimator.addBehavior(pushBehavior)
    }
    
    @IBAction func clicked(sender: UIButton) {
        
//        self.addGravity([self.view1])

        self.pushToView([self.view1])

        
    }
}

