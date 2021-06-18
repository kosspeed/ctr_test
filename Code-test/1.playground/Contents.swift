import UIKit

extension String {
    var isPalindrome: Bool {
        let characters = Array(self)
        var palindromeString = ""
        
        for i in 1...characters.count {
            palindromeString += String(characters[characters.count - i])        }
    
        return palindromeString.lowercased() == self.lowercased()
    }
}

func execute(word: String) {
    if word.isPalindrome {
        print("\(word) is a palindrome")
    } else {
        print("\(word) isn’t a palindrome")
    }
}

execute(word: "aka")
execute(word: "DaDa")
execute(word: "Level")
execute(word: "Hello")
