//
//  AttachmentVC.swift
//  UIDynamicsSamples
//
//  Created by Mohsin on 14/09/2015.
//  Copyright (c) 2015 Mohsin. All rights reserved.
//

import UIKit

class AttachmentVC: UIViewController {


    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    
    var animator : UIDynamicAnimator!

    
    var draggingView = false
    var previousTouchPoint : CGPoint!
    var attachment : UIAttachmentBehavior!
    var collision : UICollisionBehavior!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addViews()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func addViews(){
        
        self.animator = UIDynamicAnimator(referenceView: self.containerView)
        let gravity = UIGravityBehavior(items: [self.view1,self.view2])
        gravity.gravityDirection = CGVectorMake(-1.0, 0.0)

        self.animator.addBehavior(gravity)
        
        
        self.collision = UICollisionBehavior(items: [self.view1, self.view2])
        self.collision.translatesReferenceBoundsIntoBoundary = true
        self.animator.addBehavior(self.collision)
        
        
        var itemBehavior = UIDynamicItemBehavior(items: [self.view1,self.view2])
        itemBehavior.elasticity = 0.6
        
        self.animator.addBehavior(itemBehavior)
        
        
        
        
        var gesture1 = UIPanGestureRecognizer(target: self, action: "handelPan:")
        self.view1.addGestureRecognizer(gesture1)
        var gesture2 = UIPanGestureRecognizer(target: self, action: "handelPan:")
        self.view2.addGestureRecognizer(gesture2)
        
        
        
        var attach = UIAttachmentBehavior(item: self.view1, attachedToItem: self.view2)
        attach.damping = 1.0
        attach.frequency = 10
        self.animator.addBehavior(attach)
        
    }
    
    

    
    func handelPan(gesture : UIPanGestureRecognizer){
        let touchPoint = gesture.locationInView(self.containerView)
        let draggView = gesture.view
        
        
        if gesture.state == UIGestureRecognizerState.Began{
            // 1. was the pan initiated from the upper part of the recipe?
            
            draggingView = true
            previousTouchPoint = touchPoint
            
            self.attachment = UIAttachmentBehavior(item: draggView!, attachedToAnchor: touchPoint)
            self.animator.addBehavior(self.attachment)
            
        }
        else if gesture.state == UIGestureRecognizerState.Changed && draggingView{
            // 2. handle dragging

            self.attachment.anchorPoint = touchPoint
            
        }
        else if gesture.state == UIGestureRecognizerState.Ended && draggingView{
            // 3. the gesture has ended

            draggingView = false
            self.animator.removeBehavior(self.attachment)
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
