
//  Created by user234887 on 10/16/23.
//
import UIKit

class TableViewController: UITableViewController {

    var tasks: [String] = []
    override func viewDidLoad() 	{
        self.tableView.allowsMultipleSelectionDuringEditing = false
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isEditing = true
        if let savedTasks = UserDefaults.standard.stringArray(forKey: "ToDoTaskKey"){
            tasks = savedTasks
        }
        
    }
    func saveTask(){
        UserDefaults.standard.set(tasks, forKey: "ToDoTaskKey")
    }
    
    
    
    @IBAction func newItem(_ sender: Any) {
        let alert = UIAlertController(title: "welcome", message: "Enter Task name",
                                      preferredStyle: .alert)
        alert.addTextField{
            fields in fields.placeholder = "Task Name"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: nil))
        alert.addAction(UIAlertAction(title: "Continue", style: .default,handler: { _ in
            guard let field = alert.textFields else {return}
            let textField = field[0]
            if let item = textField.text{
                //self.myArrayList.insert(item, at:0)
                self.tasks.append(item)
                self.tableview.reloadData()
                self.saveTask()
            }
        }
            ))
            present(alert, animated: true,completion: nil)
    }
    
    
    
    
    @IBOutlet var tableview: UITableView!
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rows", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]


        return cell
    }
    

    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       
        return true
    }
    	

    
    //Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete){
            tasks.remove(at: indexPath.row)
            // Delete the row from the data source
            tableview.deleteRows(at: [indexPath], with: .fade)
            saveTask()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        tasks.swapAt(fromIndexPath.row, to.row)
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
