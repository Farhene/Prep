//
//  CalendarViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/3/21.
//

// -------------- I DID NOT IMPLEMENT THIS YET

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
            let undatedNotesVC = segue.destination as! UndatedNotesTableViewController
            undatedNotesVC.input = "In undated now"
        }
    }
    

}
