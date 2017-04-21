//
//  MainNPSViewController.swift
//  Kinedu iOS Test
//
//  Created by Luis Angel Lopez Bernal on 19/04/17.
//  Copyright © 2017 UANL. All rights reserved.
//

import UIKit
import QuartzCore

class MainNPSViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var versionsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var customTableView: UITableView!
    
    let cellReuseIdentifier = "cell"
    var versionsData:[String] = []
    var versionsArray = [(id: String, nps: String, days_since_signup: String, user_plan: String, activity_views: String, build_version: String, build_release_date: String)]()
    var allVersionsArray = [[(id: String, nps: String, days_since_signup: String, user_plan: String, activity_views: String, build_version: String, build_release_date: String)]]()

    var NPSCounterArray = [(detractorF: String, neutralF: String, promoterF: String, detractorP: String, neutralP: String, promoterP: String)]()
    var allNPSCounterArray = [[(detractorF: String, neutralF: String, promoterF: String, detractorP: String, neutralP: String, promoterP: String)]]()
    var NPSPercentArray = [(detractorF: String, neutralF: String, promoterF: String, detractorP: String, neutralP: String, promoterP: String)]()
    var allNPSPercentArray = [[(detractorF: String, neutralF: String, promoterF: String, detractorP: String, neutralP: String, promoterP: String)]]()
    
    let selectedSegmentedControlTintColor:UIColor = UIColor(red: 247/255, green: 142/255, blue: 33/255, alpha: 1.0)
    let noSelectedSegmentControlTintColor:UIColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0)
    
    var myView: UIView = UIView()
    var myImageToAnimate: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        downloadJson()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if versionsData.count == 0 {
            let screenSize: CGRect = UIScreen.main.bounds
            myView = UIView(frame: CGRect(x: screenSize.width/2, y: screenSize.height/2, width: screenSize.width, height: screenSize.height))
            
            myView.backgroundColor = UIColor(red: 27/255, green: 117/255, blue: 187/255, alpha: 1.0)
            self.view.addSubview(myView)
            
            myView.center.x = self.view.center.x
            myView.center.y = self.view.center.y - 65
            
            let imageName = "baby_0"
            let image = UIImage(named: imageName)
            myImageToAnimate = UIImageView(image: image!)
            myImageToAnimate.frame = CGRect(x: 0, y: 0, width: 175, height: 176)
            myImageToAnimate.center.x = myView.center.x
            myImageToAnimate.center.y = myView.center.y
            
            myView.addSubview(myImageToAnimate)
            
            var images: [UIImage] = []
            for index in 1...10 {
                let imageName = "baby_" + String(index)
                images.append(UIImage(named: imageName)!)
            }
            myImageToAnimate.animationImages = images
            myImageToAnimate.animationDuration = 3.0
            myImageToAnimate.startAnimating()
            
            moveImageViewBottom(imageView: myImageToAnimate)
            moveImageViewTop(imageView: myImageToAnimate)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 3.0, options: .transitionCrossDissolve, animations: { _ in
            view.isHidden = hidden
        }, completion: nil)
    }
    
    func moveImageViewBottom(imageView: UIImageView){
        UIView.animate(withDuration: 0.7, delay: 0.1, options: .curveEaseOut, animations: {
            imageView.frame.origin.x -= 80
            imageView.frame.origin.y -= 150
        }, completion: { finished in
            //
        })
    }
    
    func moveImageViewTop(imageView: UIImageView){
        UIView.animate(withDuration: 0.7, delay: 1.1, options: .curveEaseInOut, animations: {
            imageView.frame.origin.x += 100
            imageView.frame.origin.y += 200
        }, completion: { finished in
            //
        })
    }
    
    func downloadJson()
    {
        let urlPath: String = "http://demo.kinedu.com/bi/nps"
        guard let url = URL(string: urlPath) else
        {
            print("Url conversion issue.")
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if error == nil && data != nil {
                do {
                    let json:NSArray =  try (JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers) as? NSArray)!
                    self.parseJson(json: json)
                } catch {
                    print(error)
                }
            }
            else if error != nil
            {
                print(error!)
            }
        }).resume()
        
    }
    
    func parseJson(json: NSArray){
        var versionReleaseArray = [String]()
        var versionReleaseIndex = [Int]()
        for item in json {
            let version = (((item as! NSDictionary).object(forKey: "build")) as! NSDictionary).object(forKey: "version") as! String
            let versionRelease = (((item as! NSDictionary).object(forKey: "build")) as! NSDictionary).object(forKey: "release_date") as! String
            
            if versionsData.count != 0 {
                var versionAlreadyAdded:Bool = false
                for indexVersion in 0...versionsData.count-1 {
                    if (versionsData[indexVersion] == version){
                        versionAlreadyAdded = true
                    }
                }
                if versionAlreadyAdded == false {
                    versionsData.append((((item as! NSDictionary).object(forKey: "build")) as! NSDictionary).object(forKey: "version") as! String)
                    versionReleaseArray.append(versionRelease)
                    versionReleaseIndex.append(Int(versionReleaseArray.count) - 1)
                }
            } else {
                versionsData.append((((item as! NSDictionary).object(forKey: "build")) as! NSDictionary).object(forKey: "version") as! String)
                versionReleaseArray.append(versionRelease)
                versionReleaseIndex.append(0)
            }
        }
        
        versionsData = versionsData.sorted { $0 > $1}
        
        /*for version in versionsData {
            print(version)
        }
        
        for version in versionReleaseIndex {
            print(String(version))
        }
        
        for version in versionReleaseArray {
            print(version)
            let dateString = version
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let s = dateFormatter.date(from: dateString)
            print(s!)
        }*/
        
        for item in json {
            let idJson = String((item as! NSDictionary).object(forKey: "id") as! Int)
            let npsJson = String((item as! NSDictionary).object(forKey: "nps") as! Int)
            let daysSinceSignUpJson = String((item as! NSDictionary).object(forKey: "days_since_signup") as! Int)
            let userPlanJson = (item as! NSDictionary).object(forKey: "user_plan") as! String
            let activityViewsJson = String((item as! NSDictionary).object(forKey: "activity_views") as! Int)
            let versionBuildJson = (((item as! NSDictionary).object(forKey: "build")) as! NSDictionary).object(forKey: "version") as! String
            let releaseDateBuildJson = (((item as! NSDictionary).object(forKey: "build")) as! NSDictionary).object(forKey: "release_date") as! String
                
            versionsArray.append(id: idJson, nps: npsJson, days_since_signup: daysSinceSignUpJson, user_plan: userPlanJson, activity_views: activityViewsJson, build_version: versionBuildJson, build_release_date: releaseDateBuildJson)
        }
        
        versionsArray = versionsArray.sorted { $0.build_version > $1.build_version}
        var tempVersionsArray = [(id: String, nps: String, days_since_signup: String, user_plan: String, activity_views: String, build_version: String, build_release_date: String)]()

        for index in 0...versionsArray.count-1 {
            if index != 0 {
                if versionsArray[index].build_version < versionsArray[index-1].build_version {
                    allVersionsArray.append(tempVersionsArray)
                    tempVersionsArray.removeAll()
                    tempVersionsArray.append(versionsArray[index])
                }
                else {
                    if versionsArray.last?.id != versionsArray[index].id {
                        tempVersionsArray.append(versionsArray[index])
                    }
                    else {
                        tempVersionsArray.append(versionsArray[index])
                        allVersionsArray.append(tempVersionsArray)
                        tempVersionsArray.removeAll()
                    }
                }
            }
            else {
                tempVersionsArray.append(versionsArray[index])

            }
            
        }
        
        for versionArray in allVersionsArray {
            for item in versionArray {
                var freemiumD = Int()
                var freemiumN = Int()
                var freemiumP = Int()
                var premiumD = Int()
                var premiumN = Int()
                var premiumP = Int()
                if item.user_plan == "freemium" {
                    if Int(item.nps)! > 8 {
                        freemiumP = freemiumP + 1
                    }
                    else if (Int(item.nps)! == 8 || Int(item.nps)! == 7) {
                        freemiumN = freemiumN + 1
                    }
                    else {
                        freemiumD = freemiumD + 1
                    }
                }
                else {
                    if Int(item.nps)! > 8 {
                        premiumP = premiumP + 1
                    }
                    else if (Int(item.nps)! == 8 || Int(item.nps)! == 7) {
                        premiumN = premiumN + 1
                    }
                    else {
                        premiumD = premiumD + 1
                    }
                }
            }
        }
        
        DispatchQueue.main.async {
            self.initialize()

            //print(self.allVersionsArray)
        }
        
    }
    
    func initialize() {
        
        self.innerView.layer.cornerRadius = 10;
        self.detailsButton.layer.cornerRadius = 10;
        
        versionsSegmentedControl.removeAllSegments()
        for versionIndex in 0...versionsData.count-1 {
            versionsSegmentedControl.insertSegment(withTitle: versionsData[versionIndex], at: versionIndex, animated: true)
        }
        
        for versionIndex in 0...versionsData.count-1 {
            if versionIndex == 0 {
                (versionsSegmentedControl.subviews[0] as UIView).tintColor = selectedSegmentedControlTintColor
            }
            else {
                (versionsSegmentedControl.subviews[versionIndex] as UIView).tintColor = noSelectedSegmentControlTintColor
            }
        }
        
        versionsSegmentedControl.selectedSegmentIndex = 0
        setView(view: myView, hidden: true)
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

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:NPSScoreTableViewCell = customTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! NPSScoreTableViewCell
        
        cell.firstLabel.backgroundColor = UIColor.black
        cell.secondLabel.text = "Out of " + String(indexPath.row) + " users"
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    
}
