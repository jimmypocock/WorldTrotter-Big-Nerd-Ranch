//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Jimmy Pocock on 1/21/17.
//  Copyright © 2017 Jimmy Pocock. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {

    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    let decimalDigits = CharacterSet.decimalDigits

    @IBOutlet var celsiusLabel: UILabel!
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }

    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }

    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }

    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }

    func isDecimalDigit(string: String) -> Bool {
        for uni in (string.unicodeScalars) {
            if !decimalDigits.contains(uni) {
                return false
            }
        }
        return true
    }

    func textField(_ textField: UITextField,shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")

        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            if !isDecimalDigit(string: string) && string != "." {
                return false
            }
            return true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateCelsiusLabel()
    }
}
