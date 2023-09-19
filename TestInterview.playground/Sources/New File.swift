import Foundation

public class BinaryTree<T: Comparable> {
    public var value: T?
    var leftNode: BinaryTree?
    var rightNode: BinaryTree?

    public init(
        value: T,
        leftNode: BinaryTree? = nil,
        rightNode: BinaryTree? = nil
    ) {
        self.value = value
        self.leftNode = leftNode
        self.rightNode = rightNode
    }

    public func insertNode(value: T)  {
        let currentNode = self
        if currentNode.value! > value {
                if leftNode == nil {
                    leftNode = .init(value: value)
                } else {
                    leftNode?.insertNode(value: value)
                }
            } else {
                if rightNode == nil {
                    rightNode = .init(value: value)
                } else {
                    rightNode?.insertNode(value: value)
                }
            }
    }



    public func search(value: T) -> BinaryTree<T>? {
        var currentNode = self
        if currentNode.value == value {
            return currentNode
        } else if value < currentNode.value! {
            if leftNode == nil {
                return nil
            } else {
                return leftNode
            }
        } else {
            if rightNode == nil {
                return nil
            } else {
                return rightNode
            }
        }
    }

    public func printTree(s: String = "root")  {
        if value != nil  {
            print("")
        }

        if let leftChild = leftNode {
            leftChild.printTree(s: "➡️")
        }

        if let rightChild = rightNode {
            rightChild.printTree(s: "⬅️")
        }
    }

    public func preOrderTraversal(node: BinaryTree?) {
        guard let node = node else { return }
        node.printTree()
        preOrderTraversal(node: node.leftNode)
        preOrderTraversal(node: node.rightNode)

    }


    public func deleteNode(root: BinaryTree<Int>?, key: Int)  -> BinaryTree<Int>? {
        guard let root = root else { return nil }
        if root.value!  > key {
            root.leftNode =  deleteNode(root: root.rightNode, key: key)
        } else if root.value! < key {
            root.rightNode = deleteNode(root: root.leftNode, key: key)
        } else {
            if root.leftNode == nil {
                return root.rightNode
            } else if root.rightNode == nil {
                return root.leftNode
            }
            var minNode = findMin(root.rightNode)
//            minNode?.printTree()
//            while minNode?.leftNode != nil {
//                minNode = minNode?.leftNode
//            }
            root.value = minNode?.value ?? 0
            root.rightNode = deleteNode(root: root.rightNode, key: minNode?.value ?? 0)

        }
        return root
    }


    public func findMin(_ node: BinaryTree<Int>?) -> BinaryTree<Int>? {
        guard var node = node else { return nil }

        while let left = node.leftNode {
            node = left
        }
        return node
    }

    public func findMax(_ node: BinaryTree<Int>?) -> Int {
       guard var node = node else { return -1 }

        while let right = node.rightNode {
            node = right
        }
        return node.value!
    }
}


public class Solution {

    public init() {}
    public func deleteNode(root: BinaryTree<Int>?, key: Int) -> BinaryTree<Int>? {
        guard let root = root else { return nil }
        if root.value ?? 0 > key {
            deleteNode(root: root.rightNode, key: key)
        } else if root.value! < key {
            deleteNode(root: root.leftNode, key: key)
        } else {
            if root.leftNode == nil {
                return root.rightNode
            } else if root.rightNode == nil {
                return root.leftNode
            }
            var minNode = root.rightNode
            while minNode?.leftNode != nil {
                minNode = minNode?.leftNode
            }
            root.value = minNode?.value ?? 0
            root.rightNode = deleteNode(root: root.rightNode, key: minNode?.value ?? 0)

        }
        return root
    }

    public func isPalindrome(_ x: Int) -> Bool {
        var num = x
        var reveNum = 0
        while num != 0 {
            reveNum = x * 10
            reveNum = reveNum + num % 10
            num = x/10
        }

        if x == reveNum {
            return true
        }
        return false
    }

}

//func deleteNode( root: TreeNode?,  key: Int) -> TreeNode? {
//    guard let root = root else { return nil }
//
//    if key < root.val {
//        root.left = deleteNode(root.left, key)
//    } else if key > root.val {
//        root.right = deleteNode(root.right, key)
//    } else {
//        if root.left == nil {
//            return root.right
//        } else if root.right == nil {
//            return root.left
//        }
//
//        var minNode = root.right!
//        while minNode.left != nil {
//            minNode = minNode.left!
//        }
//
//        root.val = minNode.val
//        root.right = deleteNode(root.right, minNode.val)
//    }
//
//    return root
//}`


//public enum BinaryTree<T> {
//  case empty
//  indirect case node(BinaryTree, T, BinaryTree)
//
//   mutating func insert(value: T) {
//
//
//    }
//}
