//
//  UndatedNotesTableViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/16/21.
//

import UIKit

class UndatedNotesTableViewController: UITableViewController {

    var input = String()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private var notes = [PrepNote]()
    private var allNotes = [PrepNote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        title = "Undated Prep Notes"
        getAllUndatedNotes()
        print(notes)
        tableView.delegate = self
        tableView.dataSource = self
                    
        
        print(input)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let note = notes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UndatedNotesCell", for: indexPath) as! UndatedNotesTableViewCell
    

        // Configure the cell...
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.6111619473, blue: 0.5249490142, alpha: 1)
            cell.bodyNotes?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.5912877917, green: 1, blue: 0.9412642121, alpha: 1)
            cell.bodyNotes?.textColor = #colorLiteral(red: 0, green: 0.3143163919, blue: 0.3069375157, alpha: 1)
        }
        cell.bodyNotes?.text = note.body

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let targetNote = notes[indexPath.row]
        
        let sheet = UIAlertController(title: "Complete?",
                                      message: "Delete or Keep: ' \(targetNote.body)' ?",
                                      preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteNote(note: targetNote)
        }))
        sheet.addAction(UIAlertAction(title: "Keep", style: .default, handler: nil ))
        
        present(sheet, animated: true)
    }
    
    
    
    func getAllUndatedNotes(){
        var components = DateComponents()
        components.month = 1
        components.day = 1
        components.year = 2000
        components.hour = 1
        
        let date =  Calendar.current.date(from: components)
        do {
            allNotes = try context.fetch(PrepNote.fetchRequest())
            // filter out dated notes
            for i in allNotes {
                if(i.startDate == date){
                    notes.append(i)
                }
            }
            self.tableView.reloadData()
        }
        catch {
            print("couldn't load the notes from category")
        }
    }
   
    
    func deleteNote(note: PrepNote){
        context.delete(note)
        
        do {
            try context.save()
            self.tableView.reloadData()
        }
        catch {
            print("deleted!")
        }
    }
}
