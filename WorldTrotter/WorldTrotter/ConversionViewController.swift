//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by seo on 2017. 6. 18..
//  Copyright © 2017년 seoju. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitvalue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitvalue {
            return (value - 32) * (5/9)
        } else {
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateCelsiusLabel() {
        guard let value = self.celsiusValue else {
            self.celsiusLabel.text = "???"
            return
        }
        
        self.celsiusLabel.text = numberFormatter.string(for: value)
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        self.textField.resignFirstResponder()
    }
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        guard let text = textField.text, let value = Double(text) else {
            self.fahrenheitvalue = nil
            return
        }
        
        self.fahrenheitvalue = value
    }
}

extension ConversionViewController: UITextFieldDelegate {
    
    // MARK: Text field delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.rangeOfCharacter(from: .letters) == nil else {
            print("숫자가 아닙니다.")
            return false
        }
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")

        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
}
