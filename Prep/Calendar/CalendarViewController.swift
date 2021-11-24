//
//  CalendarViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/3/21.
//

// -------------- I DID NOT IMPLEMENT THIS YET

import UIKit



class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarView: UIView!
    //@IBOutlet weak var calendar: FSCalendar!
    let defaults = UserDefaults.standard
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateTheme()
    }
    
    func updateTheme(){
        let mode = (defaults.string(forKey: "theme") ?? "no color") as String

        if (mode == "light") {
            // Apply your light theme
            print("light view")
            view.backgroundColor = UIColor.lightestTeal
            calendarView.backgroundColor = UIColor.lightTeal
            
        }
        else if(mode == "dark"){
            // Apply your dark theme.
            print("dark view")
            view.backgroundColor = UIColor.darkestTeal
            calendarView.backgroundColor = UIColor.darkTeal
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToUndatedNotes" {
            let undatedNotesVC = segue.destination as! UndatedNotesTableViewController
            undatedNotesVC.input = "In undated now"
        }
    }
    

}
