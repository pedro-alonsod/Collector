
//
//  ItemsTableViewController.swift
//  Collector
//
//  Created by Pedro Alonso on 6/27/18.
//  Copyright © 2018 Pedro Alonso. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {

    var collectablesForTable: [Collectable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        getImages()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return collectablesForTable.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let cell = UITableViewCell()
        // Configure the cell...
        
        cell.textLabel?.text = collectablesForTable[indexPath.row].title
        if let data = collectablesForTable[indexPath.row].image {
            if let image = UIImage(data: data) {
                cell.imageView?.image = image
            }
        }
//        cell.imageView?.image = UIImage(data: collectablesForTable[indexPath.row].image)

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let itemToDelete = collectablesForTable.remove(at: indexPath.row)
            
            // Delete todo and pop back
            guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
//            if let todo = toDo {
            context.delete(itemToDelete)
//            }
            //        context.delete(toDo)
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getImages() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        
        if let rows = try? context.fetch(Collectable.fetchRequest()) {
            if let rowsReturned = rows as? [Collectable] {
                
                print(rowsReturned)
                
                collectablesForTable = rowsReturned
                self.tableView.reloadData()
            }
        }
    }

}
