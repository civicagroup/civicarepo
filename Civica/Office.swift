//
//  Office.swift
//  Civica
//
//  Created by Antonella on 4/18/22.
//

import Foundation
struct Office {
    
    let kName = "name"
    let kIndicies = "officialIndices"
    let kDivisionID = "divisionId"
    
    let name: String
    var indicies: [Int]
    var division: String
    
    init?(dictionary: [String: AnyObject]) {
        guard let name = dictionary[kName] as? String,
              let indicies = dictionary[kIndicies] as? [Int],
              let divisionID = dictionary[kDivisionID] as? String else {return nil}
        
        self.indicies = indicies
        self.name = name
        self.division = divisionID
    }
}
