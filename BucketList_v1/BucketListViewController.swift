//
//  ViewController.swift
//  BucketList_v1
//
//  Created by Calvin Nguyen on 1/16/17.
//  Copyright © 2017 Calvin Nguyen. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
    var items = ["Go visit Europe", "Fly an airplair", "See big Gundam in Tokyo", "Go somewhere for honeymoon"]
    var list_items: [List] = []
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllMission()
        tableView.reloadData()
        
        // ADD A SINGLE ITEM TO LIST
//        let list = NSEntityDescription.insertNewObject(forEntityName: "List", into: managedObjectContext) as! List
//        
//        list.details = "Sky Diving"
//        
//        if managedObjectContext.hasChanges {
//            do {
//                try managedObjectContext.save()
//                print("Success")
//            } catch {
//                print("\(error)")
//            }
//        }

        // PRINTING THE ITEMS IN LIST
//        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
//        do {
//            // get the results by executing the fetch request we made earlier
//            let results = try managedObjectContext.fetch(itemRequest)
//            // downcast the results as an array of Mission objects
//            list_items = results as! [List]
//            // print the details of each mission
//            for item in list_items {
//                print("\(item.details)")
//            }
//        } catch {
//            // print the error if it is caught (Swift automatically saves the error in "error")
//            print("\(error)")
//        }
        
        
                // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // specify the size of the data set
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return list_items.count
    }
    
    // display the items
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        
        cell.textLabel?.text = list_items[indexPath.row].details
        return cell
    }
    
    // editing of items
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItem", sender: indexPath)
    }
    
    // removal of items
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            managedObjectContext.delete(list_items[indexPath.row])
            
            if managedObjectContext.hasChanges {
                do
                {
                    try managedObjectContext.save()
                    print("Success Deleting an item to core data")
                } catch
                {
                    print("\(error)")
                }
            }

            
            list_items.remove(at: indexPath.row)
            
            tableView.reloadData()
        }
        
    }
    
    // prepare the segue to specify as delegate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // refactoring..
        
        let navigationController = segue.destination as! UINavigationController
        let addItemTableController = navigationController.topViewController as! AddItemTableViewController
        addItemTableController.delegate = self
        
        if let this_sender = sender{
            if this_sender is NSIndexPath
            {
                let indexPath = this_sender as! NSIndexPath
                // pass the item to edit to Add Item table view for
                // user to edit
                let item = list_items[indexPath.row]
                addItemTableController.edit_item = item
            }
   
        }
        
        
    }
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        
        print("cancel button pressed - i'm the delegate")
        dismiss(animated: true, completion: nil)
        
    }
    
    func itemAdded(by controller: AddItemTableViewController, with text: String){
        print("save button pressed - i'm the delegate. text is \(text)")

        let list = NSEntityDescription.insertNewObject(forEntityName: "List", into: managedObjectContext) as! List
        
        list.details = text
        
        // need to commit the changes first to record data
        if managedObjectContext.hasChanges {
            do
            {
                try managedObjectContext.save()
                print("Success Editing an item to core data")
            } catch
            {
                print("\(error)")
            }
        }


        fetchAllMission()
        tableView.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
    
    func itemEdited(by controller: AddItemTableViewController, with text: String, on item: List) {
        
        // edit the item
        item.details = text
        
        // need to commit the changes first to record data
        if managedObjectContext.hasChanges {
            do
            {
                try managedObjectContext.save()
                print("Success Adding an item to core data")
            } catch
            {
                print("\(error)")
            }
        }

        
        fetchAllMission()
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    // populate the items of the List to display on screen
    func fetchAllMission(){
        let userRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        do {
            let results = try managedObjectContext.fetch(userRequest)
            list_items = results as! [List]
        } catch {
            print("\(error)")
        }
        
    }
    
    
    
}

