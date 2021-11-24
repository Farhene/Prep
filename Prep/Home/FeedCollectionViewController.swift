//
//  FeedCollectionViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/3/21.
//


// -------------- HELP!! CORE DATA PROBLEMS

import UIKit
import Foundation


private let reuseIdentifier = "FeedCollectionViewCell"

class FeedCollectionViewController: UICollectionViewController {
    
    //helps to deal with objects in the CoreData database
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //global variable of all items to fetch from the entity from CoreData
    private var categories = [Category]()
    
    let defaults = UserDefaults.standard

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTheme()
            
        title = "Prep Categories"
        getAllCategories()

        collectionView.delegate = self
        collectionView.dataSource = self
            
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                    
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
                    
        let width = (view.frame.size.width - layout.minimumInteritemSpacing*2) / 3
        layout.itemSize = CGSize(width: width, height: width*1)
    
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToSettings" {
            let settingsVC = segue.destination as! SettingsViewController
            settingsVC.input = "In settings now"
        }
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
        // #warning Incomplete implementation, return the number of items
        return categories.count
    }

    
    
    //---------------------------------             HELP!!!!!!!!!!!
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categories[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCollectionViewCell
        
        //Professor, I am not sure why it does not recognize the category attribute her!!
        //cell.categoryFeedCell?.text = category.category

        
        cell.categoryFeedCell?.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
       
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            cell.layer.cornerRadius = 20
            cell.clipsToBounds = true
        }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let targetCategory = categories[indexPath.row]
        //print("Note chosen: ", targetCategory.category)
        
        
        // I will change to make the sheet ONLY appear when user does LONG press gesture
        // So you can ignore these lines 110-118
//        let sheet = UIAlertController(title: "Test \(targetCategory.category)",
//                                      message: "View or Delete?",
//                                      preferredStyle: .actionSheet)
//        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
//            self?.deleteNote(category: targetCategory)
//        }))
//        sheet.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil ))
//
//        present(sheet, animated: true)
    }
    
    
    
    
    //---------------------------- Manipulating Categories here
    
    //---------------------------------             HELP!!!!!!!!!!!

    func getAllCategories() {
        do {
           // categories = try context.fetch(Category.fetchRequest())
            self.collectionView.reloadData()
        }
        catch{
            //error
            print("Error!")
        }
    }
    
    //---------------------------------             HELP!!!!!!!!!!!

    
    func deleteNote(category: Category){
        
        //context.delete(category)
        
        do {
            try context.save()
            self.collectionView.reloadData()
        }
        catch {
            print("deleted!")
        }
    }

    
    
    //Professor you can ignore this segue function - will figure out after Core Data issue is resolved.
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        //Task 1 - find selected note
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let category = categories[indexPath.row]
        
//        if(identifier == "goToSpecificNotes"){
//            let detailNotesListVC = segue.destination as! FeedSpecificNoteCollectionViewController
//            detailNotesListVC.notes = category.notes
//        }
        
                        //through category I should be able to grab ALL notes related to that categroy through relationship
                
                        //while transitioning, this disables the highlighted feature of each cell that was selected
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
