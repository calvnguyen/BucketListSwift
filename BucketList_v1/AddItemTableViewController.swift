//
//  AddItemTableViewController.swift
//  BucketList_v1
//
//  Created by Calvin Nguyen on 1/16/17.
//  Copyright © 2017 Calvin Nguyen. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    
    weak var delegate: AddItemTableViewControllerDelegate?
    var add_item: String?
    var edit_item: List?
    
    @IBOutlet weak var itemTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let this_item = edit_item{
           itemTextField.text = this_item.details
        }
        
        
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }

    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
//        if let this_delegate = delegate{
//            print("Found delegate \(this_delegate)")
//        }
//        else{
//            print("no delegate")
//        }
        
        if let this_text = itemTextField.text{
            // if there is a List object to edit, edit
            // object passed in from the delegate
            if let edit_this_item = edit_item{
                
                delegate?.itemEdited(by: self, with: this_text, on: edit_this_item)
            }
            // otherwise, just add the new text
            else{
                delegate?.itemAdded(by: self, with: this_text)
                
            }
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
