//
//  RepresentativeViewController.swift
//  Civica
//
//  Created by OSL on 4/1/22.
//

import UIKit
import AlamofireImage

class RepresentativeViewController: UIViewController {
   
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        }
        
        func configure() {
            RepService.shared.fetchReps() { [weak self]
                detail in
                self?.nameLabel.text = detail?.name
            }
        }
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


