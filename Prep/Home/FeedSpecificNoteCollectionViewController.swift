//
//  FeedSpecificNoteCollectionViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/22/21.
//

import UIKit

private let reuseIdentifier = "FeedSpecificNoteCollectionViewCell"

class FeedSpecificNoteCollectionViewController: UICollectionViewController {

    let defaults = UserDefaults.standard
    private var notesList = [Categ]()


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTheme()
        
        title = "Prep Notes From Sample"
        //getAllNotes()

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
            print("light view")
            collectionView.backgroundColor = UIColor.lightestTeal
        }
        else if(mode == "dark"){
            // Apply your dark theme.
            print("dark view")
            collectionView.backgroundColor = UIColor.darkestTeal
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return notesList.notes.count
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        let note = notesList[indexPath.row]
        
        //cell.noteFromCategoryCell?.text = notesList.body
        
        return cell
    }
}
