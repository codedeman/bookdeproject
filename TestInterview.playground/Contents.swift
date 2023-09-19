import UIKit
import Foundation
import Swift
var greeting = "Hello, playground"

protocol Purchaseable {
    func buy()
}


struct Book: Purchaseable {
    func buy() {

    }

}



func fact(num: Int) -> Int {
    if num <= 1 {
        print("stop operator")
        return 1
    } else {
        return num * fact(num: num-1)
    }
}

print("num ==",fact(num: 3))
//
//func twoSum(_ nums: [Int], target: Int) -> [Int] {
//    var dic: [Int: Int] = [:]
//    for i in 0 ..< nums.count {
//        let newIndex = target - nums[i]
//        print("all key",dic.keys, dic.values)
//        print("test value saved:",dic[nums[i]])
//        if let index = dic[nums[i]] {
//            return [index,i]
//        } else {
//            dic[newIndex] = i
//        }
//    }
//    return []
//}
//
//twoSum([3,3], target: 6)

struct Stack {
    var arr: [Int] = []

    mutating func push(_ element: Int) {
        arr.append(element)
    }
    mutating func pop() {
        arr.removeLast()
    }
}


//
//class LinkList<T>: Equatable {
//    static func == (lhs: LinkList<T>, rhs: LinkList<T>) -> Bool {
//        return lhs == rhs
//    }
//
//    var head: Node<T>?
//    var tail: Node<T>?
//    var isFirst: Node<T>? {
//        return head
//    }
//
//    var last: Node<T>? {
//
//        return tail
//    }
//
//    func appendNewElement(items: T) {
//        let nNode = Node(value: items)
//        nNode.next = head
//        head = nNode
//
//    }
//
//    func setDummyNodes() {
//        let two = Node<Int>(value: 2)
//        let one = Node<Int>(value: 1)
//    }
//
//    func showList() {
//        var cNode = head
//        while cNode != nil {
//            Swift.print("showing ==> \(String(describing: cNode?.value))")
//            cNode = cNode?.next
//        }
//        Swift.print("nil")
//    }
//
//    func insertNewNode(item: T) -> LinkList {
//        let newNode = Node(value: item)
//        var count = 0
//
//        if head == nil {
//            head = newNode
//        } else {
//            var currentNode = head
//            while currentNode?.next != nil {
//                currentNode = currentNode?.next
//            }
//            currentNode?.next = newNode
//        }
//
//        return self
//    }
//
//    func push(item: T) {
//        let node = Node(value: item)
//        node.next = head
//        head = node
//    }
//
//    func count(searchFor: T) -> Int where T: Equatable {
//        var currentNode = head
//        var count = 0
//
//        while currentNode != nil {
//            if currentNode?.value == searchFor {
//                count += 1
//            }
//            currentNode = currentNode!.next
//        }
//        return count
//    }
//
//    func gethNth(index: T) -> Int where T: Equatable {
//
//        var currentNode = head
//        var count = 0
//
//        while (currentNode != nil) {
//            count += 1
//            currentNode = currentNode?.next
//        }
//        return count
//
//    }
//
//    func countHowManyNode() -> Int where T: Equatable {
//        var count = 0
//        var currentNode = head
//        while (currentNode != nil) {
//            count += 1
//            currentNode = currentNode?.next
//        }
//        return count
//    }
//
//    func counRecursive(node: Node<T>?, searchFor: T) -> Int  where T: Equatable {
//        var frequency: Int = 0
//        if node?.value == searchFor {
//            frequency += 1
//        }
//        return counRecursive(node: node?.next, searchFor: searchFor)
//    }
//
//    func getCountRec(node: Node<T>?) -> Int where T: Equatable {
//        if node != nil {
//            return 1+getCountRec(node: node?.next)
//        }
//        return 0
//    }
//
//
//    func reverser() -> Node<T>? {
//        var current = head
//        var prev: Node<T>? = nil
//        var next: Node<T>? = nil
//
//        while (current != nil) {
//            next = current?.next
//            current?.next = prev
//            prev = current
//            current = next
//        }
//        return prev
//    }
//
//    func print(node: inout Node<T>?)  {
//        while node != nil {
//            Swift.print("====>",node?.value)
//            node = node?.next
//        }
//    }
//
//    func deleteNodeN(head: inout Node<T>?, position: T?) -> Node<T>?  {
//
//        guard let position = position as? Int else {
//            return nil
//        }
//        var temp: Node? = head
//        var prev = head
//        for i in 0 ..< position {
//            if i == 0 && position == 1 {
//                head = head?.next
//            } else {
//
//
//                if i == position - 1 {
//                    prev?.next = temp?.next
//                } else {
//                    prev = temp
//                    temp = temp?.next!
//
//                }
//            }
//
//        }
//        return head
//
//    }
//
//    func deleteNodeNRec(head: Node<T>?, position: T?) -> Int where T: Equatable {
//        if head == nil {
//            return 0
//        }
//        if head?.value == position {
//            if head?.next != nil {
//                head?.value = (head?.next?.value)!
//                head?.next = head?.next?.next
//                return 1
//            } else {
//                return 0
//            } }
//
//            let result = deleteNodeNRec(head: head?.next, position: position)
//            if result  == 0 {
//                head?.next = nil
//                return 1
//            }
//            return result
//    }
//
//    func deleteNodePrevious(head:  Node<T>?, position: T?) -> Node<T>? where T: Equatable
//    {
//        if head == nil {
//            return nil
//        }
//
//        if head?.value == position  {
//            return head
//        }
////
////        // If node is head
////        if node == head {
////          return nil
////        }
//        return deleteNodePrevious(head: head?.next, position: position)
//
//    }
//
//
//
//
//    func findPreviousPosition(head: Node<T>?,node: Node<T>? ) -> Int  where T: Equatable {
//
//        guard head != nil else {
//            return -1
//        }
//
//        if node == head {
//            return -1
//        }
//
//        if head?.next == node {
//            return 0
//        }
//
//        let previousNode = findPreviousPosition(head: head?.next, node: node)
//
//        if previousNode != -1 {
//            return previousNode+1
//        } else {
//            return -1
//        }
//    }
//
//
//
//
//    func printList( node: inout Node<T>?) {
//          while node != nil {
//              Swift.print("====>",node?.value)
//              node = node!.next
//          }
//      }
//
//
//    func mergeLinkedLists<T: Comparable>(listOne: Node<T>, listTwo: Node<T>) -> Node<T> where T: Equatable {
//
//      var list1 = listOne
//      var list2 = listTwo
//        let resultNodeHead = Node<T>.init(value: T.self as! T)
//      var currentNode = resultNodeHead
//
//      while list1 != nil && list2 != nil {
//        if list1.value < list2.value {
//            currentNode.next = list1
//            list1 = list1.next!
//        } else {
//          currentNode.next = list2
//            list2 = list2.next!
//        }
//        currentNode = currentNode.next!
//      }
//
//      if list1 != nil {
//        currentNode.next = list1
//      } else {
//        currentNode.next = list2
//      }
//
//      return resultNodeHead.next!
//    }
//
//
//
//
//
//}
//
//let myLinkedList = LinkList<Int>()
//
//myLinkedList.push(item: 1)
//myLinkedList.push(item: 2)
//myLinkedList.push(item: 3)
//myLinkedList.push(item: 5)
//
//var header = myLinkedList.reverser()



