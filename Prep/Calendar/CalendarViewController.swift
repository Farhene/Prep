//
//  CalendarViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/3/21.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate {
    
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet var calendar: FSCalendar!
    
    private var allNotes = [Note]()
    private var datedNotes = [Note]()

    let defaults = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateTheme()
        getDatedNotes()
                
        calendar.delegate = self
    }
    
    func updateTheme(){
        let mode = (defaults.string(forKey: "theme") ?? "no color") as String

        if (mode == "light") {
            view.backgroundColor = UIColor.lightestTeal
            calendarView.backgroundColor = UIColor.lightTeal
            
        }
        else if(mode == "dark"){
            view.backgroundColor = UIColor.darkestTeal
            calendarView.backgroundColor = UIColor.darkTeal
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-YYYY"
        let dateChosenString = formatter.string(from: date)
        //print("\(dateChosenString)")
        
        //here I plan to get the dated notes below calendar perhaps hmmmm
        getSpecificNote(string: dateChosenString)
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
    
    //---------------------------- Manipulating Notes here
            
    func getDatedNotes() {
        var components = DateComponents()
        components.month = 1
        components.day = 1
        components.year = 2000
        components.hour = 1
        
        let date =  Calendar.current.date(from: components)
        do {
            allNotes = try context.fetch(Note.fetchRequest())
            // filter out undated notes
            for i in allNotes {
                if(i.startDate != date){
                    datedNotes.append(i)
                }
            }
        }
        catch {
            print("couldn't load the notes from Note")
        }
    }
    
    
    func getSpecificNote(string: String){
        print("date is: ", string)

    }
    
    func deleteNote(note: Note){
        
        context.delete(note)
        
        do {
            try context.save()
        }
        catch {
            print("error!")
        }
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToUndatedNotes" {
            let undatedNotesVC = segue.destination as! UndatedNotesTableViewController
            undatedNotesVC.input = "In undated now"
        }
    }
    

}
