//
//  MainNPSViewController.swift
//  Kinedu iOS Test
//
//  Created by Luis Angel Lopez Bernal on 19/04/17.
//  Copyright © 2017 UANL. All rights reserved.
//

import UIKit
import QuartzCore

class MainNPSViewController: UIViewController {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var versionsSegmentedControl: UISegmentedControl!
    let selectedSegmentedControlTintColor:UIColor = UIColor(red: 247/255, green: 142/255, blue: 33/255, alpha: 1.0)
    let noSelectedSegmentControlTintColor:UIColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.innerView.layer.cornerRadius = 10;
        self.detailsButton.layer.cornerRadius = 10;
        
        versionsSegmentedControl.removeAllSegments()
        versionsSegmentedControl.insertSegment(withTitle: "3.1", at: 0, animated: true)
        versionsSegmentedControl.insertSegment(withTitle: "3.2", at: 1, animated: true)
        versionsSegmentedControl.insertSegment(withTitle: "3.3", at: 2, animated: true)
        versionsSegmentedControl.selectedSegmentIndex = 0
        (versionsSegmentedControl.subviews[0] as UIView).tintColor = selectedSegmentedControlTintColor
        (versionsSegmentedControl.subviews[1] as UIView).tintColor = noSelectedSegmentControlTintColor
        (versionsSegmentedControl.subviews[2] as UIView).tintColor = noSelectedSegmentControlTintColor
       
    }
    
    @IBAction func segmentControlPressed(_ sender: Any) {
        
        for indexSegmentedSelected in 0...(versionsSegmentedControl.subviews.count - 1) {
            if indexSegmentedSelected == versionsSegmentedControl.selectedSegmentIndex {
                (versionsSegmentedControl.subviews[indexSegmentedSelected] as UIView).tintColor = selectedSegmentedControlTintColor
            }
            else {
                for index in 0...(versionsSegmentedControl.subviews.count - 1) {
                    if indexSegmentedSelected != index {
                        (versionsSegmentedControl.subviews[index] as UIView).tintColor = selectedSegmentedControlTintColor
                    }
                }
            }
        }
        /*
        for (segment in (versionsSegmentedControl.subviews as UIView)){
            segment.
        }
        
        
        switch versionsSegmentedControl.selectedSegmentIndex
        {
        case 0:
            versionsSegmentedControl.selectedSegmentIndex = 0
            (versionsSegmentedControl.subviews[0] as UIView).tintColor = selectedSegmentedControlTintColor
            (versionsSegmentedControl.subviews[1] as UIView).tintColor = noSelectedSegmentControlTintColor
            (versionsSegmentedControl.subviews[2] as UIView).tintColor = noSelectedSegmentControlTintColor
            break
        case 1:
            versionsSegmentedControl.selectedSegmentIndex = 1
            (versionsSegmentedControl.subviews[0] as UIView).tintColor = noSelectedSegmentControlTintColor
            (versionsSegmentedControl.subviews[1] as UIView).tintColor = selectedSegmentedControlTintColor
            (versionsSegmentedControl.subviews[2] as UIView).tintColor = noSelectedSegmentControlTintColor
            break
        case 2:
            versionsSegmentedControl.selectedSegmentIndex = 2
            (versionsSegmentedControl.subviews[0] as UIView).tintColor = noSelectedSegmentControlTintColor
            (versionsSegmentedControl.subviews[1] as UIView).tintColor = noSelectedSegmentControlTintColor
            (versionsSegmentedControl.subviews[2] as UIView).tintColor = selectedSegmentedControlTintColor
            break
        default:
            break
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
