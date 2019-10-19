//
//  MainTableViewController.swift
//  foodnotepad
//
//  Created by iOS on 2019/10/3.
//  Copyright © 2019 Xphuang. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, UITextFieldDelegate {
    
    var foods:[DatailsOfFoodData] = [DatailsOfFoodData]()  // create an empty DatailsOfFoodData array
    var food = DatailsOfFoodData()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.leftBarButtonItem?.image = UIImage(named: "Menu")?.withRenderingMode(.alwaysOriginal)
        //self.navigationItem.rightBarButtonItem?.image = UIImage(named: "rightTopImage")?.withRenderingMode(.alwaysOriginal)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foods.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        // Configure the cell...
        cell.textLabel!.text = self.foods[indexPath.row].name
        cell.detailTextLabel!.text = self.foods[indexPath.row].store
        //cell.imageView?.image = UIImage(named: self.foods[indexPath.row].imageName)
        return cell
    }
    // UnwindSegue
    @IBAction func OKAction(sender:UIStoryboardSegue)
    {
        let vc = sender.source as! DetailViewController
        print("hello")
        food.name = vc.name!
        food.number = vc.number!
        food.store = vc.store!
        
        //let currentText = textField.text ?? ""
        //let newText = currentText.replacingCharacters(in: range.toRange(string: currentText), with: string)
        foods.append(food)
        
        self.dismiss(animated: true) {

        }
    }
    @IBAction func CancelAction(sender:UIStoryboardSegue)
    {
        self.dismiss(animated: true) {
            
        }

    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

}
