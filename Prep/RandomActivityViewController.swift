//
//  RandomActivityViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/3/21.
//

import UIKit


class RandomActivityViewController: UIViewController {
    
    var activity = String() //() indicates it is a creation of something
    @IBOutlet weak var randomActivityLabel: UILabel!
    @IBOutlet weak var addToCalendarQuestionLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!{
        didSet{
            yesButton.layer.cornerRadius = 0.5
            yesButton.backgroundColor = #colorLiteral(red: 0, green: 0.5091355443, blue: 0.3028217256, alpha: 1)
            yesButton.setTitleColor(.white, for: .normal)
            yesButton.setTitle("Yes", for: .normal)
            yesButton.layer.opacity = 0.0
        }
    }
    @IBOutlet weak var noButton: UIButton!{
        didSet{
            noButton.layer.cornerRadius = 0.5
            noButton.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
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
            randomButton.backgroundColor = UIColor.orange
            
            randomButton.titleLabel?.font = UIFont.systemFont(ofSize: 80)
            randomButton.setTitle("?", for: .normal)
            randomButton.setTitleColor(.black, for: .normal)

            
        }
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
                let dataArray = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
