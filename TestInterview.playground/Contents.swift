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



//protocol Request {
//    associatedtype Response
//
//    typealias Handler = (_ result: Result<Response>) -> Void
//
//    func perform(then handler: @escaping Handler)
//
//}

func fact(num: Int) -> Int {
    if num <= 1 {
        print("stop operator")
        return 1
    } else {
        return num * fact(num: num-1)
    }
}

print("num ==",fact(num: 3))

func twoSum(_ nums: [Int], target: Int) -> [Int] {
    var dic: [Int: Int] = [:]
    for i in 0 ..< nums.count {
        let newIndex = target - nums[i]
        print("all key",dic.keys, dic.values)
        print("test value saved:",dic[nums[i]])
        if let index = dic[nums[i]] {
            return [index,i]
        } else {
            dic[newIndex] = i
        }
    }
    return []
}

twoSum([3,3], target: 6)

struct Stack {
    var arr: [Int] = []

    mutating func push(_ element: Int) {
        arr.append(element)
    }
    mutating func pop() {
        arr.removeLast()
    }
}

class Node<T>: Equatable {
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.value == rhs.value
    }
    var value: T
    var next: Node<T>?
    init(value: T, next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
}

class LinkList<T>: Equatable {
    static func == (lhs: LinkList<T>, rhs: LinkList<T>) -> Bool {
        return lhs == rhs
    }

    var head: Node<T>?
    var tail: Node<T>?
    var isFirst: Node<T>? {
        return head
    }

    var last: Node<T>? {

        return tail
    }

    func appendNewElement(items: T) {
        let nNode = Node(value: items)
        nNode.next = head
        head = nNode

    }

    func setDummyNodes() {
        let two = Node<Int>(value: 2)
        let one = Node<Int>(value: 1)
    }

    func showList() {
        var cNode = head
        while cNode != nil {
            Swift.print("showing ==> \(String(describing: cNode?.value))")
            cNode = cNode?.next
        }
        Swift.print("nil")
    }

    func insertNewNode(item: T) -> LinkList {
        let newNode = Node(value: item)
        var count = 0

        if head == nil {
            head = newNode
        } else {
            var currentNode = head
            while currentNode?.next != nil {
                currentNode = currentNode?.next
            }
            currentNode?.next = newNode
        }

        return self
    }

    func push(item: T) {
        let node = Node(value: item)
        node.next = head
        head = node
    }

    func count(searchFor: T) -> Int where T: Equatable {
        var currentNode = head
        var count = 0

        while currentNode != nil {
            if currentNode?.value == searchFor {
                count += 1
            }
            currentNode = currentNode!.next
        }
        return count
    }

    func gethNth(index: T) -> Int where T: Equatable {

        var currentNode = head
        var count = 0

        while (currentNode != nil) {
            count += 1
            currentNode = currentNode?.next
        }
        return count

    }

    func countHowManyNode() -> Int where T: Equatable {
        var count = 0
        var currentNode = head
        while (currentNode != nil) {
            count += 1
            currentNode = currentNode?.next
        }
        return count
    }

    func counRecursive(node: Node<T>?, searchFor: T) -> Int  where T: Equatable {
        var frequency: Int = 0
        if node?.value == searchFor {
            frequency += 1
        }
        return counRecursive(node: node?.next, searchFor: searchFor)
    }

    func getCountRec(node: Node<T>?) -> Int where T: Equatable {
        if node != nil {
            return 1+getCountRec(node: node?.next)
        }
        return 0
    }


//     func reverse(_ node: Node?) -> Node? {
//         var prev: Node? = nil
//         var current: Node? = node
//         var next: Node? = nil
//         while current != nil {
//             next = current?.next
//             current?.next = prev
//             prev = current
//             current = next
//         }
//         return prev
//     }

