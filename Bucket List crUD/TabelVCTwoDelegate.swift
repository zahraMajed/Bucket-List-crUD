//
//  TabelVCTwoDelegate.swift
//  Bucket List crUD
//
//  Created by admin on 14/12/2021.
//

import Foundation
import UIKit

protocol TabelVCTwoDelegates {
    
    func dismisWithCancelBtn(tvc: UITableViewController)
    func dismissWithAddBtn(taskName: String, at:NSIndexPath?)
    
}
