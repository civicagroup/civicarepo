//
//  RepResponse.swift
//  Civica
//
//  Created by Antonella on 4/17/22.
//

import Foundation

//struct divisions {
//
//}

//struct normalizedInput{
//
//}


struct offices: Decodable {
    let name: String
    let divisionId: String
    let levels: [String]
    let roles: [String]
    let officialIndices: [Int]
    
}

struct officials: Decodable {
    let name: String
    let address: [address]
    let party: String
    let phones: [String]
    let urls: [String]
    let channels: [channels]
    let emails: [String]
    
}

struct channels: Decodable {
    let type: String
    let id: String
}

struct address: Decodable {
    let line1: String
    let city: String
    let state: String
    let zip: String
}

struct RepResponse: Decodable {
    let kind: String
    let offices: [offices]
    let officials: [officials]
}
