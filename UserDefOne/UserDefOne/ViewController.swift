//
//  ViewController.swift
//  UserDefOne
//
//  Created by Coditas on 20/04/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var field: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        if let value = UDM.shared.defaults.value(forKey: "name") as? String{
            label.text = value
        }
     

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        UDM.shared.defaults.set(field.text, forKey: "name")
        field.resignFirstResponder()
        
        return true
    }


}

class UDM {
    
    static let shared = UDM()
    
     let defaults = UserDefaults(suiteName: "good.UserDefOne")!
    
    func getName() -> String {
        return ""
    }
}