    func reverser() -> Node<T>? {
        var current = head
        var prev: Node<T>? = nil
        var next: Node<T>? = nil

        while (current != nil) {
            next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        return prev
    }

    func print(node: inout Node<T>?)  {
        while node != nil {
            Swift.print("====>",node?.value)
            node = node?.next
        }
    }

    func deleteNodeN(head: inout Node<T>?, position: T?) -> Node<T>?  {

        guard let position = position as? Int else {
            return nil
        }
        var temp: Node? = head
        var prev = head
        for i in 0 ..< position {
            if i == 0 && position == 1 {
                head = head?.next
            } else {


                if i == position - 1 {
                    prev?.next = temp?.next
                } else {
                    prev = temp
                    temp = temp?.next!

                }
            }

        }
        return head

    }

    func deleteNodeNRec(head: Node<T>?, position: T?) -> Int where T: Equatable {
        if head == nil {
            return 0
        }
        if head?.value == position {
            if head?.next != nil {
                head?.value = (head?.next?.value)!
                head?.next = head?.next?.next
                return 1
            } else {
                return 0
            } }

            let result = deleteNodeNRec(head: head?.next, position: position)
            if result  == 0 {
                head?.next = nil
                return 1
            }
            return result
    }

    func deleteNodePrevious(head:  Node<T>?, position: T?) -> Node<T>? where T: Equatable
    {
        if head == nil {
            return nil
        }

        if head?.value == position  {
            return head
        }
//
//        // If node is head
//        if node == head {
//          return nil
//        }
        return deleteNodePrevious(head: head?.next, position: position)

    }




    func findPreviousPosition(head: Node<T>?,node: Node<T>? ) -> Int  where T: Equatable {

        guard head != nil else {
            return -1
        }

        if node == head {
            return -1
        }

        if head?.next == node {
            return 0
        }

        let previousNode = findPreviousPosition(head: head?.next, node: node)

        if previousNode != -1 {
            return previousNode+1
        } else {
            return -1
        }
    }

//    func findPreviousNode(head: Node<T>?) -> Node<T>? where T: Equatable {
//      // If linked list is empty
//        var nth_last: Node<T> = .init(value: 0 as! T)
//
//            // find nth node from the last
//
//            findPreviousPosition(head: head, node: nth_last)
//            // if node exists, then print it
////            if nth_last.data != 0 {
////              print("Nth node from last is: \(nth_last.data)")
////            } else {
////              print("Node does not exists")
//    }
//    func deleteNode(head: Node?, val: Int) -> Int {
//      // Check if list is empty or we reach at the end of the list.
//      guard head != nil else {
//        print("Element not present in the list")
//        return -1
//      }
//
//      // If current node is the node to be deleted
//      if head!.data == val {
//        // If it's the start of the node, head points to second node
//        if head!.next != nil {
//          head!.data = head!.next!.data
//          head!.next = head!.next!.next
//          return 1
//        } else {
//          return 0
//        }
//      }
//
//      // Recursively call the function on the next node
//      let result = deleteNode(head!.next, val)
//      if result == 0 {
//        // If the node was not found, we set the next node to nil
//        head!.next = nil
//        return 1
//      }
//
//      return result
//    }


    func printList( node: inout Node<T>?) {
          while node != nil {
              Swift.print("====>",node?.value)
              node = node!.next
          }
      }


    func mergeLinkedLists<T: Comparable>(listOne: Node<T>, listTwo: Node<T>) -> Node<T> where T: Equatable {

      var list1 = listOne
      var list2 = listTwo
        let resultNodeHead = Node<T>.init(value: T.self as! T)
      var currentNode = resultNodeHead

      while list1 != nil && list2 != nil {
        if list1.value < list2.value {
            currentNode.next = list1
            list1 = list1.next!
        } else {
          currentNode.next = list2
            list2 = list2.next!
        }
        currentNode = currentNode.next!
      }

      if list1 != nil {
        currentNode.next = list1
      } else {
        currentNode.next = list2
      }

      return resultNodeHead.next!
    }


}

let myLinkedList = LinkList<Int>()

//
//myLinkedList.insertNewNode(item: 1)
//myLinkedList.insertNewNode(item: 2)
//myLinkedList.insertNewNode(item: 3)
//myLinkedList.insertNewNode(item: 3)
//myLinkedList.insertNewNode(item: 3)
////myLinkedList.count(searchFor: 3)
//myLinkedList.countHowManyNode()
//myLinkedList.gethNth(index: 3)
//print("this value show \(myLinkedList.count(searchFor: 3))")
//print("this recursive running \(myLinkedList.counRecursive(node: myLinkedList.head, searchFor: 3)))")
//print("count recursive --- \(myLinkedList.getCountRec(node: myLinkedList.head))")
//print("reverse \(myLinkedList.reverser())")
myLinkedList.push(item: 1)
myLinkedList.push(item: 2)
myLinkedList.push(item: 3)
myLinkedList.push(item: 5)

var header = myLinkedList.reverser()


let list2 = LinkList<Int>()

list2.push(item: 3)
list2.push(item: 4)
list2.push(item: 6)
let rev2 = list2.reverser()

let mergeLinkedList = myLinkedList.mergeLinkedLists(listOne: header!, listTwo: rev2!)
print("==> \(mergeLinkedList)")

//myLinkedList.head = header
//myLinkedList.print(node: &header)
//myLinkedList.print(node: &header)
//var newNode = myLinkedList.deleteNodePrevious(head: header, position: 0)
//var last: Node<Int> = .init(value: 0)
//
//myLinkedList.findPreviousPosition(head: myLinkedList.head, node: last)
//myLinkedList.printList(node: &header)
