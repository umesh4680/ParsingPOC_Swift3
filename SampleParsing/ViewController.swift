//
//  ViewController.swift
//  SampleParsing
//
//  Created by Umesh on 09/05/17.
//  Copyright © 2017 Umesh. All rights reserved.
//

import UIKit


class LstBirthdayInfo: SafeJsonObject {
    var designation:String = ""
    var email:String = ""
    var phoneNumber:String = ""
    var politicalParty:String = ""
    var tehsil:String = ""
    var userName:String = ""
    var village:String = ""
    
    var location:Location?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "location" // replace Location With ypur key later
        {
            location = Location()
            location?.setValuesForKeys(value as! [String:AnyObject])
        }
        else
        {
            super.setValue(value, forKey: key)
        }
    }
}

class SafeJsonObject: NSObject {  /// Keep This as it is
    
    override func setValue(_ value: Any?, forKey key: String) {
        
         let string = "set\(key.uppercased().characters.first!)" // make string as "Set"+ Capital First Character of key
        
        var keyVal = key
        
        print("\(keyVal.remove(at: keyVal.startIndex))") // remove first Character
        
        let selectorString = "\(string)\(keyVal):"
        let selector = Selector(selectorString)
        if responds(to: selector)
        {
            super.setValue(value, forKey: key)
        }
        
    }
}

class Location: NSObject {  // Add your fileds
    var city:String?
    var state:String?
    
    var coordinates:Coordinate?
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "coordinates" // replace Location With ypur key later
        {
            coordinates = Coordinate()
            coordinates?.setValuesForKeys(value as! [String:AnyObject])
        }
        else
        {
            super.setValue(value, forKey: key)
        }
    }
}


class Coordinate: NSObject {  // Add your fileds
    var lat:String?
    var long:String?
    
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        
        
        var posts = [LstBirthdayInfo]()

        //==== Simple JSON Parse json1 file

        
         
        if let path = Bundle.main.path(forResource: "json1", ofType: "json")
        {
            do
            {
            let data = FileManager.default.contents(atPath: path)
                
            let jsonDictionary = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as?[String:AnyObject]
    
            print("\(jsonDictionary)")
                
                if let postDict = jsonDictionary?["lstbirthdayinfo"] as? [String:AnyObject]
                {
                    let post = LstBirthdayInfo()
                    post.setValuesForKeys(postDict)
                    
                    let Designation = post.designation
                    print("Designation= \(Designation)")
                    print("Email= \(post.email)")
                    
                    print("Location Details = \(post.location)")
                    print("Location Details = \(post.location?.city)")
                    print("Location Details = \(post.location?.state!)")
                    
                    if let state = post.location?.state
                    {
                        print("Location Details = \(state)")
                    }

                    
                    print("Location Details = \(String(describing: post.location?.coordinates?.lat))")
                    print("Location Details = \(String(describing: post.location?.coordinates?.long))")

                    
                    posts = [post]

                }
                
            
            }
            catch let err
            {
                print("Error = \(err)")
            }
        }
        
 
        
        
        
        
        
      /*
    
        
        //==== Simple JSON Parse json file

        
        if let path = Bundle.main.path(forResource: "json", ofType: "json")
        {
            do
            {
                let data = FileManager.default.contents(atPath: path)
                
                let jsonDictionary = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as?[String:AnyObject]
                
                print("\(jsonDictionary)")
                
                if let postArray = jsonDictionary?["lstbirthdayinfo"] as? [[String:AnyObject]]
                {
                    print("post = \(postArray)")
                    
                    posts = [LstBirthdayInfo]()
                    
                    for postDict in postArray
                    {
                        let post = LstBirthdayInfo()
                        post.setValuesForKeys(postDict)
                        posts.append(post)
                    }
                    
                    
                    
                }
                
                
                for postDict in posts
                {
                    var post = LstBirthdayInfo()
                    post = postDict
                    
                    print("User Names : ")
                    print("\(post.userName)")
                    
                    
                    print("Location : ")
                    print("\(post.location!.city!)-\(post.location!.state!)")
                    
                }
                
                
            }
            catch let err
            {
                print("Error = \(err)")
            }
        }
        
        
        
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

