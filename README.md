# Unit-Testing-with-XCTest

An iOS app in Swift that demonstrates the use case of the unit testing with XCTest. The app loads the Shakespeare play from a file, split up the words and de-duplicate them using NSCountedSet to be displayed on a table in the order of the highest number of occurrences. A user can input a word to filter the list on the table.

## Features

### Unordered

Separated by anything other than alphanumerics and put into an array 

<img src="https://github.com/igibliss00/Unit-Testing-with-XCTest/blob/master/README_assets/1.png" width="400">

```
var allWords = [String]()
allWords = plays.components(separatedBy: CharacterSet.alphanumerics.inverted)
allWords = allWords.filter { $0 != "" }
```

### NSCountedSet

De-duplicated the words and counted the occurrence of each of them using NSCountedSet.

<img src="https://github.com/igibliss00/Unit-Testing-with-XCTest/blob/master/README_assets/2.png" width="400">

Each distinct object inserted into an NSCountedSet object has a counter associated with it. NSCountedSet keeps track of the number of times objects are inserted and requires that objects be removed the same number of times. Thus, there is only one instance of an object in an NSSet object even if the object has been added to the set multiple times. The count method defined by the superclass NSSet has special significance; it returns the number of distinct objects, not the total number of times objects are represented in the set. The NSSet and NSMutableSet classes are provided for static and dynamic sets, respectively, whose elements are distinct.
([Source](https://developer.apple.com/documentation/foundation/nscountedset))

```
wordCounts = NSCountedSet(array: allWords)
let sorted = wordCounts.allObjects.sorted { (wordCounts.count(for: $0) > wordCounts.count(for: $1)) }
allWords = sorted as! [String]
```

### filter()

Filtered the array of words according to the user input.

<img src="https://github.com/igibliss00/Unit-Testing-with-XCTest/blob/master/README_assets/3.png" width="400">

filter() is a higher-order function that accepts a function as a parameter. 

You pass in a condition where the function will return only the things that deem the passed-in function as true:

```
allWords = allWords.filter({ (testString: String) -> Bool in
    if testString != "" {
        return true
    } else {
        return false
    }
})
```

The above syntax could be shortened as following:

```
allWords = allWords.filter { $0 != "" }
```

The code in the project that takes a user input from the UIAlertController and filters any word above a certain number of occurrence.

```
var allWords = [String]()
var wordCounts: NSCountedSet!
private(set) var filteredWords = [String]()

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
```


