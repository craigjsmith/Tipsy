//
//  ViewController.swift
//  tipsy
//
//  Created by Craig Smith on 7/27/20.
//  Copyright © 2020 Craig Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billInput: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalPartyLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var totalPersonView: UIView!
    
    @IBOutlet weak var tipSelect: UISegmentedControl!
    @IBOutlet weak var partyStepper: UIStepper!

    let currencyFormatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Rounded corners on caculated totals
        totalView.layer.cornerRadius = 10
        tipView.layer.cornerRadius = 10
        totalPersonView.layer.cornerRadius = 10
        
        // Configure currency formatter
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current;
        
        // Select bill input when app opens
        billInput.becomeFirstResponder()

        reset()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        
        // Default tipping options
        UserDefaults.standard.register(defaults: ["tipOption0" : 10])
        UserDefaults.standard.register(defaults: ["tipOption1" : 15])
        UserDefaults.standard.register(defaults: ["tipOption2" : 18])
        UserDefaults.standard.register(defaults: ["tipOption3" : 20])
        
        // Set segmented control tipping options
        tipSelect.setTitle(defaults.string(forKey: "tipOption0")! + "%", forSegmentAt: 0)
        tipSelect.setTitle(defaults.string(forKey: "tipOption1")! + "%", forSegmentAt: 1)
        tipSelect.setTitle(defaults.string(forKey: "tipOption2")! + "%", forSegmentAt: 2)
        tipSelect.setTitle(defaults.string(forKey: "tipOption3")! + "%", forSegmentAt: 3)
        
        // Calculate tip
        calc(true)
    }

    /**
        Calculate tip, total, and splot payment per person in party
     */
    @IBAction func calc(_ sender: Any) {
        
        // Get bill and party size values
        let bill = Double(billInput.text!) ?? 0
        let partySize = partyStepper.value
        
        // Array of tipping increments in order they appear in segmented controls
        // converted to decimal format
        let tipAmounts = [defaults.double(forKey: "tipOption0")/100,
                          defaults.double(forKey: "tipOption1")/100,
                          defaults.double(forKey: "tipOption2")/100,
                          defaults.double(forKey: "tipOption3")/100]
        
        // Tip calculation
        let tip = bill * tipAmounts[tipSelect.selectedSegmentIndex]
        
        // Total calculation (bill + tip)
        let total = bill + tip
        
        // Total Per Person calculation (total / party size)
        let totalParty = total / partySize
        
        // Set outputs to calculated values
        tipLabel.text = currencyFormatter.string(from: NSNumber(value: tip))!
        totalLabel.text = currencyFormatter.string(from: NSNumber(value: total))!
        totalPartyLabel.text = currencyFormatter.string(from: NSNumber(value: totalParty))!
        partyLabel.text = String(format:"%.0f", partySize)
        
    }
    
    /**
        When bill input selected, wipe previous input and resest all calcuated outputs
     */
    @IBAction func editBillBegin(_ sender: Any) {
        billInput.text = ""
        reset()
    }
    
    /**
        When bill input was edited but left empty, reset to default value
     */
    @IBAction func editBillEnd(_ sender: Any) {
        if(billInput.text == "") {
            billInput.text = Locale.current.currencySymbol
        }
    }
    
    /**
        Close keyboard when tapped anywhere on View
     */
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    /**
        Set all inputs and calculated outputs to zero
     */
    func reset() {
        tipLabel.text = currencyFormatter.string(from: NSNumber(value: 0))!
        totalLabel.text = currencyFormatter.string(from: NSNumber(value: 0))!
        totalPartyLabel.text = currencyFormatter.string(from: NSNumber(value: 0))!
        billInput.text = Locale.current.currencySymbol
    }
    
}
