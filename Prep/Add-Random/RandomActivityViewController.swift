//
//  RandomActivityViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/3/21.
//

// -------------- This is FINISHED


import UIKit


class RandomActivityViewController: UIViewController {
    
    var activity = String() //() indicates it is a creation of something
    @IBOutlet weak var randomActivityLabel: UILabel!
    @IBOutlet weak var addToCalendarQuestionLabel: UILabel!
    @IBOutlet weak var activityTitle: UILabel!
    @IBOutlet weak var yesButton: UIButton!{
        didSet{
            yesButton.layer.cornerRadius = 0.5
            yesButton.backgroundColor = UIColor.darkestTeal
            yesButton.setTitleColor(.white, for: .normal)
            yesButton.setTitle("Yes", for: .normal)
            yesButton.layer.opacity = 0.0
        }
    }
    @IBOutlet weak var noButton: UIButton!{
        didSet{
            noButton.layer.cornerRadius = 0.5
            noButton.backgroundColor = UIColor.bloodRed
            noButton.setTitleColor(.white, for: .normal)
            noButton.setTitle("No", for: .normal)
            noButton.layer.opacity = 0.0

        }
    }
    
    //Function makes button circular and orange and black "?"
    @IBOutlet weak var randomButton: UIButton!{
        didSet{
            //this line borrowed from stackOverflow to make button circular
            randomButton.layer.cornerRadius = 0.5 * randomButton.bounds.size.width
            randomButton.backgroundColor = UIColor.coral
            
            randomButton.titleLabel?.font = UIFont.systemFont(ofSize: 80)
            randomButton.setTitle("?", for: .normal)
            randomButton.setTitleColor(.black, for: .normal)
        }
    }
    
    @IBAction func onNoButton(_ sender: Any) {
        UIView.animate(withDuration: 1,
                               delay: 0,
                               options: [.allowUserInteraction, .curveEaseOut],
                               animations: {
                                self.addToCalendarQuestionLabel.layer.opacity = 0.0
                                self.yesButton.layer.opacity = 0.0
                                self.noButton.layer.opacity = 0.0
                               })
    }
    
    //borrowed code from Stack Overflow on how to make REST API call and made some tweaks 
    @IBAction func onRandomButton(_ sender: Any) {
        //make an API call here to suggest a random activity to do
        let url = URL(string: "http://www.boredapi.com/api/activity")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            }
            else if let data = data {
                let dataArray = try! JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as! [String: Any]
                
                for(key, value) in dataArray {
                    if(key == "activity")
                    {
                        self.activity = value as! String
                    }
                }
            
                print(self.activity)
                //animate
                UIView.animate(withDuration: 1,
                                       delay: 0,
                                       options: [.allowUserInteraction, .curveEaseIn],
                                       animations: {
                                        self.randomActivityLabel.layer.opacity = 0.0
                                        self.addToCalendarQuestionLabel.layer.opacity = 0.0
                                        self.randomActivityLabel.text = "\(self.activity)"
                                        self.randomActivityLabel.layer.opacity = 1.0
                                        self.addToCalendarQuestionLabel.text = "Add to Calendar?"
                                        self.addToCalendarQuestionLabel.layer.opacity = 1.0
                                        self.yesButton.layer.opacity = 1.0
                                        self.noButton.layer.opacity = 1.0
                                       })
                //show buttons of adding to calendar or not here!
                }
            }
        task.resume()
    }
    @IBAction func onYesButton(_ sender: Any) {
        //here I should segue to the AddNoteViewController and also send over the current "\(self.activity)" message to the Note
        //Category would be put as Random Activity
        //self.performSegue(withIdentifier: "AddToCalendar", sender: sender)
        UIView.animate(withDuration: 1,
                               delay: 0,
                               options: [.allowUserInteraction, .curveEaseOut],
                               animations: {
                                self.addToCalendarQuestionLabel.layer.opacity = 0.0
                                self.yesButton.layer.opacity = 0.0
                                self.noButton.layer.opacity = 0.0
                               })
    }
    
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
            randomButton.backgroundColor = UIColor.lightOrange
            
            randomActivityLabel.textColor = UIColor.deepGreen
            randomActivityLabel.backgroundColor = UIColor.lightestTeal
            
            activityTitle.textColor = UIColor.waluigi
            activityTitle.backgroundColor = UIColor.lightestTeal
            
            yesButton.backgroundColor = UIColor.darkTeal
            yesButton.setTitleColor(UIColor.white, for: .normal)

            addToCalendarQuestionLabel.textColor = UIColor.waluigi
        }
        else if(mode == "dark"){
            // Apply your dark theme.
            print("dark view")
            view.backgroundColor = UIColor.darkestTeal
            randomButton.backgroundColor = UIColor.dullPink
            
            randomActivityLabel.textColor = UIColor.lightestTeal
            randomActivityLabel.backgroundColor = UIColor.darkestTeal

            activityTitle.textColor = UIColor.lightOrange
            activityTitle.backgroundColor = UIColor.darkestTeal

            
            yesButton.backgroundColor = UIColor.lightTeal
            yesButton.setTitleColor(UIColor.darkestTeal, for: .normal)
            
            addToCalendarQuestionLabel.textColor = UIColor.lightOrange
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        if segue.identifier == "AddToCalendar" {
            let addNoteViewController = segue.destination as! AddNoteTViewController
            addNoteViewController.notes = self.activity
            addNoteViewController.category = "Random Activity"
        }

    }
    

}
