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
    var item: String?
    var indexPath: NSIndexPath?
    
    @IBOutlet weak var itemTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTextField.text = item
        
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }

    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if let thistext = itemTextField.text{
            delegate?.itemSaved(by: self, with: thistext, at: indexPath)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
