//
//  SettingsViewController.swift
//  tipsy
//
//  Created by Craig Smith on 7/27/20.
//  Copyright © 2020 Craig Smith. All rights reserved.
//

import UIKit

let defaults = UserDefaults.standard

class SettingsViewController: UIViewController {
    @IBOutlet weak var tip0Input: UITextField!
    @IBOutlet weak var tip1Input: UITextField!
    @IBOutlet weak var tip2Input: UITextField!
    @IBOutlet weak var tip3Input: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tip0Input.text = defaults.string(forKey: "tipOption0")
        tip1Input.text = defaults.string(forKey: "tipOption1")
        tip2Input.text = defaults.string(forKey: "tipOption2")
        tip3Input.text = defaults.string(forKey: "tipOption3")
    }
    
    @IBAction func changeTip0(_ sender: Any) {
        defaults.set(tip0Input.text, forKey: "tipOption0")
        defaults.synchronize()
    }
    @IBAction func changeTip1(_ sender: Any) {
        defaults.set(tip1Input.text, forKey: "tipOption1")
        defaults.synchronize()
    }
    @IBAction func changeTip2(_ sender: Any) {
        defaults.set(tip2Input.text, forKey: "tipOption2")
        defaults.synchronize()
    }
    @IBAction func changeTip3(_ sender: Any) {
        defaults.set(tip3Input.text, forKey: "tipOption3")
        defaults.synchronize()
    }

}