//let list2 = LinkList<Int>()
//
//list2.push(item: 3)
//list2.push(item: 4)
//list2.push(item: 6)
//var node2 = list2.reverser()
//list2.print(node: &node2)

class LinkedNode<T> {
    var next: LinkedNode<T>?
    var value: T

    init(next: LinkedNode<T>?, value: T) {
        self.next = next
        self.value = value
    }

    func printList() {

        var currentNode = self
        print(value)
        while currentNode.next != nil {
            currentNode = currentNode.next!
            print(currentNode.value)
        }
    }

}

//let linkedNode5 = LinkedNode(next: nil, value: 5)
//let linkedNode4 = LinkedNode(next: linkedNode5, value: 3)
//let linkedNode3 = LinkedNode(next: linkedNode4, value: 2)
//let linkedNode2 = LinkedNode(next: linkedNode3, value: 2)

//func mergeTwoNode(listOne: Node<Int>, listTwo: Node<Int>) -> Node<Int> {
//
//    var mergeHead: Node<Int>?
//    var mergeTail: Node<Int>? = nil
//    if listOne == nil {
//        return listTwo
//    } else {
//        return listTwo
//    }
//
//    if listOne.value < listTwo.value {
//        mergeHead = listOne
//        mergeTail = mergeTwoNode(listOne: listOne.next!, listTwo: listTwo)
//    } else {
//        mergeHead = listTwo
//        mergeTail = mergeTwoNode(listOne: listOne, listTwo: listTwo.next!)
//    }
//    mergeHead?.next = mergeTail
////    printNode(node: mergeTail!)
//    return mergeHead!
//
//}

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 }

