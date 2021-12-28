//
//  ViewController.swift
//  Bucket List crUD
//
//  Created by admin on 14/12/2021.
//

import UIKit
import CoreData

class TabelViewController: UITableViewController , TabelVCTwoDelegates {
    var tasks : [TasksStruct] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        //tasks = getTask()
        attemptsToFetchTaskAPI()
    }
    
    //TABLE VIEW FUNCTION
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].objective
        return cell
    }

    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditTask", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //shoud be deleteTaskAPI function and  then call attemptsToFetchTaskAPI() inside it
       //deleteTask(indexP: indexPath.row)
       //tasks = getTask()
        //tableView.reloadData()
        let id = tasks[indexPath.row].id
        attemptsToDelTaskAPI(id: id)
    }
    
    //API
    func attemptsToFetchTaskAPI(){
        TaskAPI.getTaskAPIResult { tasksResonseArray, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            guard let tasksResonseArray = tasksResonseArray else {
                return
            }
            self.tasks = tasksResonseArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func attemptsToPostTaskAPI(objective:String){
        TaskAPI.postTaskToAPI(objective: objective)
        attemptsToFetchTaskAPI()
    }
    
    func attemptsToDelTaskAPI(id:String){
        TaskAPI.delAPITask(id: id)
        attemptsToFetchTaskAPI()
    }
    
    func attemptsToUpdateAPITask(objective:String, id:String){
        TaskAPI.updateAPITask(objective: objective, id: id)
        attemptsToFetchTaskAPI()
    }
    
    //PREPARE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem {
            let destination = segue.destination as!  UINavigationController
            let tvc2 = destination.topViewController as! TableViewControllerTwo
            tvc2.delegate = self
        } else if sender is IndexPath {
            let destination = segue.destination as!  UINavigationController
            let tvc2 = destination.topViewController as! TableViewControllerTwo
            tvc2.delegate = self
            let indexPAth = sender as! NSIndexPath
            tvc2.taskName = tasks[indexPAth.row].objective
            tvc2.indexP = indexPAth
        }
    }
    
    //DELEGATES FUNCTION
    func dismisWithCancelBtn(tvc: UITableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func dismissWithAddBtn(taskName: String, at: NSIndexPath?) {
        if let ip = at {
            //tasks[ip.row].tasNname = taskName
            //updateTaks(taskName: taskName, indexP: ip.row)
            //tasks = getTask()
            //tableView.reloadData()
            let id = tasks[ip.row].id
            attemptsToUpdateAPITask(objective: taskName, id: id)
        }else{
            //tasks.append(Tasks(tasNname: taskName))
            //addTask(taskName: taskName)
            attemptsToPostTaskAPI(objective: taskName)
        }
        dismiss(animated: true, completion: nil)
    }
    
    // CORE DATA PART CODE
    /*func addTask(taskName:String){
        // refer to appdelegate in order to be abel accessing persistentContainer
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        // create context from persistentContainer -context is mu DB-
        let context = appDelegate.persistentContainer.viewContext
        // create entity
        guard let tasksEntity = NSEntityDescription.entity(forEntityName: "Task", in: context) else {return}
        
        //create record and set value to it
        let task = NSManagedObject(entity: tasksEntity, insertInto: context)
        task.setValue(taskName, forKey: "taskName")
        
        // save changes to database (context)
        do{
            try context.save()
        }catch {
            print("===Error addTask Function===")
        }
    }*/
    
    /*func updateTaks(taskName:String, indexP:Int){
        // refer to appdelegate in order to be abel accessing persistentContainer
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        // create context from persistentContainer -context is mu DB-
        let context = appDelegate.persistentContainer.viewContext
        // get fetch request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
           let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            result[indexP].setValue(taskName, forKey: "taskName")
            try context.save()
            
        }catch {
            print("===Error updateTaks Function===")
        }
    }*/
    
    /*func getTask() -> [TasksStruct] {
        var taskArrayInGetTasks:[TasksStruct] = []
        // refer to appdelegate in order to be abel accessing persistentContainer
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return []}
        // create context from persistentContainer -context is mu DB-
        let context = appDelegate.persistentContainer.viewContext
        // get fetch request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
           let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            for data in result {
                let taskName = data.value(forKey: "taskName") as! String
                taskArrayInGetTasks.append(TasksStruct(objective: taskName))
            }
        }catch {
            print("===Error getTasks Function===")
        }
        return taskArrayInGetTasks
    }*/
    
    /*func deleteTask(indexP:Int){
        // refer to appdelegate in order to be abel accessing persistentContainer
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        // create context from persistentContainer -context is mu DB-
        let context = appDelegate.persistentContainer.viewContext
        // get fetch request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do{
            let test = try context.fetch(fetchRequest)
            let objectToDel = test[indexP] as! NSManagedObject
            context.delete(objectToDel)
            try context.save()
            
        }catch{
            print("======Error Delete function========")
        }
    }*/
}
