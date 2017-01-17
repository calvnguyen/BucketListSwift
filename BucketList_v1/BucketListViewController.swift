//
//  ViewController.swift
//  BucketList_v1
//
//  Created by Calvin Nguyen on 1/16/17.
//  Copyright © 2017 Calvin Nguyen. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
    var items = ["Go visit Europe", "Fly an airplair", "See big Gundam in Tokyo", "Go somewhere for honeymoon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    // editing of items
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItem", sender: indexPath)
    }
    
    // removal of items
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // refactoring..
        
        let navigationController = segue.destination as! UINavigationController
        let addItemTableController = navigationController.topViewController as! AddItemTableViewController
        addItemTableController.delegate = self
        
        if let this_sender = sender{
            if this_sender is NSIndexPath
            {
                let indexPath = this_sender as! NSIndexPath
                let item = items[indexPath.row]
                addItemTableController.item = item
                addItemTableController.indexPath = indexPath
            }
   
        }

        
//        if segue.identifier == "AddNewItem"{
//            
//            let navigationController = segue.destination as! UINavigationController
//            let addItemTableController = navigationController.topViewController as! AddItemTableViewController
//            addItemTableController.delegate = self
//        }
//        else if segue.identifier == "EditItem"{
//            let navigationController = segue.destination as! UINavigationController
//            let addItemTableController = navigationController.topViewController as! AddItemTableViewController
//            addItemTableController.delegate = self
//            
//            let indexPath = sender as! NSIndexPath
//            let item = items[indexPath.row]
//            addItemTableController.item = item
//            addItemTableController.indexPath = indexPath
//
//        }
        
        
    }
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        
        print("cancel button pressed - i'm the delegate")
        dismiss(animated: true, completion: nil)
        
    }
    
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?){
        print("save button pressed - i'm the delegate. text is \(text)")
        // if there is index used to EDIT, edit the item at selected row
        if let this_index = indexPath{
            items[this_index.row] = text
        }
        // otherwise, just add the item instead
        else{
            items.append(text)
        }
        
        tableView.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
}

