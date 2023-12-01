//
//  TranslationResponse.swift
//  SuperCoolTranslator
//
//  Created by Radek Vala on 01.12.2023.
//

import Foundation

struct TranslationResponse: Codable {
    let responseData: ResponseData
   
}

struct ResponseData: Codable {
    let translatedText: String
    let match: Double
}

