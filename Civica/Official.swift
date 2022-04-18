//
//  Official.swift
//  Civica
//
//  Created by Antonella on 4/18/22.
//

import Foundation
import UIKit

class Official {
    
     let kOfficial = "officials"
     let kName = "name"
     let kAddress = "address"
     let kAddressLine1 = "line1"
     let kAddressCity = "city"
     let kAddressState = "state"
     let kAddressZip = "zip"
     let kPhone = "phones"
     let kParty = "party"
     let kPhoto = "photoUrl"
     let kUrl = "urls"
     let kSocial = "channels"
     let kType = "type"
     let kId = "id"
     let kEmail = "emails"
    
    var name: String?
    var address: Address?
    var party: String?
    var phone: String?
    var photoURL: String?
    var type: String?
    var id: String?
    var url: String?
    var social: [Social]
    var office: Office?
    var email: String?
    var image: UIImage?
    
    init() {
        self.social = []
    }
    
    init?(dictionary: [String: AnyObject], office: Office)  {
        
        // Only Return nil if we can't get Official's name.
        guard let name = dictionary[kName] as? String else {
            return nil
        }
        
        self.name = name
        self.office = office
        
        // Get Party
        if let party = dictionary[kParty] as? String {
            self.party = party
        }
        
        // Get Address
        if let  addressArray = dictionary[kAddress] as? [[String: AnyObject]],
           let addressDictionary = addressArray.first,
            let line1 = addressDictionary[kAddressLine1] as? String,
            let city = addressDictionary[kAddressCity] as? String,
            let state = addressDictionary[kAddressState] as? String,
            let zip = addressDictionary[kAddressZip] as? String {
            let address = Address(line1: line1, city: city, state: state, zip: zip)
            self.address = address
        }
        
        // Get Phone Number
        if let phoneArray = dictionary[kPhone] as? [String],
           let phoneNumber = phoneArray.first {
            self.phone = phoneNumber
        }
        
        // Get Official's website if available
        if let urlArray = dictionary[kUrl] as? [String],
           let url = urlArray.first  {
            self.url = url
        }
        
        // Get photo if available
        if let photoURL = dictionary[kPhoto] as? String {
            self.photoURL = photoURL
        }
        
        // Get email
        if let emailArray = dictionary[kEmail] as? [String],
           let email = emailArray.first {
            self.email = email
        }
        
        // Get Social media items
        var temp = [Social]()
        if let socialArray = dictionary[kSocial] as? [[String: AnyObject]]{
            for socialDictionary in socialArray {
                type = socialDictionary[kType] as? String
                id = socialDictionary[kId] as? String
                let social = Social(type: type, id: id)
                temp.append(social)
            }
        }
        self.social = temp
    }
}





