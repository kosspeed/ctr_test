import UIKit

extension Array where Element == Int {
    func findSummaryIndex() -> Int? {
        var leftSum = 0
        var rightSum = 0
        
        for i in 1..<count {
            rightSum += self[i]
        }
        
        var index1 = 0
        var index2 = 1
        
        while index2 < count {
            rightSum -= self[index2]
            leftSum += self[index1]
            
            if leftSum == rightSum {
                return index1 + 1
            }
            
            index1 += 1
            index2 += 1
        }
        
        return nil
    }
}

func execute(array: [Int]) {
    if let summary = array.findSummaryIndex() {
        print("Middle index is \(summary)")
    } else {
        print("Index not found")
    }
}

execute(array: [1, 3, 5, 7, 9])
execute(array: [3, 6, 8, 1, 5, 10, 1, 7])
execute(array: [3, 5, 6])
