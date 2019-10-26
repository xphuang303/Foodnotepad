//
//  MainTableViewController.swift
//  foodnotepad1
//
//  Created by iOS on 2019/10/26.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController, UIImagePickerControllerDelegate {

    var allItems:[FoodItem] = [FoodItem]()
    var allImages:[ImageData] = [ImageData]()
    var detailViewController:DetailViewController?
    //var activityIndicator:UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "美食迹"
        //从CoreData 数据表装入数据
        let (items,images) = self.loadDataFromCoreDataStore()
        //若有数据装入，则显示
        if items != nil{
            self.allItems = items!
            self.allImages = images!
            self.tableView.reloadData()
        }

        //若无数据装入，则从网络接口下载数据（暂不实现）
        
        
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
        return allItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.allItems[indexPath.row].name
        cell.detailTextLabel?.text = self.allItems[indexPath.row].store
        
        //let imgdata:ImageData = self.allImages[(indexPath as NSIndexPath).row]
        let imgdata:ImageData = self.allItems[indexPath.row].image!
        
        //resize the image to width=30,height=30
        let sacleSize:CGSize = CGSize(width:30,height:30)
        UIGraphicsBeginImageContextWithOptions(sacleSize,false,0.0)
        let img:UIImage = UIImage(data: imgdata.data1! as Data)!
        img.draw(in: CGRect(x: 0,y: 0,width: sacleSize.width,height: sacleSize.height))
        let resizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        cell.imageView?.image = resizeImage
        
        return cell
    }
    

    func loadDataFromCoreDataStore() -> ([FoodItem]?,[ImageData]?) {
        var items:[FoodItem]?
        var imageData = [ImageData]()
        let context:NSManagedObjectContext = self.getContext()
        let request:NSFetchRequest<FoodItem> = FoodItem.fetchRequest()
        //无条件查询  predicate表示查询条件
        request.predicate = NSPredicate(value: true)
        //查询后按电话升序排序   ascending: true表示升序
        let sortDescriptor:NSSortDescriptor = NSSortDescriptor(key: "number", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        var error:NSError?
        do{
            items = try context.fetch(request)
            print("items count=\(String(describing: items))")
            if items == nil{
                items = nil
            }
            else if items!.count == 0{
                print("No results returned:\(error.debugDescription)")
                items = nil
            }
            else{
                for item in items!{
                    //把每一个item的image加到imageData数组里
                    imageData.append(item.image!)
                }
            }
        }catch let error1 as NSError{
            error = error1
            items = nil
            print("Error = \(String(describing: error?.description))")
        }
        return (items,imageData)
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    //UnwindSegue
    @IBAction func SaveAcyion(sender:UIStoryboardSegue){
        let vc = sender.source as! DetailViewController
        let indexPath:IndexPath? = self.tableView.indexPathForSelectedRow
        self.allItems[(indexPath! as NSIndexPath).row].name = vc.nameField.text
        self.allItems[(indexPath! as NSIndexPath).row].number = vc.numberField.text
        self.allItems[(indexPath! as NSIndexPath).row].store = vc.storeField.text
        //self.allItems[(indexPath! as NSIndexPath).row].image?.data1 = UIImagePNGRepresentaion(vc.foodphoto.image)
        self.dismiss(animated: true){
            
        }
    }
    @IBAction func CancelAction(sender:UIStoryboardSegue){
        self.dismiss(animated: true){
            
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        self.detailViewController = segue.destination as? DetailViewController
        let indexPath:IndexPath? = self.tableView.indexPathForSelectedRow
        detailViewController?.foodItem = self.allItems[(indexPath! as NSIndexPath).row]
        detailViewController?.imageData = self.allItems[(indexPath! as NSIndexPath).row].image
    }
    

}
