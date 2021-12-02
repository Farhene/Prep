//
//  CalendarViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/3/21.
//

// Note: I followed Youtube tutorials on how to implement and use FSCalendar for most of this file.
// The following functions pertaining to calendar, I learned from the videos

import UIKit
import FSCalendar

protocol CalendarViewControllerDelegate {
    func eventDateClicked(_ string: String)
    
    func didDeleteEvent(_ note: Note)
}


class CalendarViewController: UIViewController, FSCalendarDelegate {
    
    var delegate : CalendarViewControllerDelegate?
    
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet var calendar: FSCalendar!
    
    private var allNotes = [Note]()
    private var datedNotes = [Note]()
    var eventDates = [String]()

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
        //only call delegate if event is clicked
        //code needed here
        delegate?.eventDateClicked(dateChosenString)
        
        //here I plan to get the dated notes below calendar perhaps hmmmm
        getSpecificNote(string: dateChosenString)
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-YYYY"
        let dateString = formatter.string(from: date)
        
        print("eventDates: ", eventDates)

        
        if self.eventDates.contains(dateString){
            print("true!")
            return 1
        }
        return 0
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
        
        //now add to string of dates
        let formatter = DateFormatter()

    
        for j in datedNotes {
            formatter.dateFormat = "MM-dd-YYYY"
            eventDates.append(formatter.string(from: j.startDate!))
        }
    }
    
    
    func getSpecificNote(string: String){
        print("date is: ", string)

    }
    
    func deleteNote(note: Note){
        
        context.delete(note)
        
        do {
            try context.save()
            delegate?.didDeleteEvent(note)
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

extension CalendarViewController: CalendarViewControllerDelegate {
    func eventDateClicked(_ string: String){
        print("You clicked on the following date with one or more events!")
    }
    
    func didDeleteEvent(_ note: Note) {
        print("You deleted \(note.body ?? "nil")!")
    }
}
