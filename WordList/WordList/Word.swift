//
//  Word.swift
//  WordList
//
//  Created by Mac on 2025/06/27.
//

import SwiftData


@Model
class Word {
    var english: String
    var japanese: String
    
    init(english: String, japanese: String) {
        self.english = english
        self.japanese = japanese
    }
}
