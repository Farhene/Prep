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

// Worker
// listens on the datedcollectionview delegates and responds accordingly.
// if it hears that dated collection controller (deleted or added event), reflect that change in the calendar collection
// don't trust the datedcollection view on the change only, still depend on the CoreData to check change
// calendar view controller owns it


protocol CalendarViewControllerDelegate {
    func dateClicked(_ string: String)
    
    func didDeleteEvent(_ note: Note)
    
    func checkChangesOnNote(_ note: Note)
}


class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    var delegate : CalendarViewControllerDelegate?
    
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet var calendar: FSCalendar!
    let formatter = DateFormatter()
    
    private var allNotes = [Note]()
    private var datedNotes = [Note]()
    var eventDates = [String]()

    let defaults = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateTheme()
        getDatedNotes()
    
        calendar.dataSource = self
        calendar.delegate = self
        calendar.scrollDirection = .vertical
        calendar.allowsMultipleSelection = false
    }
    
    func updateTheme(){
        let mode = (defaults.string(forKey: "theme") ?? "no color") as String

        if (mode == "light") {
            view.backgroundColor = UIColor.lightestTeal
            calendarView.backgroundColor = UIColor.lightTeal
            calendar.appearance.headerTitleColor = UIColor.darkestTeal
            calendar.appearance.selectionColor = UIColor.dullPink
            calendar.appearance.todayColor = UIColor.medTeal
        }
        else if(mode == "dark"){
            view.backgroundColor = UIColor.darkestTeal
            calendarView.backgroundColor = UIColor.darkTeal
            calendar.appearance.headerTitleColor = UIColor.lightestTeal
            calendar.appearance.selectionColor = UIColor.lightLavender
            calendar.appearance.todayColor = UIColor.dullMint
        }
    }
    
    //---------------------------- Manipulating Calendar here

    
    //user cannot scroll to previous months
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "yyyy-MM-dd"
        let dateChosenString = formatter.string(from: date)
        print("\(dateChosenString)")

        //delegate protocol method used here
        delegate?.dateClicked(dateChosenString)
        
        var datedGo = false
        
        for i in eventDates{
            if(i == dateChosenString){
                datedGo = true
                break
            }
        }
        
        if(datedGo){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "goToDatedNotes") as! DatedCollectionViewController
            let navBarOnModal: UINavigationController = UINavigationController(rootViewController: vc)
            vc.date = date
            self.present(navBarOnModal, animated: true, completion: nil)
        }
        
    }
    
    //borrowed from https://www.youtube.com/watch?v=FipNDF7g9tE in order to mimic event numbers!
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        formatter.dateFormat = "yyyy-MM-dd"
        for i in eventDates{
            guard let eventData = formatter.date(from: i) else {return nil}
                if date.compare(eventData) == .orderedSame {
                    return .red
                }
        }
        return nil
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
                if(i.startDate != date && i.startDate != nil){
                    datedNotes.append(i)
                }
            }
            self.calendar.reloadData()
        }
        catch {
            print("couldn't load the notes from Note")
        }
        
        //now add to string of dates
        let formatter = DateFormatter()

    
        for j in datedNotes {
            formatter.dateFormat = "yyyy-MM-dd"
            eventDates.append(formatter.string(from: j.startDate!))
        }
        
        print("eventDates: ", eventDates)
    }
    
    func deleteNote(note: Note){
        
        context.delete(note)
        
        do {
            try context.save()
            self.calendar.reloadData()
            delegate?.didDeleteEvent(note)
        }
        catch {
            print("error!")
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToUndatedNotes" {
            let undatedNotesVC = segue.destination as! UndatedNotesTableViewController
            undatedNotesVC.input = "In undated now"
        }
    }
}

extension CalendarViewController: CalendarViewControllerDelegate {
    func dateClicked(_ string: String){
        print("You clicked on the following date with one or more events!")
    }
    
    func didDeleteEvent(_ note: Note) {
        print("You deleted \(note.body ?? "nil")!")
    }
    
    func checkChangesOnNote(_ note: Note){
        print("changes happened")
        //check if event exists in the date, and change the UI color of that date maybe
    }

}
