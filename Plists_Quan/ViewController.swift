//
//  ViewController.swift
//  Plists_Quan
//
//  Created by quanmacos on 5/11/17.
//  Copyright © 2017 quanmacos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let myItemKey = "myItem"
    var myItemValue: String?
    
    @IBOutlet weak var txt_value: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        
        let documentDirectory = paths[0] as! String
        let path = documentDirectory.appending("Data.plist")
        
        let fileManager = FileManager.default
        if(!fileManager.fileExists(atPath: path)) {
            if let bundlePath = Bundle.main.path(forResource: "Data", ofType: "plist") {
                let result = NSMutableDictionary(contentsOfFile: bundlePath)
                print("Bundle File Data.plist is: -> \(String(describing: result?.description))")
                do {
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                } catch {
                    print("Copy failure")
                }
            } else {
                print("file Data.plist not found")
            }
        } else {
            print("File Data.plist already at path")
        }
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        print("Load Data.plist is -> \(String(describing: resultDictionary?.description))")
        
        let myDict = NSDictionary(contentsOfFile: path)
        if let dict = myDict {
            myItemValue = dict.object(forKey: myItemKey) as? String
            txt_value.text = myItemValue
        } else {
            print("Load Failure")
        }
    }
}

