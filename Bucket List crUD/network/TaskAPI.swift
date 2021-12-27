//
//  TaskAPI.swift
//  Bucket List crUD
//
//  Created by admin on 27/12/2021.
//

import Foundation
import Alamofire

class TaskAPI {
    static let url = "http://127.0.0.1:8080/tasks"
    static let addTasksURL = "http://127.0.0.1:8080/addTasks"
    
    static func getTaskAPIResult(completion: @escaping ([TasksStruct]?,Error?) -> ()){
        AF.request(url).responseDecodable(of: [TasksStruct].self){response in
            if let error = response.error {
                completion(nil,error)
                return
            }
            
            if let tasks  = response.value {
                completion(tasks, nil)
                return
            }
        }
    }
    
    static func postTaskToAPI(objective:String){
        
        let param = ["objective": objective, "createdAt": getTime()]
        AF.request(addTasksURL,method: .post, parameters: param, encoder: JSONParameterEncoder.default).responseJSON { res in
            print(res.result)
        }
    }
    
    static func getTime() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        let createdAt = formatter.string(from: currentDate)
        return createdAt
    }
}
