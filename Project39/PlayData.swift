//
//  PlayData.swift
//  Project39
//
//  Created by jc on 2020-07-15.
//  Copyright © 2020 J. All rights reserved.
//

import Foundation

class PlayData {
    var allWords = [String]()
    var wordCounts: NSCountedSet!
    // prevent ViewController from directly manipulating filteredWords
    private(set) var filteredWords = [String]()
    
    init() {
        if let path = Bundle.main.path(forResource: "plays", ofType: "txt") {
            if let plays = try? String(contentsOfFile: path) {
                // split on anything that's not a letter or a number
                allWords = plays.components(separatedBy: CharacterSet.alphanumerics.inverted)
                // filter out empty words
                allWords = allWords.filter { $0 != "" }
                
                // de-duplicates and counts all the words
                wordCounts = NSCountedSet(array: allWords)
                let sorted = wordCounts.allObjects.sorted { (wordCounts.count(for: $0) > wordCounts.count(for: $1)) }
                allWords = sorted as! [String]
            }
        }
        
        // Only when a filter is applied that words are added to filteredWords and by default, the table is empty.
        applyUserFilter("swift")
    }
    
    func applyUserFilter(_ input: String) {
        if let userNumber = Int(input) {
            applyFilter { self.wordCounts.count(for: $0) >= userNumber }
        } else {
            applyFilter { $0.range(of: input, options: .caseInsensitive) != nil }
        }
    }
    
    func applyFilter(_ filter: (String) -> Bool) {
        filteredWords = allWords.filter(filter)
    }
}
