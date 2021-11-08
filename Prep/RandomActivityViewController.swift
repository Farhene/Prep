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
    
    @IBAction func onRandomButton(_ sender: Any) {
        //make an API call here to suggest a random activity to do
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
