//
//  SettingViewController.swift
//  Tippy
//
//  Created by Bui Tien Anh on 10/5/16.
//  Copyright © 2016 Bui Tien Anh. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    let defaults = UserDefaults.standard
    @IBOutlet weak var segTippercent: UISegmentedControl!
    
    @IBOutlet weak var segCurrency: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.segTippercent.selectedSegmentIndex = defaults.integer(forKey: "loadTipPercent")
        self.segCurrency.selectedSegmentIndex = defaults.integer(forKey: "loadCurrency")
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tipChange(_ sender: AnyObject) {
        let tipArray = [0,10,15,20,25,30]
        defaults.set(segTippercent.selectedSegmentIndex, forKey: "loadTipPercent")
        defaults.set(tipArray[segTippercent.selectedSegmentIndex], forKey: "tipPercent")
        defaults.synchronize()
    }
    
    @IBAction func currencyChange(_ sender: AnyObject) {
        let currencyArray = ["vnd","$","€"]
        defaults.set(segCurrency.selectedSegmentIndex, forKey: "loadCurrency")
        defaults.set(currencyArray[segCurrency.selectedSegmentIndex], forKey: "currency")
        defaults.synchronize()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
