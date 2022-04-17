//
//  ViewController.swift
//  Civica
//
//  Created by OSL on 4/1/22.
//

import UIKit

class ViewController: UIViewController {

 
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var citylabel: UILabel!
    
    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipField: UITextField!
    
    @IBOutlet weak var govLevelField: UITextField!
    
    public var completionHandler: ((String?) -> Void)?
    
    
    @IBAction func repsButton(_ sender: Any) {
        completionHandler?(streetField.text)
//        dismiss(animated: true, completion: nil)
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.performSegue(withIdentifier: "repsSegue", sender: self)
       
    }


}

