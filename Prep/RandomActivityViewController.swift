//
//  RandomActivityViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/3/21.
//

import UIKit


class RandomActivityViewController: UIViewController {
    
    var activity = String() //() indicates it is a creation of something

    //Function makes button circular and orange and black "?"
    @IBOutlet weak var randomButton: UIButton!{
        didSet{
            //this line borrowed from stackOverflow to make button circular
            randomButton.layer.cornerRadius = 0.5 * randomButton.bounds.size.width
            randomButton.backgroundColor = UIColor.orange
            
            randomButton.titleLabel?.font = UIFont.systemFont(ofSize: 100)
            randomButton.titleLabel?.textColor = UIColor.black
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
