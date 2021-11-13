//
//  AddNoteViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/3/21.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    //helps to deal with objects in the CoreData database
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var category = String()
    var notes = String()
    
    @IBOutlet weak var categoryLabel: UITextField!
    @IBOutlet weak var bodyLabel: UITextView!
    
    @IBOutlet weak var startDateChosen: UIDatePicker!
    @IBOutlet weak var endDateChosen: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categoryLabel.text = category
        bodyLabel.text = notes
        
    }

    @IBAction func skipTimeOption(_ sender: Any) {
        //submits non-dated notes
        createNoteNoDate(category: categoryLabel.text!, body: bodyLabel.text!)
    }

    @IBAction func submitButton(_ sender: Any) {
        //submits dated notes
        createNotewithDate(category: categoryLabel.text!, body: bodyLabel.text!, startDate: startDateChosen.date, endDate: endDateChosen.date)
    }

    func createNotewithDate(category: String, body: String, startDate: Date, endDate: Date){
        let newItem = PrepNote(context: context)
        newItem.body = body
        newItem.category = category
        newItem.startDate = startDate
        newItem.endDate = endDate

        do {
            try context.save()
        }
        catch{
            //error
        }
    }

    func createNoteNoDate(category: String, body: String){
        let newItem = PrepNote(context: context)
        newItem.body = body
        newItem.category = category

        do {
            try context.save()
        }
        catch{
            //error
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
