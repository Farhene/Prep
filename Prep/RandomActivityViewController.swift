//
//  RandomActivityViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/3/21.
//

import UIKit


class RandomActivityViewController: UIViewController {

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

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        //add the parameters here as needed
        let parameters = ["activity":"Draw and color a Mandala"]

        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
        //the service response is here
            print(response)
        })

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
