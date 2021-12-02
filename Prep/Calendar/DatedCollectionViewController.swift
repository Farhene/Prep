//
//  DatedCollectionViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 12/2/21.
//

import UIKit

class DatedCollectionViewController: UICollectionViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let defaults = UserDefaults.standard
    
    private var totalNotes = [Note]()
    private var selectedDateNotes = [Note]()
    var date = Date()
    let dateFormatter = DateFormatter()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateTheme()
        print("dated passed in here is: ", date)
        getNotesFromDate(date: date)

        title = "Dated Prep Notes"
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
            collectionView.backgroundColor = UIColor.lightestTeal
        }
        else if(mode == "dark"){
            collectionView.backgroundColor = UIColor.darkestTeal
        }
    }

    /*
    // MARK: - Navigation
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedDateNotes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatedCellCollectionViewCell", for: indexPath) as! DatedCellCollectionViewCell
        let note = selectedDateNotes[indexPath.row]
    
        // Configure the cell
        cell.notesLabel?.text = note.body
        
        cell.notesLabel?.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        
        return cell
    }
    
    func getNotesFromDate(date: Date){
        do {
            totalNotes = try context.fetch(Note.fetchRequest())
            for i in totalNotes {
                //convert to compare month-date-year only
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateChosenString = dateFormatter.string(from: date)
                let dateLoopString = dateFormatter.string(from: i.startDate!)

                if(dateChosenString == dateLoopString){
                    print("found!")
                    selectedDateNotes.append(i)
                }
            }
            self.collectionView.reloadData()
        }
        catch {
            print("couldn't load the notes from Note")
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
