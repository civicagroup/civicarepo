//
//  ViewController.swift
//  Civica
//
//  Created by OSL on 4/1/22.
//

import UIKit

class ViewController: UIViewController {

 
    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipField: UITextField!
    @IBOutlet weak var govLevelField: UITextField!
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let RepresentativesTableViewController = segue.destination as! RepresentativesTableViewController
//        
//        if let text = streetField.text{
//    
//            RepresentativesTableViewController.address = text
//        }
//    }
    
    
//    public var completionHandler: ((String?) -> Void)?
    
    
    @IBAction func repsButton(_ sender: Any) {
//        completionHandler?(streetField.text)
//        let vc = RepInfoTableViewCell(nibName: RepInfoTableViewCell, bundle: nil)
//        vc.address = streetField.text

//        navigationController?.pushViewController(vc, animated: true)
        
//        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var goButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.performSegue(withIdentifier: "repsSegue", sender: self)
        goButton.layer.cornerRadius = 5
       
    }


}

