//
//  CreateEventViewController.swift
//  Civica
//
//  Created by OSL on 4/13/22.
//

import UIKit
import Parse
import AlamofireImage

class CreateEventViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var startTimeField: UITextField!
    @IBOutlet weak var endTimeField: UITextField!
    
    @IBOutlet weak var eventAdddressField: UITextField!
    @IBOutlet weak var eventZipcodeField: UITextField!
    
    @IBOutlet weak var eventNameField: UITextField!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDesc: UITextView!
    
    @IBOutlet weak var createEventButton: UIButton!
    
    var startTime: Date?
    var endTime: Date?
    let eventDescBoxDefaultText = "Event Description"
    
    var imageChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventDesc.delegate = self
        
//        setupAddTargetIsNotEmptyTextFields()
        
        // enter start time
        let startTimePicker = UIDatePicker()
        startTimePicker.datePickerMode = .dateAndTime
        startTimePicker.minuteInterval = 15
        if #available(iOS 13.4, *) {
            startTimePicker.preferredDatePickerStyle = .wheels
        }
        startTimeField.inputView = startTimePicker
        startTimePicker.addTarget(self, action: #selector(self.startTimeChanged(sender:)), for: .editingDidBegin)
        
        // enter end time
        let endTimePicker = UIDatePicker()
        endTimePicker.datePickerMode = .dateAndTime
        endTimePicker.minuteInterval = 15
        if #available(iOS 13.4, *) {
            endTimePicker.preferredDatePickerStyle = .wheels
        }
        endTimeField.inputView = endTimePicker
        endTimePicker.addTarget(self, action: #selector(endTimeChanged(sender:)), for: .editingDidBegin)
        
        eventDesc.text = eventDescBoxDefaultText
        eventDesc.textColor = UIColor.lightGray

    }
    
    
    @objc func startTimeChanged(sender: UIDatePicker) {
        if sender.date >= Date() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy  hh:mm a"
            startTimeField.text = "\(dateFormatter.string(from: sender.date))"
            self.startTime = sender.date
        } else {
            displayAlert(withTitle: "", message: "Start time cannot be in the past.")
        }
        
        
    }
    
    @objc func endTimeChanged(sender: UIDatePicker) {
        // Ensure a start time is entered
        guard let startTime = self.startTime else {
            displayAlert(withTitle: "", message: "Please enter a start time first.")
            return
        }
         // make sure the end time is later than the start time
        if sender.date > startTime {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy  hh:mm a"
            
            endTimeField.text = "\(dateFormatter.string(from: sender.date))"
            endTime = sender.date
        } else {
            displayAlert(withTitle: "Oops", message: "End time needs to be later than start time.")
        }
    }

    // The date picker goes away when user taps else where outside of the text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if !eventDesc.text!.isEmpty && eventDesc.text! == eventDescBoxDefaultText {
            eventDesc.text = ""
            eventDesc.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if eventDesc.text.isEmpty {
            eventDesc.text = eventDescBoxDefaultText
            eventDesc.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func onTapEventImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        eventImage.image = image
        imageChanged = true
        dismiss(animated: true)
    }
    
//    func setupAddTargetIsNotEmptyTextFields() {
//        createEventButton.isHidden = true //hidden okButton
//        eventNameField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
//                                    for: .editingChanged)
//        startTimeField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
//                                    for: .editingChanged)
////        eventDesc.addTarget(self, action: #selector(textFieldsIsNotEmpty),
////                                    for: .editingChanged)
//       }
//
//    @objc func textFieldsIsNotEmpty(sender: UITextField) {
//
//        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
//
//        guard
//          let eventName = eventNameField.text, !eventName.isEmpty,
//          let startTimeStr = startTimeField.text, !startTimeStr.isEmpty
////          let eventDescTxt = eventDesc.text, !eventDescTxt.isEmpty
//          else {
//              self.createEventButton.isHidden = true
//              return
//        }
//        // enable button if all conditions are met
//        createEventButton.isHidden = false
//       }

    @IBAction func onCreate(_ sender: Any) {
        let event = PFObject(className: "Event")
        // PFObject value cannot be nil therefore providing optional value
        event["Author"] = PFUser.current()
        event["Description"] = eventDesc.text ?? ""
        event["StartTime"] = startTime ?? NSNull()
        event["EndTime"] = endTime ?? NSNull()
        event["Address"] = eventAdddressField.text ?? ""
        event["Zipcode"] = eventZipcodeField.text ?? ""
        event["EventName"] = eventNameField.text ?? ""
        
        if imageChanged, let imageData = eventImage.image?.pngData() {
            let imageFile = PFFileObject(name: "Image.png", data: imageData)
            event["Image"] = imageFile
        }
        
        event.saveInBackground { success, error in
            if success {
                print("Event saved!")
//                self.displayAlert(withTitle: "Awesome", message: "Your event is created.")
                self.dismiss(animated: true)
                let main = UIStoryboard(name: "Main", bundle: nil)
                let eventListViewController = main.instantiateViewController(identifier: "EventListViewController")
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let delegate = windowScene.delegate as? SceneDelegate else { return }
                delegate.window?.rootViewController = eventListViewController
            } else {
                print("Error saving event.")
            }
        }
    }
    
//    func displayAlert(withTitle title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Okay", style: .default)
//        alert.addAction(okAction)
//        self.present(alert, animated: true)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
