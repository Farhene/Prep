//
//  AddNoteTViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/15/21.
//

// -------------- HELP!! CORE DATA PROBLEMS 


import UIKit

class AddNoteTViewController: UITableViewController {

    //helps to deal with objects in the CoreData database
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var category = String()
    var notes = String()
    
    @IBOutlet weak var addNoteTitle: UILabel!
    @IBOutlet weak var categTitle: UILabel!
    @IBOutlet weak var categoryLabel: UITextField!
    @IBOutlet weak var notesTitle: UILabel!
    @IBOutlet weak var bodyLabel: UITextView!
    
    @IBOutlet weak var startDateTitle: UILabel!
    @IBOutlet weak var startDateChosen: UIDatePicker!
    @IBOutlet weak var endDateTitle: UILabel!
    @IBOutlet weak var endDateChosen: UIDatePicker!
    
    @IBOutlet weak var skipTimeButton: UIButton!
    @IBOutlet weak var submitTimeButton: UIButton!
    let defaults = UserDefaults.standard

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTheme()
            
        categoryLabel.text = category
        bodyLabel.text = notes
    }
    
    func updateTheme(){
        let mode = (defaults.string(forKey: "theme") ?? "no color") as String

        if (mode == "light") {
            // Apply your light theme
            print("light view")
            tableView.backgroundColor = UIColor.lightestTeal
            
            addNoteTitle.textColor = UIColor.darkestTeal
            
            categTitle.textColor = UIColor.darkestTeal
            categoryLabel.backgroundColor = UIColor.white
            categoryLabel.textColor = UIColor.darkestTeal
            
            notesTitle.textColor = UIColor.darkestTeal
            bodyLabel.backgroundColor = UIColor.white
            bodyLabel.textColor = UIColor.darkestTeal
            
            startDateTitle.textColor = UIColor.darkestTeal

            endDateTitle.textColor = UIColor.darkestTeal
            
            skipTimeButton.setTitleColor(UIColor.white, for: .normal)
            skipTimeButton.backgroundColor = UIColor.darkRed

            submitTimeButton.setTitleColor(UIColor.darkestTeal, for: .normal)
            submitTimeButton.backgroundColor = UIColor.lightTeal

        }
        else if(mode == "dark"){
            // Apply your dark theme.
            print("dark view")
            tableView.backgroundColor = UIColor.darkestTeal

            addNoteTitle.textColor = UIColor.lightestTeal
            
            categTitle.textColor = UIColor.lightestTeal
            categoryLabel.backgroundColor = UIColor.dullMint
            categoryLabel.textColor = UIColor.darkestTeal
            
            notesTitle.textColor = UIColor.lightestTeal
            bodyLabel.backgroundColor = UIColor.dullMint
            bodyLabel.textColor = UIColor.darkestTeal
            
            startDateTitle.textColor = UIColor.lightestTeal
            
            endDateTitle.textColor = UIColor.lightestTeal
            
            skipTimeButton.setTitleColor(UIColor.waluigi, for: .normal)
            skipTimeButton.backgroundColor = UIColor.coral
            
            submitTimeButton.setTitleColor(UIColor.darkestTeal, for: .normal)
            submitTimeButton.backgroundColor = UIColor.lightestTeal
        }
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
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
    //---------------------------------             HELP!!!!!!!!!!!
    // it doesn't recognize Note here as well ;(
    func createNoteNoDate(category: String, body: String){
        let newItem = Note(context: context)
        newItem.body = body
        newItem.category?.category = category

        do {
            try context.save()
            do {
                try context.fetch(Note.fetchRequest())
            }
            catch{
                //error
                print("Error!")
            }
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
    //---------------------------------             HELP!!!!!!!!!!!
    // again it does not recognize note!
    func createNotewithDate(category: String, body: String, startDate: Date, endDate: Date){
        let newItem = Note(context: context)
        newItem.body = body
        newItem.startDate = startDate
        newItem.endDate = endDate

        // Professor, here I tried to access the category attribute of the Category entity through Note's category relationship to the cateogory in Category data model.
        newItem.category?.category = category

        do {
            try context.save()
            do {
                try context.fetch(Note.fetchRequest())
            }
            catch{
                //error
                print("Error!")
            }
        }
        catch{
            print("Error: ")
        }
    }
}
