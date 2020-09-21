import UIKit


//MARK: - Task 1
/*
    На вход в фукцию поступает массив int и число int, вернуть индексы 2ух эл-ов в массиве,
    которые в сумме дают поступившее на вход число
 */

//MARK: - Task 2
/*
    Удалить одинаковые значения из отсортированного массива, вернуть количество оставшихся элементов
 */

//MARK: - Task 3
/*
    На вход подается массив, в этом массиве нужно найти такой подмассив, который,
    если вы отсортируете в порядке возрастания, отсортирует весь массив в порядке возрастания,
    вернуть длину этого подмассива
 */

//MARK: - Task 4
/*
    На вход поступа строка, вернуть обратную строку не создавая вспомогальные строки и массивы
 */

//MARK: - Task5
/*
    Вернуть true, если между 2мя строками, поданными в функцию на вход, нет, либо только одно отличие
 */

//MARK: - Task6
/*
    Linked List
    Перевернуть Linked List
 
 */

//MARK: - Task7
/*
    Linked List
    Объединить два отсортированных связных списка
 */

//MARK: - Task8
/*
  Двунаправленный список
 */

//MARK: - Task9
/*
  Написать функцию, которая назначает клетки поля цифрами в игре "Сапер"
 */

//MARK: - Task10
/*
   Реализовать структуру данных очередь
 */

//MARK: - Task11
/*
   Расширить доступную часть игрового поля при нажатии в игре "Сапер"
 */

struct Queue<T> : CustomStringConvertible{
    private var list = LinkedList<T>()
    
    mutating func enqueue(element: T) {
        list.append(value:element)
    }
    
    mutating func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else { return nil }
        list.remove(node: element)
        return element.value
    }
    
    var isEmpty: Bool{
        return list.isEmpty
    }
    
    mutating func peek() -> T? {
        return list.first?.value
    }
    
    var description: String{
        return list.description
    }
}

class ListNode{
    var value: Int
    var next: ListNode?
    init(value: Int, next: ListNode?){
        self.value = value
        self.next = next
    }
}

class ListNode2<T>{
    var value: T
    var next: ListNode2?
    var previous: ListNode2?
    init(value: T){
        self.value = value
    }
}

struct LinkedList<T> : CustomStringConvertible{
    
    private var head: ListNode2<T>?
    private var tail: ListNode2<T>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var first: ListNode2<T>? {
        return head
    }
    
    var last: ListNode2<T>? {
        return tail
    }
    
    mutating func append(value: T) {
        let newNode = ListNode2(value: value)
        if tail != nil {
            newNode.previous = tail
            tail?.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }
    var description: String{
        var text = "["
        var node = head
        while node != nil {
            text += "\(node!.value)"
            node = node?.next
            if node != nil { text += ", "}
        }
        return text + "]"
    }
    
    mutating func remove(node: ListNode2<T>) -> T{
        let prev = node.previous
        let next = node.next
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        
        if next == nil {
            tail = prev
        }
        node.previous = nil
        node.next = nil
        return node.value
    }
}

class Solution{
    //Task 1
    func twoSum(array: [Int], target: Int)->[Int]{
        var resultArray: [Int] = []
        var dictionary: [Int: Int] = [:]
        for (i, j) in array.enumerated() {
            if let index = dictionary[target - j]{
                resultArray.append(index)
                resultArray.append(i)
                return resultArray
            }
            dictionary[j] = i
        }
        return resultArray
    }
    
    //Task 2
    func removeDuplicates(input: inout[Int] ) -> Int{
        var index: Int = 0
        var last: Int?
        while index < input.count{
            if input[index] == last{
                input.remove(at: index)
            } else {
                last = input[index]
                index += 1
            }
        }
        return input.count
    }
    
    //Task 3
    func findUnsortedSubarray(array:[Int]) -> Int{
        var maxNum = array[0]
        let arrayLen = array.count
        var minNum = array[arrayLen - 1]
        var end = 0
        var start = 0
        for (i, j) in array.enumerated() {
            maxNum = max(maxNum, j)
            if j < maxNum {
                end = i
            }
        }
        
        for (i, _) in array.enumerated() {
            minNum = min(minNum, array[arrayLen - 1 - i])
            if array[arrayLen - 1 - i] > minNum {
                start = arrayLen - 1 - i
            }
        }
        return end - start + 1
    }
    
    //Task 4
    func reverseString(str: inout [Character]){
        var last = str.count - 1
        var first: Int = 0
        while first < last{
            (str[first], str[last]) = (str[last], str[first])
            first += 1
            last -= 1
        }
    }
    
    //Task 5
    func isOneAway(firsStr: String, secondStr: String) -> Bool{
        if (firsStr.count - secondStr.count > 1 || firsStr.count - secondStr.count < -1){
            return false
        } else if firsStr.count == secondStr.count{
            return isOneAwaySameLength(firsStr:firsStr, secondStr:secondStr)
        } else{
            return isOneAwayDiffLength(firsStr: firsStr, secondStr: secondStr)
        }
    }
    
    func isOneAwaySameLength(firsStr: String, secondStr: String) -> Bool{
        var countDiff = 0
        for i in 0 ... firsStr.count - 1 {
            let indexFirst = firsStr.index(firsStr.startIndex, offsetBy: i)
            let indexSecond = secondStr.index(secondStr.startIndex, offsetBy: i)
            if firsStr[indexFirst] != secondStr[indexSecond]{
                countDiff += 1
                if countDiff > 1{
                    return false
                }
            }
        }
        return true
    }
    
