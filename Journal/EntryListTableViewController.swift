//
//  ListTableViewController.swift
//  Journal
//
//  Created by Caleb Hicks on 10/3/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    var entries = [Entry]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        EntryController.fetchAllEntriesForUser(UserController.currentUser!) { (entries) in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.entries = entries
                self.tableView.reloadData()
            })
        }
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("entryCell", forIndexPath: indexPath)

        let entry = entries[indexPath.row]
        
        cell.textLabel?.text = entry.title

        return cell
    }

//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            
//            let entry = .entries[indexPath.row]
//            
//            
//            // Delete the row from the table view
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            
//        }
//    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "toShowEntry" {
            
            if let detailViewController = segue.destinationViewController as? EntryDetailViewController {
                
                // Following line forces the view from Storyboard to load UI elements to make available for testing
                _ = detailViewController.view
                
                let indexPath = tableView.indexPathForSelectedRow
                
                if let selectedRow = indexPath?.row {
                    let entry = entries[selectedRow]
                    detailViewController.updateWithEntry(entry)
                }
            }
        }
    }
}
