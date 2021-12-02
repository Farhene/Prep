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
    
    let defaults = UserDefaults.standard
    
    private var notes = [Note]()
    private var allNotes = [Note]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateTheme()


        title = "Undated Prep Notes"
        getAllUndatedNotes()
        tableView.delegate = self
        tableView.dataSource = self
            
        print("From Calender to ", input)
    }
    
    func updateTheme(){
        let mode = (defaults.string(forKey: "theme") ?? "no color") as String

        if (mode == "light") {
            tableView.backgroundColor = UIColor.lightestTeal
        }
        else if(mode == "dark"){
            tableView.backgroundColor = UIColor.darkestTeal
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let note = notes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UndatedNotesCell", for: indexPath) as! UndatedNotesTableViewCell
    
        // Configure the cell...
        //Using Extension of UIcolor here!
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.darkTeal
            cell.bodyNotes?.textColor = UIColor.lightTeal
        } else {
            cell.backgroundColor = UIColor.lightTeal
            cell.bodyNotes?.textColor = UIColor.darkTeal
        }
        
        cell.bodyNotes?.text = note.body
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let targetNote = notes[indexPath.row]
        
        let sheet = UIAlertController(title: "Complete?",
                                      message: "Delete or Keep: ' \(targetNote.body ?? "nil")' ?",
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
            allNotes = try context.fetch(Note.fetchRequest())
            print("Total notes: ", allNotes)
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
    
    func deleteNote(note: Note){
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
