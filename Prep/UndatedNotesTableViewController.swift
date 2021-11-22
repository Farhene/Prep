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
        tableView.estimatedRowHeight = 3
                    
        
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //Task 1 - find selected note
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        //let note = movies[indexPath.row]
                
        // Task 2 - store to next VC
        //let detailNoteVC = segue.destination as! MovieDetailsViewController
        //detailNoteVC.movie = note
                
        //while transitioning, this disables the highlighted feature of each cell that was selected
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
