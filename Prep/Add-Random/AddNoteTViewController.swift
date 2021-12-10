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
    private var categList = [Categ]()
    
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
        
        //Create Note
        let newItem = Note(context: context)
        newItem.body = body
        newItem.id = UUID()
        
        //Check if category exists, if it does, it will insert newItem and return true
        let categExists = checkIFCategoryExists(category: category, note: newItem)
        
        if(categExists == false){
            //Create Category
            let newCateg = Categ(context: context)
            newCateg.category = category
            
            //add Note to Category
            newCateg.addToNotes(newItem)
        }

        print("no date item: ",newItem)

        do {
            try context.save()
            do {
                try context.fetch(Note.fetchRequest())
            }
            catch{
                print("Inner Error!")
            }
        }
        catch{
            print("Outer Error: ", error)
        }
    }

    
    // ---------------------------------- Submitting WITH Date --------------------------------
    @IBAction func submitButton(_ sender: Any) {
        if(self.categoryLabel.text != "" && self.bodyLabel.text != "" && startDateChosen.date <= endDateChosen.date){
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
        else if(startDateChosen.date > endDateChosen.date){
            let alert = UIAlertController(title: "Cannot Save!", message: "Start date cannot be after End date!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
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
        
        //Create Note
        let newItem = Note(context: context)
        newItem.body = body
        newItem.startDate = startDate
        newItem.endDate = endDate
        newItem.id = UUID()
        
        //Check if category exists, if it does, it will insert newItem and return true
        let categExists = checkIFCategoryExists(category: category, note: newItem)
        
        if(categExists == false){
            //Create Category
            let newCateg = Categ(context: context)
            newCateg.category = category
            
            //add Note to Category
            newCateg.addToNotes(newItem)
        }
        
        print("date item: ", newItem)
        //try! context.save()
        do {
            try context.save()
            do {
                try context.fetch(Note.fetchRequest())
            }
            catch{
                print("Inner Error!")
            }
        }
        catch{
            print("Outer Error: ")
        }
    }
    
    func checkIFCategoryExists(category: String, note: Note) -> Bool {
        do {
            categList = try context.fetch(Categ.fetchRequest())
            for i in categList {
                if i.category == category {
                    i.addToNotes(note) //add relationship here!
                    return true
                }
            }
        }
        catch{
            print("Error!")
        }
        return false
    }
}