func mergeLinkedLists(listOne: ListNode?, listTwo: ListNode?) -> ListNode? {

    var list1 = listOne // 1
    var list2 = listTwo // 2
    guard listOne != nil && list2 != nil else { return nil }
    let resultNodeHead = ListNode(0, nil) // 3
    var currentNode : ListNode = resultNodeHead // 4

    while list1?.val != nil && list2?.val != nil { // 5

        if list1!.val < list2!.val { // 5
            currentNode.next = list1
            list1 = list1?.next
        } else {
            currentNode.next = list2
            list2 = list2?.next

        }

        currentNode = currentNode.next! // 6
    }

    if list1 != nil { // 7
        currentNode.next = list1
    }

    if list2 != nil { // 7
        currentNode.next = list2
    }

    return resultNodeHead.next
}

func mergeLinkedListsRecursive(listOne: ListNode?, listTwo: ListNode?) -> ListNode {

    if listOne == nil {
        return listTwo!
    } else if listTwo == nil {
        return listOne!
    }
    guard let listOne = listOne else { return listTwo! }
    guard let listTwo = listTwo else { return listOne }
    var resultNodeHead = ListNode(0, nil) // 3
    var currentNode : ListNode = resultNodeHead // 4
    var val1 = listOne.val
        if listOne.val < listTwo.val {
            currentNode = listOne
            resultNodeHead =  mergeLinkedListsRecursive(listOne: listOne.next, listTwo: listTwo)
        } else {
            currentNode = listTwo
            resultNodeHead = mergeLinkedListsRecursive(listOne: listOne, listTwo: listTwo.next)
        }

    currentNode.next = resultNodeHead
    return currentNode

}

func printNode(string: String = "-->", node: ListNode)  {
    print(string,node.val)
    guard let next = node.next else { return }
    printNode(node: next)
}

let listOne = ListNode.init(1, .init(3, .init(5)))

let listTwo = ListNode.init(2, .init(4, .init(6)))



//printNode(node: mergeLinkedListsRecursive(listOne: listOne, listTwo: listTwo))

//

func maxProfit(price: [Int]) -> Int {

    var buy = price[0]
    var profit: Int = 0
    for sell in price {
        if sell > buy {
            profit = max(profit, sell-buy)
        } else {
            buy = sell
        }
    }

    return profit
}





//isPalindrome("A man, a plan, a canal: Panama")
//testinPlindrome("A man hhahha")
//print( txt.replacingOccurrences(of: regex, with: repl, options: [.regularExpression]) )

let tree = BinaryTree<Int>(value: 10)

tree.insertNode(value: 5)
tree.insertNode(value: 10)
tree.insertNode(value: 4)
tree.insertNode(value: 25)

//tree.deleteNode(root: tree, key: 10)
//tree.deleteNode(root: tree, key: 25)

//tree.printTree()
tree.preOrderTraversal(node: tree)

//class BinarySearch {
//
//    public init() { }
//
//    public func search(arr: [Int], target: Int) -> Int {
//        var lelft = 0
//        var right = arr.count-1
//
//        while lelft <= right {
//
//            let midle = (lelft+right) / 2
//            print("midle ===> \(midle)")
//            if arr[midle] == target {
//                return midle
//            } else if arr[midle] < target {
//                lelft = midle+1
//                print("lelft ===> \(right)")
//
//            } else  {
//                print("right ===> \(right)")
//                right = midle-1
//            }
//        }
//        return 1
//    }
//}
let binarySearh = BinarySearch()
//binarySearh.search(arr: [1,2,3,6,7,8,9], target: 3)

//print(binarySearh.search(arr: [1,2,3,6,7,8,9], target: 3))
//
//let soluton = Solution()
//
//soluton.isPalindrome(-121)

func isPalindromeInt(_ x: Int) -> Bool {
    if x < 0 {
        return false
    }
  var num = x
  var reveNum = 0

  while num != 0 {
      reveNum = reveNum * 10 + num % 10
      num /= 10
  }

  if x == reveNum {
      return true
  }
  return false
}

isPalindromeInt(-121)

binarySearh.selectionSort(array: [0,3,2,1,5])

