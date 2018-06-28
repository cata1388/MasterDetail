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
    
    struct Constants {
        static let doneButtonTitle = "Done"
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
    
    func doneButtonTouchUpInside() {
        self.navigationController?.popViewController(animated: true)
    }
}
