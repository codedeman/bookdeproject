import Foundation


public func digitToWords(num: Int) -> String {
    print("running")
    let world: [Int: String] = [
        0: "Zero",
        1: "One",
        2:"Two",
        3: "Three",
        4: "Four"
    ]
    var strWorld: String  = ""
    if num <= 0 {
//        strWorld.utf8CString.remove(at: 0)
        return strWorld
    }


    strWorld +=  "," + (world[num] ?? "" ) 
    return strWorld + digitToWords(num: num - 1)
}


public func reversNum(num: Int, rervers: Int = 0) -> Int {
    if num == 0 {
        return rervers;
    }

    let lastdigit = num%10

    let updateNum = num/10
    let newRevers =  rervers*10+lastdigit

    return reversNum(num: updateNum, rervers: newRevers)

//    while num != 0 {
//        remainder = num%10
//        revers  = revers*10 + remainder
//        num = num/10
//    }
//    return revers
//    remainder = num%10
////    revers  = revers*10 + remainder
//    let newNum = num / 10
//    let reversed = reversNum(num: newNum)
//
//    return Int("\(remainder)\(reversed)")!


}

public func findGCD(numA: Int, numB: Int) -> Int {
    var numA = numA
    var numB = numB
    if numB == 0 {
        return numA
    } else {
        return findGCD(numA: numB, numB: numA%numB)
    }
}
