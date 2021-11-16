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
    @IBOutlet weak var darkModeSlider: UISlider!
    @IBOutlet weak var darkModeButton: UISegmentedControl!
    @IBOutlet weak var darkModeQuestionLabel: UILabel!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let darkModeOn = defaults.bool(forKey: "darkModeOn")
//        print("darkMode is now: ",darkModeOn)
////        darkModeButton.isEnabled = darkModeOn
//
//        if (darkModeOn == true) {
//                // Apply your dark theme
//                self.view.backgroundColor = UIColor.black
//                self.darkModeQuestionLabel.textColor = UIColor.white
//                print("Dark Mode is On!")
//            }
//        else if(darkModeOn == false ){
//                // Apply your normal theme.
//                self.view.backgroundColor = UIColor.white
//                self.darkModeQuestionLabel.textColor = UIColor.black
//                print("Dark Mode is Off!")
//            }
//
//        self.view.layoutIfNeeded()
        print(input)

    }
    
    @IBAction func onSlider(_ sender: Any) {
        print("Value is now: ",darkModeSlider.value);
        if(darkModeSlider.value > 0.5){
            print("selected dark")
            defaults.set(true, forKey: "darkModeOn")
        }
        else if(darkModeSlider.value < 0.5){
            print("selected light")
            defaults.set(false, forKey: "darkModeOn")
        }
        else{
            print("nothing")
        }
    }
    @IBAction func onDarkButton(_ sender: Any) {
        //change all colors to darker blue green color!
        print("The current index is pressed: ",darkModeButton.selectedSegmentIndex)
        if(darkModeButton.selectedSegmentIndex == 1){
            print("selected dark")
            defaults.set(true, forKey: "darkModeOn")
        }
        else if
            (darkModeButton.selectedSegmentIndex == 0){
            print("selected light")
            defaults.set(false, forKey: "darkModeOn")
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
