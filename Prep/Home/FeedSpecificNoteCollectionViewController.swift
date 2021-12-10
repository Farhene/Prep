//
//  FeedSpecificNoteCollectionViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/22/21.
//

import UIKit

class FeedSpecificNoteCollectionViewController: UICollectionViewController {

    //helps to deal with objects in the CoreData database
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let defaults = UserDefaults.standard
    
    let formatter = DateFormatter()
    var components = DateComponents()

    private var categoryList = [Categ]()
    private var notesList = [Note]()
    var noteNSSet = NSSet()
    
    var targetCategory = String()


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTheme()
        
        title = "Prep Notes From Sample"
        print("Target category chosen is: ", targetCategory)
        getNotesFromCategory(targetCateg: targetCategory)

        collectionView.delegate = self
        collectionView.dataSource = self
            
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                    
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
                    
        let width = (view.frame.size.width - layout.minimumInteritemSpacing*2) / 3
        layout.itemSize = CGSize(width: width, height: width*1)
    }
    
    func updateTheme(){
        let mode = (defaults.string(forKey: "theme") ?? "no color") as String

        if (mode == "light") {
            // Apply your light theme
            collectionView.backgroundColor = UIColor.lightestTeal
        }
        else if(mode == "dark"){
            // Apply your dark theme.
            collectionView.backgroundColor = UIColor.darkestTeal
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notesList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedSpecificNoteCollectionViewCell", for: indexPath) as! FeedSpecificNoteCollectionViewCell
    
        let note = notesList[indexPath.row]
        
        //setting the date style for the cells
        formatter.dateFormat = "MM-dd-YYYY"
        if(note.startDate != nil){
            let dateStart = formatter.string(from: note.startDate!)
            let dateEnd = formatter.string(from: note.endDate!)
        
            components.month = 1
            components.day = 1
            components.year = 2000
            components.hour = 1
            let noDate =  Calendar.current.date(from: components)
            
            //configuring cell's body and date labels
            cell.noteFromCategoryCell?.text = note.body

            if(dateStart != dateEnd && note.startDate != noDate) {
                cell.date?.text = "\(dateStart) - \(dateEnd)"
            }
            else if(dateStart == dateEnd && note.startDate != noDate){
                cell.date?.text = "\(dateEnd)"
            }
            else{
                cell.date?.text = "--"
            }
        }
        
        let mode = (defaults.string(forKey: "theme") ?? "no color") as String

        if (mode == "light") {
            cell.date?.textColor = UIColor.darkestTeal
        }
        else if(mode == "dark"){
            cell.date?.textColor = UIColor.lightestTeal
        }
        
        cell.noteFromCategoryCell?.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let targetNote = notesList[indexPath.row]
        
        let sheet = UIAlertController(title: "\(targetNote.body ?? "nil")",
                                      message: "Delete this note?",
                                      preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        sheet.addAction(UIAlertAction(title: "Delete Note", style: .destructive, handler: { [weak self] _ in
                self?.deleteNote(note: targetNote)
            }))
        
        present(sheet, animated: true)
    }
        
    func getNotesFromCategory(targetCateg: String){
        do {
            categoryList = try context.fetch(Categ.fetchRequest())
            for i in categoryList {
                if(i.category == targetCategory){
                    //I need to get the notes from here!
                    noteNSSet = i.notes!
                    break;
                }
            }
            //convert NSSet to Array
            notesList = noteNSSet.toArray()
            self.collectionView.reloadData()
        }
        catch{
            print("Error!")
        }
    }
    
    func deleteNote(note: Note){
        
        context.delete(note)

        do {
            try context.save()
            self.collectionView.reloadData()
        }
        catch {
            print("deleted!")
        }
    }
}
