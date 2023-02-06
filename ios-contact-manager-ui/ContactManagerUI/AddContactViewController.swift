//
//  AddContactViewController.swift
//  ContactManagerUI
//
//  Created by sei_dev on 2/6/23.
//

import UIKit

final class AddContactViewController: UIViewController {
    
    @IBOutlet weak var contactTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactTextField.delegate = self
    }
}

extension AddContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            
            if text.count == 2 && updatedText.count == 3 {
                textField.text = text + "-" + string
                return false
            }
            if text.count == 6 && updatedText.count == 7 {
                textField.text = text + "-" + string
                return false
            }
            
            if text.count == 11 && updatedText.count == 12 {
                var normalText = text.replacingOccurrences(of: "-", with: "")
                normalText.insert("-", at: normalText.index(normalText.startIndex, offsetBy: 3))
                normalText.insert("-", at: normalText.index(normalText.startIndex, offsetBy: 7))
                textField.text = normalText
            }
            
            if text.count == 12 && updatedText.count == 13 {
                var normalText = text.replacingOccurrences(of: "-", with: "")
                normalText.insert("-", at: normalText.index(normalText.startIndex, offsetBy: 3))
                normalText.insert("-", at: normalText.index(normalText.startIndex, offsetBy: 8))
                textField.text = normalText
            }
            
        }
        return true
    }
}


