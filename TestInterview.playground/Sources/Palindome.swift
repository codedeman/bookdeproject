import Foundation


func isPalindrome(_ s: String) -> Bool {
    var newStr = s.lowercased()
    let myPattern = try! NSRegularExpression(pattern: "[^a-zA-Z0-9 ]", options: .allowCommentsAndWhitespace)
    let range = NSRange(location: 0, length: newStr.count)
    let finalString = myPattern.stringByReplacingMatches(in: newStr, options: [], range: range, withTemplate: "")
    finalString.replacingOccurrences(of: " ", with: "")
    var chainReversed = ""

    finalString.reversed().forEach { text  in
        print("text == \(text)")
        chainReversed += text.description
    }
    if finalString == chainReversed {
        return true
    }
    return false
}

func testinPlindrome(_ s: String) -> Bool {
//    for text in s.reversed() {
//        print("--->\(text)")
//    }
    var left = 0
    var right = s.count-1
    while right >= left {
//        print("===> \(s[])")
        left += 1
        right = -1
    }
    return true
}


