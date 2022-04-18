//
//  ViewController.swift
//  CoredataTwo
//
//  Created by Coditas on 13/04/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items: [Person]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchPeople()
        
        // Do any additional setup after loading the view.
    }
    
    func fetchPeople(){
        do {
            self.items = try context.fetch(Person.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
                }
                    catch{
            
        }
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Person", message: "What is there name?", preferredStyle: .alert)
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Add", style: .default) {
            (action) in
            
            let textfield = alert.textFields![0]
             
            let newPerson = Person(context: self.context)
            newPerson.name = textfield.text
            newPerson.age = 22
            newPerson.gender = "Female"
            
            do {
                self.context.save()
        }
            catch{
                
            }
            self.fetchPeople()
        
        alert.addAction(submitButton)
        self.present(alert, animated: true, completion: nil)
    }
    

}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalCell", for: indexPath)
        
        let person = self.items![indexPath.row]
        cell.textLabel?.text? = person.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = self.items![indexPath.row]
        
        let alert = UIAlertController(title: "Edit Person", message: "Edit name", preferredStyle: .alert)
        alert.addTextField()
        
        let textfield = alert.textFields![0]
        textfield.text = person.name
        
        let saveButton = UIAlertAction(title: "Save", style: .default) {
            (action) in
            let textfield = alert.textFields![0]
            
            person.name = textfield.text
            
            do {try self.context.save()
        }
            catch{
                
            }
            self.fetchPeople()
        
        alert.addAction(saveButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_tableView: UITableView, trailingSwipeActionConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") {
            (action), view, completionHandler) in
            
            let personToRemove = self.items![indexPath.row]
            
            self.context.delete(personToRemove)
            
            do
            {
                try view.context.save()
        }
            catch{
                
            }
            
            self.fetchPeople()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