func romanToInt(_ s: String) -> Int {
    let numTable  = ["I": 1,
                                       "V": 5,
                                       "X": 10,
                                       "L": 50,
                                       "C": 100,
                                       "D": 500,
                                       "M": 1000
    ]
    let validate = ["I","V", "X", "L", "C", "D", "M"]

    var result = 0
    var previous = 0
    for character in s {

        if let num = numTable["\(character)"] {
            result += num
            if num > previous {
//                print("num ==> \(num)")
                let testing = result - 2*previous
                print("num ==> \(num) \(result) \(previous)")
            }
            previous = num

        }

    }
    return result
}

func findMax(arr: [Int])  {
    var max = arr[0]
    var arrMax: [Int] = []
    for i in 0..<arr.count {

    }

    var index = 0
    while index < arr.count  {
        
    }

    for obj in arrMax {
        print("max ==> \(obj)")
    }
}

func removeDuplicates(_ nums: inout [Int]) ->Int {
    var left = nums.count
    var index = 0
    for r in nums where r != nums[index] {
        nums[index] = r
        index += 1
        print("r",r)

    }
    return left
}
var nums = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4]
removeDuplicates(&nums)



//findMax(arr: [0,1,2,3,5,6,7,7])
enum ButtonConfig {

    case primary
    case second
}

enum CVPFormatter {

    case title(content: String)
    case subTitle(content: String)
    struct Content {
        var buttonConfig: ButtonConfig
    }
}

extension CVPFormatter: Equatable {

}


//romanToInt("LVIII")

//romanToInt("IV")
//romanToInt("XC")

/*
 hash = ["I": 1,
 "V": 5,
 "X": 10,
 "L": 50,
 "C": 100,
 "D": 500,
 "M": 1000
]

previous = 0
 - hash value exist
 => result += currentNum
 - current > previous
 => result -= 2*previous



 */
//binarySearh.merged(arr: [4,0,2,1])

//let arr: [Int] = [0,2,3,4,5]
//
//print(arr[0..<3])

binarySearh.mergeWithouRecursive(array:  [4,0,2,1])

//func factorial(num: Int) -> Int {
//    if num == 1 {
//        return 1
//    }
//    return num * factorial(num: num - 1)
//}
//
//factorial(num: 4)

//= 50
//= -5
//= - 1
//= +1
//= +1

//Explanation: L = 50, V= 5, III = 3.


func revert(num: Int) -> Int {

    if num == 0 {
        return 0
    } else {
        return revert(num: num%10) + 10 * revert(num: num/10)
    }
}




print("runing ===> \(reversNum(num: 123))")

print("finding ===> \(findGCD(numA: 54, numB: 24))")



func isValid(_ s: String) -> Bool {
    var stack: [Character] = []
    if s.count <= 1 {
        return false
    }

    for str in s {
        switch str {
        case "{":
            stack.append("}")
        case "}":
            stack.popLast()
        case "(":
            stack.append(")")
        case ")":
            stack.popLast()
        case "[":
            stack.append("]")
        case "]":
            if stack.last == "]" {
                stack.popLast()
            }
        default:
            stack.popLast()
        }
    }

    return stack.isEmpty
}

isValid("({{{{}}}))")
//print("executing ==>",digitToWords(num: 3))
protocol AbtractCache {
    associatedtype T
    func save(object: T)
}

final class Cache<T:Encodable>: AbtractCache {

    func save(object: T) {

    }


}

final class UseCase<Cache> where Cache: AbtractCache {
    var cache: Cache

    init(cache: Cache) {
        self.cache = cache
    }
}

func longestCommonPrefix(_ strs: [String]) -> String {
    guard let firstStr = strs.first else { return "" }
    var commonPrefix = ""
    var charIndex = firstStr.startIndex
    print("start index \(charIndex.hashValue)")

    while charIndex < firstStr.endIndex {
        let char = firstStr[charIndex]
        print("char \(char)")
        for index in 1..<strs.count {
            if charIndex >= strs[index].endIndex || strs[index][charIndex] != char {
                return commonPrefix
            }
        }

        commonPrefix.append(char)
        charIndex = firstStr.index(after: charIndex)
    }

    return commonPrefix
}

longestCommonPrefix(["flower","flow","flight"])


func maxProfit(_ prices: [Int]) -> Int {
        if prices.isEmpty {
            return 0
        }
        var entryPoint: Int = prices[0]
        var sellPoint: Int = prices[0]

        for index in 0..<prices.count {
            if prices[index] < entryPoint {
                entryPoint = prices[index]
            } else {
                print("price",prices[index])
            }
        }

    return entryPoint
}

maxProfit([7,1,5,3,6,4])