    func isOneAwayDiffLength(firsStr: String, secondStr: String) -> Bool{
        var countDiff = 0
        var i = 0
        while i < secondStr.count{
            let indexFirst = firsStr.index(firsStr.startIndex, offsetBy: i + countDiff)
            let indexSecond = secondStr.index(secondStr.startIndex, offsetBy: i)
            if firsStr[indexFirst] == secondStr[indexSecond]{
                i += 1
            } else{
                countDiff += 1
                if countDiff > 1{
                    return false
                }
            }
        }
        return true
    }
    
    //MARK: - Linked List Tasks
    //Task 6
    func reverseLinkedList(head: ListNode?) -> ListNode?{
        var currentNode = head
        var next: ListNode?
        var prev: ListNode?
        while currentNode != nil{
            next = currentNode?.next
            currentNode?.next = prev
            prev = currentNode
            currentNode = next
        }
        return prev
    }
    
    //Task 7
    func mergeTwoLinkedList(firstHead: ListNode?, secondHead: ListNode?) -> ListNode?{
        guard firstHead != nil else {return secondHead}
        guard secondHead != nil else {return firstHead}
        let newHead:ListNode = ListNode(value: 0, next: nil)
        var l1 = firstHead, l2 = secondHead
        var endOfSortedList: ListNode? = newHead
        while l1 != nil && l2 != nil{
            if l1!.value <= l2!.value{
                endOfSortedList?.next = l1
                l1 = l1!.next
            }else {
                endOfSortedList!.next = l2
                l2=l2!.next
            }
            endOfSortedList = endOfSortedList?.next
        }
        endOfSortedList?.next = l1 == nil ? l2:l1
        return newHead.next
    }
    
    //Task 9
    func minesweeper(bombs:[[Int]], rows: Int, columns: Int) -> [[Int]]{
        var field:[[Int]] = Array(repeating: Array(repeating: 0, count: columns), count: rows)
        for bomb in bombs {
            let row = bomb[0]
            let column = bomb[1]
            field[row][column] = -1
            for i in row - 1 ... row + 1 {
                for j in column - 1 ... column + 1 {
                    if (0 <= i) && (i < rows) && (0 <= j) && (j < columns) && (field[i][j] != -1) {
                        field[i][j] += 1
                    }
                }
            }
        }
        return field
    }
    
    //Task 11
    func click(field: inout[[Int]], givenI:Int, givenJ: Int) -> [[Int]]{
        var queue = Queue<[Int]>()
        let rows = field.count
        let columns = field.first?.count
        
        if field[givenI][givenJ] == 0 {
            field[givenI][givenJ] = -2
            queue.enqueue(element: [givenI, givenJ])
        } else {
            return field
        }
        while !queue.isEmpty {
            let position = queue.dequeue()
            for i in (position?.first)! - 1...(position?.first)! + 1{
                for j in (position?.last)! - 1...(position?.last)!+1{
                    if (0 <= i) && (i < rows) && (0 <= j) && (j < columns!) && (field[i][j] == 0){
                        field[i][j] = -2
                        queue.enqueue(element: [i, j])
                    }
                }
            }
        }
        return field
    }
}

let example = Solution()

print("Task1 result: \(example.twoSum(array: [3, 15 ,7 , 8, 11, 12, 4, 24, 3, 5], target: 17))")

var task2Array: [Int] = [0,0,1,1,3,4,4,4,5,5,8]
print("Task2 result: \(example.removeDuplicates(input: &task2Array)), array \(task2Array)")

print("Task3 result: \(example.findUnsortedSubarray(array: [1, 4, 2, 3, 2, 6]))")

var myStr: [Character] = ["g","o"," ","1", "5"]
example.reverseString(str: &myStr)
print("Task4 result: \(myStr)")

print("Task5 result: \(example.isOneAway(firsStr: "hello", secondStr: "hello"))") //true
print("Task5 result: \(example.isOneAway(firsStr: "helio", secondStr: "hello"))") //true
print("Task5 result: \(example.isOneAway(firsStr: "hello", secondStr: "helo"))") //true
print("Task5 result: \(example.isOneAway(firsStr: "hello", secondStr: "heo"))") //false

let thirdNode = ListNode(value: 6, next: nil)
let secondNode = ListNode(value: 5, next: thirdNode)
let oneNode = ListNode(value: 2, next: secondNode)

func printList(head: ListNode?){
    var currentNode = head
    while currentNode != nil {
        print(currentNode!.value)
        currentNode = currentNode?.next
    }
}
var list = example.reverseLinkedList(head: oneNode)
print("Task6 result:")
printList(head: list)

let thirdNode1 = ListNode(value: 6, next: nil)
let secondNode1 = ListNode(value: 5, next: thirdNode1)
let oneNode1 = ListNode(value: 2, next: secondNode1)

let thirdNode2 = ListNode(value: 10, next: nil)
let secondNode2 = ListNode(value: 7, next: thirdNode2)
let oneNode2 = ListNode(value: 1, next: secondNode2)
let newList = example.mergeTwoLinkedList(firstHead: oneNode1, secondHead: oneNode2)
print("Task7 result:")
printList(head: newList)

//Task 8
var list2 = LinkedList<Int>()
list2.append(value: 1)
list2.append(value: 2)
list2.append(value: 3)
list2.append(value: 4)
list2.append(value: 5)
print("Task8 result: \(list2.description)")

//Task 9
var field = example.minesweeper(bombs: [[0,2],[1,3]], rows: 3, columns: 4)
print("Task9 result:")
field.map {(array) in print(array)}

//Task 10
var queue = Queue<Int>()
queue.enqueue(element: 3)
queue.enqueue(element: 4)
queue.enqueue(element: 5)
queue.enqueue(element: 6)
queue.dequeue()
queue.dequeue()

print("Task10 result: \(queue.description) , peek: \(queue.peek())")

//Task 11
let newField = example.click(field: &field, givenI: 2, givenJ: 3)
print("Task11 result:")
newField.map {(array) in print(array)}
