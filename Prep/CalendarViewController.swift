//
//  CalendarViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/3/21.
//

import UIKit

class CalendarViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToUndatedNotes" {
            let settingsVC = segue.destination as! UndatedNotesTableViewController
            settingsVC.input = "In undated now"
        }
    }
    

}
