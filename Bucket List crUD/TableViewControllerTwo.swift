//
//  TableViewControllerTwo.swift
//  Bucket List crUD
//
//  Created by admin on 14/12/2021.
//

import UIKit

class TableViewControllerTwo: UITableViewController {

    @IBOutlet weak var taskTf: UITextField!
    
    var delegate: TabelVCTwoDelegates?
    var taskName: String?
    var indexP: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let taskName = taskName {
            taskTf.text = taskName
        }
    }

    @IBAction func cancelBtnPressed(_ sender: Any) {
        delegate?.dismisWithCancelBtn(tvc: self)
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        if let taskName = taskTf.text {
            delegate?.dismissWithAddBtn(taskName: taskName, at: indexP)
        }
    }

    
}
