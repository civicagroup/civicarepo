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
    
    
    
    @IBOutlet weak var goButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(zipField.text)
        // Do any additional setup after loading the view.
//        self.performSegue(withIdentifier: "repsSegue", sender: self)
        goButton.layer.cornerRadius = 5
       
    }
    
    // MARK: - Navigation
    
    @IBAction func onSeeMyRep(_ sender: Any) {
        guard zipField.text != "" else {
            displayAlert(withTitle: "Error", message: "Zipcode is required.")
            return
        }
        self.performSegue(withIdentifier: "repsSegue", sender: self)
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // Pass the selected movie to the dettails view controller
        if segue.identifier == "repsSegue" {
            let tabBarViewController = segue.destination as! UITabBarController
            
            let repVCIndex = 0
            if let repNav = tabBarViewController.viewControllers![repVCIndex] as? UINavigationController, let repViewController = repNav.topViewController as? RepresentativesViewController {
                repViewController.rawAddress = "\(zipField.text ?? "00000")"
            } else {
                print("This vc doesn't exist")
            }
            
        }
    }
}

