//
//  ProductFormViewController.swift
//  MasterDetailApp
//
//  Created by Catalina Sánchez on 6/28/18.
//  Copyright © 2018 Catalina Sánchez. All rights reserved.
//

import Foundation
import UIKit

protocol ProductManagementProtocol {
    func addProduct(name: String, imageURL: String, price: Double, expirationDate: Date?, creationDate: Date, location: Location?)
}

class ProductFormViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet var nameTextfield: UITextField!
    @IBOutlet var imageURLTextfield: UITextField!
    @IBOutlet var priceTextfield: UITextField!
    @IBOutlet var expirationDateTextfield: UITextField!
    @IBOutlet var creationDateTextfield: UITextField!
    @IBOutlet var latitudeTextfield: UITextField!
    @IBOutlet var longitudeTextfield: UITextField!
    
    var datePicker = UIDatePicker()
    var delegate: ProductManagementProtocol? = nil
    
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
            self.expirationDateTextfield.inputView = datePicker
        }
        
        if self.creationDateTextfield.isEditing {
            self.creationDateTextfield.inputAccessoryView = toolbar
            self.creationDateTextfield.inputView = datePicker
            
        }
    }
    
    // MARK: Actions
    
    func doneButtonTouchUpInside() {
        
        let name = self.nameTextfield.text ?? ""
        let image = self.imageURLTextfield.text ?? ""
        let price = NumberFormatter().number(from: self.priceTextfield.text!)?.doubleValue ?? 0.0
        let expirationDate = DateFormatter().date(from: self.expirationDateTextfield.text!) ?? nil
        let creationDate = DateFormatter().date(from: self.creationDateTextfield.text!) ?? Date()
        let latitud = NumberFormatter().number(from: self.latitudeTextfield.text!)?.doubleValue ?? nil
        let longitude = NumberFormatter().number(from: self.longitudeTextfield.text!)?.doubleValue ?? nil
        let location = Location(longitude: longitude ?? 0.0, latitude: latitud ?? 0.0)
        
        self.delegate?.addProduct(name: name, imageURL: image, price: price, expirationDate: expirationDate, creationDate: creationDate, location: location)
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
