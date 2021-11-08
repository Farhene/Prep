//
//  HomeViewController.swift
//  Prep
//
//  Created by Farhene Sultana on 11/3/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addNoteButton(_ sender: Any) {
        self.navigationController?.pushViewController(homeView, animated: true)
    }
    
    @IBAction func goToFeedButton(_ sender: Any) {
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
