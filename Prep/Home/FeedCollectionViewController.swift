//
//  FeedCollectionViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/3/21.
//

import UIKit
import Foundation


private let reuseIdentifier = "FeedCollectionViewCell"

class FeedCollectionViewController: UICollectionViewController, UIGestureRecognizerDelegate {
    
    //helps to deal with objects in the CoreData database
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    //global variable of all items to fetch from the entity from CoreData
    private var categories = [Categ]()
    
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToSettings" {
            let settingsVC = segue.destination as! SettingsViewController
            settingsVC.input = "In settings now"
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categories[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCollectionViewCell
        
        cell.categoryFeedCell?.text = category.category

        
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
        
        let sheet = UIAlertController(title: "\(targetCategory.category ?? "nil")",
                                      message: "View or Delete?",
                                      preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "View Category", style: .default, handler: { (action) -> Void in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "goToSpecificNotes") as! FeedSpecificNoteCollectionViewController
                vc.targetCategory = targetCategory.category ?? "nil"
                self.present(vc, animated: true, completion: nil)
            }))
        sheet.addAction(UIAlertAction(title: "Delete Category", style: .destructive, handler: { [weak self] _ in
                self?.deleteNote(category: targetCategory)
            }))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        present(sheet, animated: true)
    }
    
    //---------------------------- Manipulating Categories here
        
    func getAllCategories() {
        do {
            categories = try context.fetch(Categ.fetchRequest())
            self.collectionView.reloadData()
        }
        catch{
            //error
            print("Couldnt load all categories!")
        }
    }
    
    
    func deleteNote(category: Categ){
        
        //deletes its NSSet but not itself
        context.delete(category)
        
        do {
            try context.save()
            self.collectionView.reloadData()
        }
        catch {
            print("Cannot delete category!")
        }
    }

}
