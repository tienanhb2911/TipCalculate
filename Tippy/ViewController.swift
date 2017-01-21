//
//  ViewController.swift
//  Tippy
//
//  Created by Bui Tien Anh on 9/24/16.
//  Copyright © 2016 Bui Tien Anh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonUpTipPercent: UIButton!
    @IBOutlet weak var textfieldTippercent: UITextField!
    
    @IBOutlet weak var buttonDownTipPercent: UIButton!
    @IBOutlet weak var numberPpSplit: UITextField!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var Billtextfield: UITextField!
    @IBOutlet weak var Billamount: UILabel!
    @IBOutlet weak var Tipamount: UILabel!
    @IBOutlet weak var TotalBill: UILabel!
    
    let defaults = UserDefaults.standard
    var timer : Timer!
    var curren:String = "vnd"
    var constrant = 0
    var numberOfPeople:Int = 2

    @IBAction func billAmountValueChange(_ sender: AnyObject) {
            }

    @IBAction func TipPercentUp(_ sender: AnyObject) {
        timer.invalidate()
        constrant += 1
        calculate()
    }
    @IBAction func TipPercentDown(_ sender: AnyObject) {
        timer.invalidate()
        if constrant == 0 {
            return
        }
        constrant -= 1
        calculate()
    }
    
    @IBAction func opTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func touchDownTipDown(_ sender: AnyObject) {
        if constrant == 0{
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(ViewController.holdDownPercent), userInfo: nil, repeats: true)
    }
    @IBAction func touchDown(_ sender: AnyObject) {
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(ViewController.holdUpPercent), userInfo: nil, repeats: true)
    }
    func holdUpPercent() {
        constrant += 1
        calculate()
    }
    func holdDownPercent() {
        if constrant == 0
        { return}
        constrant -= 1
        calculate()
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Billtextfield.becomeFirstResponder()
        
//        slider.setThumbImage(UIImage(named: "switch.png"), for: UIControlState.normal)
//        slider.setThumbImage(UIImage(named: "switch.png"), for: UIControlState.highlighted)
        
        buttonUpTipPercent.layer.borderWidth = 0.5
        buttonUpTipPercent.layer.borderColor = UIColor(colorLiteralRed: 183/255.0, green: 183/255.0, blue: 183/255.0, alpha: 1).cgColor
        
        buttonDownTipPercent.layer.borderWidth = 0.5
        buttonDownTipPercent.layer.borderColor = UIColor(colorLiteralRed: 183/255.0, green: 183/255.0, blue: 183/255.0, alpha: 1).cgColor
        
        textfieldTippercent.layer.borderWidth = 0.5
        textfieldTippercent.layer.borderColor = UIColor(colorLiteralRed: 183/255.0, green: 183/255.0, blue: 183/255.0, alpha: 1).cgColor
        loadcurrency()
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let numberValue = defaults.integer(forKey: "tipPercent")
        
        
        constrant = numberValue
        textfieldTippercent.text = "\(numberValue)%"
        
        
        let stringValue = defaults.string(forKey: "currency")
        if stringValue != nil{
            curren = stringValue!
            calculate()
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func calculate() {
        let billValue = Double(Billtextfield.text!) ?? 0
        var tip = billValue * (Double(constrant) / 100)
        let billamout = billValue / Double(numberOfPeople)
        let total = billamout + (tip / Double(numberOfPeople))
        if constrant == 0{
            tip = 0
        }
        
        if Billtextfield.text != ""{
            Tipamount.pushTransition(duration: 0.4)
            TotalBill.pushTransition(duration: 0.4)
            Billamount.pushTransition(duration: 0.4)
            
        }
        UIView.transition(with: Tipamount,
                                  duration: 0.4,
                                  options: [.transitionCrossDissolve],
                                  animations: {
                                    
                                    self.Tipamount.text = String(format: "\(self.curren) %.2f", locale: Locale.current, tip)
                                    
            }, completion: nil)
        UIView.transition(with: Billamount,
                          duration: 0.4,
                          options: [.transitionCrossDissolve],
                          animations: {
                            
                            self.Billamount.text = String(format: "\(self.curren) %.2f", locale: Locale.current, billamout)
                            
            }, completion: nil)
        UIView.transition(with: TotalBill,
                          duration: 0.4,
                          options: [.transitionCrossDissolve],
                          animations: {
                            
                            self.TotalBill.text = String(format: "\(self.curren) %.2f", locale: Locale.current, total)
                            
            }, completion: nil)

        textfieldTippercent.text = "\(constrant)%"
    }
    
    func loadcurrency(){
        Tipamount.text = String.init(format: curren+" %.2f", 0.00)
        TotalBill.text = String.init(format: curren+" %.2f", 0.00)
        Billamount.text = String.init(format: curren+" %.2f", 0.00)
    }
    
    @IBAction func sliderValueChange(_ sender: AnyObject) {
        numberPpSplit.text = String(Int(slider.value))
    }

    @IBAction func sliderTouchInside(_ sender: AnyObject) {
        if Billtextfield.text != "" && numberOfPeople != Int(slider.value){
            numberOfPeople = Int(slider.value)
            calculate()
        }
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
       calculate()
    }
}
extension UIView {
    func pushTransition(duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromTop
        animation.duration = duration
        self.layer.add(animation, forKey: kCATransitionPush)
    }
}

