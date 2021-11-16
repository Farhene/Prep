//
//  AddNoteTViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/15/21.
//

import UIKit

class AddNoteTViewController: UITableViewController {

    //helps to deal with objects in the CoreData database
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var category = String()
    var notes = String()
    
    @IBOutlet weak var categoryLabel: UITextField!
    @IBOutlet weak var bodyLabel: UITextView!
    
    @IBOutlet weak var startDateChosen: UIDatePicker!
    @IBOutlet weak var endDateChosen: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        categoryLabel.text = category
        bodyLabel.text = notes
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
    @IBAction func skipTimeOption(_ sender: Any) {
        if(self.categoryLabel.text != "" && self.bodyLabel.text != ""){
            //submits non-dated notes
            createNoteNoDate(category: categoryLabel.text!, body: bodyLabel.text!)
            //self.performSegue(withIdentifier: "addNoDate", sender: sender)
            let alert = UIAlertController(title: "Skip Time?", message: "You cannot undo this action", preferredStyle: .actionSheet)

            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                print("Note saved!")
                self.categoryLabel.text = ""
                self.bodyLabel.text = ""
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

            self.present(alert, animated: true)
        }
        else{
            let alert = UIAlertController(title: "Cannot Save!", message: "Please fill in both the category label and the notes label!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }

    @IBAction func submitButton(_ sender: Any) {
        if(self.categoryLabel.text != "" && self.bodyLabel.text != ""){
            //submits dated notes
            createNotewithDate(category: categoryLabel.text!, body: bodyLabel.text!, startDate: startDateChosen.date, endDate: endDateChosen.date)
            //self.performSegue(withIdentifier: "addWithDate", sender: sender)
            let alert = UIAlertController(title: "Add Now?", message: "Feel free to edit your note while you have the chance!", preferredStyle: .actionSheet)

            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                print("Note saved!")
                self.categoryLabel.text = ""
                self.bodyLabel.text = ""
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

            self.present(alert, animated: true)
        }
        else{
            let alert = UIAlertController(title: "Cannot Save!", message: "Please fill in both the category label and the notes label!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }

    func createNotewithDate(category: String, body: String, startDate: Date, endDate: Date){
        let newItem = PrepNote(context: context)
        newItem.body = body
        newItem.category = category
        newItem.startDate = startDate
        newItem.endDate = endDate

        do {
            try context.save()
        }
        catch{
            //error
        }
    }

    func createNoteNoDate(category: String, body: String){
        let newItem = PrepNote(context: context)
        newItem.body = body
        newItem.category = category

        do {
            try context.save()
        }
        catch{
            //error
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
