//
//  DetailNPSViewController.swift
//  Kinedu iOS Test
//
//  Created by Luis Angel Lopez Bernal on 19/04/17.
//  Copyright © 2017 UANL. All rights reserved.
//

import UIKit

class DetailNPSViewController: UIViewController,UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    @IBAction func backButton(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
