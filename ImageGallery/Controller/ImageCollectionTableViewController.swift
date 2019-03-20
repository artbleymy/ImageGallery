//
//  ImageCollectionTableViewController.swift
//  ImageGallery
//
//  Created by Stanislav on 20.03.2019.
//  Copyright © 2019 Stanislav Kozlov. All rights reserved.
//

import UIKit

class ImageCollectionTableViewController: UITableViewController {
    
    var imageGalleries = [[ImageGallery](),[ImageGallery]()]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let imageGalleryOne = ImageGallery(with: "One")
        let imageGalleryTwo = ImageGallery(with: "Two")
        let imageGalleryThree = ImageGallery(with: "Three")
        
        imageGalleries[0].append(imageGalleryOne)
        imageGalleries[0].append(imageGalleryTwo)
        imageGalleries[0].append(imageGalleryThree)

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return imageGalleries.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imageGalleries[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)

        cell.textLabel?.text = imageGalleries[indexPath.section][indexPath.item].name

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Galleries"
        case 1: return imageGalleries[1].count > 0 ? "Recently deleted" : nil
        default: return nil
        }
    }
    //MARK: Delete action
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            switch indexPath.section{
            case 0:
                tableView.performBatchUpdates({
                    imageGalleries[1] += [imageGalleries[0].remove(at: indexPath.item)]
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
                    tableView.reloadData()
                }) { (finished) in
//                    print("refresh \(self.imageDocuments[1].count-1)")
//                    tableView.reloadRows(at: [IndexPath(row: self.imageDocuments[1].count-1, section: 1)], with: .automatic)
//                    tableView.selectRow(at: IndexPath(row: 0, section: 1), animated: true, scrollPosition: .none)
                    
                }
            case 1:
                tableView.performBatchUpdates({
                    imageGalleries[1].remove(at: indexPath.item)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                })
                
            default:
                break
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    //MARK: Undelete action
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch indexPath.section {
        case 1:
            let undelete = UIContextualAction(
                style: .normal,
                title: "Undelete",
                handler: { (contextAction, sourceView, completionHandler) in
                    tableView.performBatchUpdates({
                        self.imageGalleries[0] += [self.imageGalleries[1].remove(at: indexPath.item)]
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                        tableView.reloadData()
                    })
                    completionHandler(true)
                    
            })
            undelete.backgroundColor = #colorLiteral(red: 0.01699577458, green: 0.4876642227, blue: 0.9989843965, alpha: 1)
            return UISwipeActionsConfiguration(actions: [undelete])
            
        default:
            return nil
        }
    }
    
    
    
    override func viewWillLayoutSubviews() {
        if splitViewController?.preferredDisplayMode != .primaryOverlay {
            splitViewController?.preferredDisplayMode = .primaryOverlay
        }
    }
    
    
    @IBAction func newImageDocument(_ sender: UIBarButtonItem) {
        imageGalleries[0] += [ImageGallery(with: "Untiteled".madeUnique(withRespectTo: imageGalleries.flatMap{$0}.map{$0.name}))]
        tableView.reloadData()
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

}
