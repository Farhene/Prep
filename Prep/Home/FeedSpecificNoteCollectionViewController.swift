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
    private var categoryList = [Categ]()
    private var notesList = [Note]()
    var noteNSSet = NSSet()
    
    var targetCategory = String()


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTheme()
        
        title = "Prep Notes From Sample"
        print(targetCategory)
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
        
        //should be the notes from that same category
        cell.noteFromCategoryCell?.text = note.body
        
        cell.noteFromCategoryCell?.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        
        return cell
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
            
            print("Notes count from here: ", notesList.count)
            print("Notes are: ", notesList)
        }
        catch{
            print("Error!")
        }
    }
}
