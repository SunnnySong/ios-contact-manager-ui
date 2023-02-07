//
//  AddContactViewController.swift
//  ContactManagerUI
//
//  Created by sei_dev on 2/6/23.
//

import UIKit

final class AddContactViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactTextField.delegate = self
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, let age = ageTextField.text, let contact = contactTextField.text else { return }
        
        do {
            try makeNewContact(name: name, age: age, contact: contact)
            self.dismiss(animated: true)
        } catch {
            makeErrorAlert(description: error.localizedDescription)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        makeCancelAlert()
    }
    
    private func makeNewContact(name: String, age: String, contact: String) throws {
        
        guard let fileURL = ModelData().fileURL else { return }
        
        let newContact = try UserInfo(name: name, age: age, phone: contact)
        
        var newContacts = ModelData().contacts
        newContacts.append(newContact)
        
        try write(fileURL: fileURL, newData: newContacts)
        print(ModelData().contacts)
    }
}

extension AddContactViewController {
    func makeErrorAlert(description: String) {
        let alert = UIAlertController(
            title: description,
            message: nil,
            preferredStyle: .alert
        )
        let checkAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(checkAction)
        self.present(alert, animated: true)
    }
    
    func makeCancelAlert() {
        let alert = UIAlertController(
            title: "정말로 취소하시겠습니까?",
            message: nil,
            preferredStyle: .alert
        )
        let noAction = UIAlertAction(title: "아니오", style: .default)
        let yesAction = UIAlertAction(title: "예", style: .destructive) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(noAction)
        alert.addAction(yesAction)
        alert.preferredAction = yesAction
        self.present(alert, animated: true)
    }
}

extension AddContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}


