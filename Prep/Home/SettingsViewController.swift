//
//  SettingsViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/15/21.
//

import UIKit

//NSNotification center, notifies everybody that something changed.
//if user clicked on changing theme color, then notify that the color has changed, and whoeevr listening on the key can change the color and whatever it needs to do.
//delegating is one to one relationship

// it abstracts responsibilities
// you create custom component, and you want to separate the business logic
//      (logic specific to your app) from your component
// Calendar component had custom logic which makes app set an
//      appointment but we don't want that
// I want calendar component to do something else
// Delegates help us to let us know when we interact with the component,
        // and so if we click on the date, it will call on the delegate
//          saying we called on the date, and we will handle the
//          specifics of their app.

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
