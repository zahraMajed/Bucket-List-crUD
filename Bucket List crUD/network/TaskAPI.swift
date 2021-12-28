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
        let param = ["objective": objective]
        AF.request(url,method: .post, parameters: param, encoder: JSONParameterEncoder.default).responseJSON { res in
            print(res.result)
        }
    }
    
    static func updateAPITask(objective:String, id:String){
        let urlUpDel = "http://127.0.0.1:8080/tasks/\(id)"
        let param = ["objective": objective]
    
        AF.request(urlUpDel, method: .put,parameters: param, encoder: JSONParameterEncoder.default).responseJSON { res in
            print(res.result)
            }
    }
    
    static func delAPITask(id:String){
        let urlUpDel = "http://127.0.0.1:8080/tasks/\(id)"
        AF.request(urlUpDel, method: .delete).response {
            _ in
            print("deleted")
        }
    }
    
}
