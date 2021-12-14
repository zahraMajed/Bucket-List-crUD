//
//  ViewController.swift
//  Bucket List crUD
//
//  Created by admin on 14/12/2021.
//

import UIKit

class TabelViewController: UITableViewController , TabelVCTwoDelegates {
    
    var tasks : [Tasks] = [Tasks(tasNname: "cooking")]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].tasNname
        return cell
    }

    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditTask", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tasks.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddTask" {
            let destination = segue.destination as!  UINavigationController
            let tvc2 = destination.topViewController as! TableViewControllerTwo
            tvc2.delegate = self
        } else if segue.identifier == "EditTask" {
            let destination = segue.destination as!  UINavigationController
            let tvc2 = destination.topViewController as! TableViewControllerTwo
            tvc2.delegate = self
            let indexPAth = sender as! NSIndexPath
            tvc2.taskName = tasks[indexPAth.row].tasNname
            tvc2.indexP = indexPAth
        }
    }
    
    func dismissWithAddBtn(taskName: String, at: NSIndexPath?) {
        if let ip = at {
            tasks[ip.row].tasNname = taskName
        } else{
            tasks.append(Tasks(tasNname: taskName))
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func dismisWithCancelBtn(tvc: UITableViewController) {
        dismiss(animated: true, completion: nil)
    }

}

struct Tasks {
    var tasNname: String
}

