//
//  SettingsViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/15/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var input = String()
    
    //add context here to have clearNButton delete all notes from CoreData
    @IBOutlet weak var darkModeButton: UISegmentedControl!
    @IBOutlet weak var darkModeQuestionLabel: UILabel!
    
    let defaults = UserDefaults.standard
    let theme = "theme"
    let dark = "dark"
    let light = "light"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTheme()
    }
    
    func updateTheme(){
        let theme =  defaults.string(forKey: theme)
        if(theme == light){
            darkModeButton.selectedSegmentIndex = 0
            view.backgroundColor = UIColor.lightestTeal
            darkModeQuestionLabel.textColor = UIColor.darkestTeal
        }
        else {
            darkModeButton.selectedSegmentIndex = 1
            view.backgroundColor = UIColor.darkestTeal
            darkModeQuestionLabel.textColor = UIColor.lightTeal
        }
    }
    
    @IBAction func onDarkButton(_ sender: Any) {
        //change all colors to darker blue green color!
        switch darkModeButton.selectedSegmentIndex{
        case 0:
            defaults.setValue(light, forKey: theme)
        case 1:
            defaults.setValue(dark, forKey: theme)
        default:
            defaults.setValue(light, forKey: theme)
        }
        updateTheme()
    }
}
