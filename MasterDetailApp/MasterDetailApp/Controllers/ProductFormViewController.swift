//
//  ProductFormViewController.swift
//  MasterDetailApp
//
//  Created by Catalina Sánchez on 6/28/18.
//  Copyright © 2018 Catalina Sánchez. All rights reserved.
//

import Foundation
import UIKit

class ProductFormViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet var nameTextfield: UITextField!
    @IBOutlet var imageURLTextfield: UITextField!
    @IBOutlet var expirationDateTextfield: UITextField!
    @IBOutlet var creationDateTextfield: UITextField!
    @IBOutlet var latitudeTextfield: UITextField!
    @IBOutlet var longitudeTextfield: UITextField!
    
    var datePicker = UIDatePicker()
    
    struct Constants {
        static let doneButtonTitle = "Done"
        static let cancelButtonTitle = "Cancel"
    }
    
    // MARK: Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDoneButton()
    }
    
    // MARK: done button
    
    func addDoneButton() {
        let doneButton = UIBarButtonItem.init(title: Constants.doneButtonTitle, style: UIBarButtonItemStyle.done, target: self, action: #selector(doneButtonTouchUpInside))
        doneButton.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = doneButton
        
    }
    
    func showDatePicker() {
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem.init(title: Constants.doneButtonTitle, style: .done, target: self, action: #selector(datePickerDone))
        let space = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem.init(title: Constants.cancelButtonTitle, style: .done, target: self, action: #selector(datePickerCancel))
        toolbar.setItems([doneButton, space, cancelButton], animated: false)
        
        if self.expirationDateTextfield.isEditing {
            self.expirationDateTextfield.inputAccessoryView = toolbar
            self.creationDateTextfield.inputAccessoryView = toolbar
        }
        
        if self.creationDateTextfield.isEditing {
            self.creationDateTextfield.inputView = datePicker
            self.expirationDateTextfield.inputView = datePicker
        }
    }
    
    // MARK: Actions
    
    func doneButtonTouchUpInside() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func datePickerDone() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        if self.expirationDateTextfield.isEditing {
            self.expirationDateTextfield.text = formatter.string(from: self.datePicker.date)
        }
        
        if self.creationDateTextfield.isEditing {
            self.creationDateTextfield.text = formatter.string(from: datePicker.date)
        }
        datePickerCancel()
    }
    
    func datePickerCancel() {
        self.view.endEditing(true)
    }
    
    @IBAction func expirationDateStartEditing(_ sender: Any) {
        showDatePicker()
    }
    
    @IBAction func creationDateStartEditing(_ sender: Any) {
        showDatePicker()
    }
    
    
    
    
}
