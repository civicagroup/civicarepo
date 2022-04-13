//
//  ViewController.swift
//  Civica
//
//  Created by OSL on 4/1/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var govLevelField: UITextField!
    @IBAction func repsButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        RepService.shared.fetchReps { representatives in
            print("done!")
            print(representatives)
        }
    }


}

