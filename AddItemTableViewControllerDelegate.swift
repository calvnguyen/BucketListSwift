//
//  AddItemTableViewControllerDelegate.swift
//  BucketList_v1
//
//  Created by Calvin Nguyen on 1/16/17.
//  Copyright © 2017 Calvin Nguyen. All rights reserved.
//

import UIKit

protocol AddItemTableViewControllerDelegate: class {
    
    func itemAdded(by controller: AddItemTableViewController, with text: String)
    
    func itemEdited(by controller: AddItemTableViewController, with text: String, on item: List)
    
    func cancelButtonPressed(by controller: AddItemTableViewController)
    
    // Taken from CancelButtonDelegate file, and altered to match pattern.
    // NOTE: You will need to update AddItemTableViewController to make the Cancel Button work
}
