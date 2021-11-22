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
        
        categoryLabel.text = category
        bodyLabel.text = notes
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
    
    // ---------------------------- Submitting WITHOUT Date --------------------------------
    
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
    
    //function uses Core Data
    func createNoteNoDate(category: String, body: String){
        let newItem = PrepNote(context: context)
        newItem.body = body
        newItem.category = category

        do {
            try context.save()
        }
        catch{
            print("Error: ")
        }
    }

    
    // ---------------------------------- Submitting WITH Date --------------------------------
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

    //function uses Core Data
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
            print("Error: ")
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
}
