//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Nathan on 5/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        if let entry = self.entry {
            entry.title = titleTextField.text!
            entry.text = bodyTextView.text!
            EntryController.updateEntry(entry, completion: { (success) in
                if success {
                    self.navigationController?.popViewControllerAnimated(true)
                }
            })
            
        } else {
            let newEntry = Entry(title: self.titleTextField.text!, text: self.bodyTextView.text)
            self.entry = newEntry
            EntryController.createEntry(titleTextField.text!, text: bodyTextView.text!, completion: { (success) in
                if success {
                    self.navigationController?.popViewControllerAnimated(true)
                }
            })
        }
    }
    
    @IBAction func clearButtonTapped(sender: AnyObject) {
        
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
        func updateWithEntry(entry: Entry) {
            self.entry = entry
    
            self.titleTextField.text = entry.title
            self.bodyTextView.text = entry.text
        }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
}
