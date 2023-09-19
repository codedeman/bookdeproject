import Foundation


public class BinarySearch {

    public init() { }

    public func search(arr: [Int], target: Int) -> Int {
        var lelft = 0
        var right = arr.count-1

        while lelft <= right {

            let midle = (lelft+right) / 2

            if arr[midle] == target {
                return midle
            } else if arr[midle] < target {
                lelft = midle+1
            } else  {
                right = midle-1
            }
        }
        return -1
    }

    public func bubleSort() {

        
    }

    public func selectionSort(array: [Int]) -> [Int] {
        var sortedArr = array
        for i in 0..<sortedArr.count {
            var key = sortedArr[i]
            var keyj = i
            for j in i+1..<sortedArr.count {
                if sortedArr[j] < key {
                    key = sortedArr[j]
                    keyj = j
                }
            }
            sortedArr[keyj] = sortedArr[i]
            sortedArr[i] = key

        }
        return sortedArr
    }

    public func merged(arr: [Int]) -> [Int] {
        guard arr.count > 1 else { return arr }
        let mid = arr.count / 2

        let leftArray = merged(arr: Array(arr[0..<mid]))
        print("==>",leftArray)
        let rightArray = merged(arr: Array(arr[mid..<arr.count]))

        return mergedSort(
            left: leftArray,
            right: rightArray
        )
    }

     func mergedSort(
        left: [Int],
        right: [Int]
    ) -> [Int] {

        var leftIndex = 0
        var rightIndex = 0
        var mergedArr: [Int] = []

        while leftIndex < left.count  && rightIndex < right.count {
            if left[leftIndex]  < right[rightIndex] {
                mergedArr.append(left[leftIndex])
                leftIndex += 1
            } else {
                mergedArr.append(right[rightIndex])
                rightIndex += 1
            }
        }

        while leftIndex < left.count {
            mergedArr.append(left[leftIndex])
            leftIndex += 1
        }

        while rightIndex < right.count {
            mergedArr.append(right[rightIndex])
            rightIndex += 1
        }
        return mergedArr
    }

    public func mergeWithouRecursive(array: [Int]) -> [Int] {
        let mid = array.count / 2
        var stack = [
            Array(array[0..<mid]),
              Array(array[mid..<array.count])

        ]
        var mergedArray = [Int]()
        while !stack.isEmpty {
            guard let rightArray = stack.popLast() else { return [] }
            guard let leftArray = stack.popLast() else { return [] }
            var rightIndex = 0
            var leftIndex = 0
            print(rightArray)
            while rightIndex < rightArray.count && leftIndex < leftArray.count {

                if leftArray[leftIndex] < rightArray[rightIndex] {
                    mergedArray.append(leftArray[leftIndex])
                    leftIndex += 1
                } else {
                    mergedArray.append(rightArray[rightIndex])
                    rightIndex += 1
                }

            }

            // Add any remaining elements from the left array.
                while leftIndex < leftArray.count {
                    mergedArray.append(leftArray[leftIndex])
                    leftIndex += 1
                }

                        // Add any remaining elements from the right array.
                while rightIndex < rightArray.count {
                          mergedArray.append(rightArray[rightIndex])
                          rightIndex += 1
                }

                for i in 0..<mergedArray.count  {
                    for j in i+1..<mergedArray.count {
                        if mergedArray[i] > mergedArray[j] {
                            let temp = mergedArray[i]
                            mergedArray[i] = mergedArray[j]
                            mergedArray[j] = temp
                        }
                    }
                }

        }
            print("merge array==> \(mergedArray)")
          return mergedArray
    }
}


