//
//  main1.swift
//  homeWork2
//
//  Created by Роман Зобнин on 06.05.2021.
//

import Foundation

final class ThreadSafeArray <T>{
    private var array: [T] = []
    private let workerQueue = DispatchQueue(label: "alurTriCresta", attributes: .concurrent)
    
    var isEmpty: Bool {
        get {
            return array.isEmpty
        }
    }
    public var count: Int {
        var count = 0
        self.workerQueue.sync {
            count = self.array.count
        }
        return count
    }
    
    func append (_ item: T){
        self.workerQueue.async (flags:.barrier) { [weak self] in
            self?.array.append(item)
        }
    }
    
    func remove(index: Int) {
        self.workerQueue.async (flags:.barrier) { [weak self] in
            self?.array.remove(at: index)
        }
    }
    
    subscript (index: Int) -> T {
        return workerQueue.sync {
            array[index]
        }
    }
    
    func contains(where predicate: (T) -> Bool) -> Bool {
        var result = false
        workerQueue.sync { result = self.array.contains(where: predicate) }
        return result
    }
    //----------------------- было сказано убрать бизнес логику из структурного класса
    
    //    func task(_ sumbol: T) { for i in 1...1000 {
    //        workerQueue.sync {array.append(sumbol)}
    //        print("\(sumbol) \(i)")
    //        }
    //    }
    //    func loadTask(symbol1:T, symbol2: T) -> String{
    //        group.enter()
    //        workerQueue.sync {
    //            self.task(symbol1)
    //        }
    //        group.enter()
    //        workerQueue.sync {
    //            self.task(symbol2)
    //        }
    //        return "Finish"
    //    }
}
let dispatchGroup = DispatchGroup()


func task() {
    for i in 1...1000 {
        DispatchQueue.global().async(group: dispatchGroup){
            dispatchGroup.enter()
            array.append(i)
            dispatchGroup.leave()
        }
    }
}


let workedDelayQueue = DispatchQueue(label: "dejhwvkv", qos: .userInitiated, attributes: .concurrent)


var array = ThreadSafeArray<Any>()


print(array.count)


    
    
    workedDelayQueue.async {
        task()
        print(array.count)
    }
    workedDelayQueue.async {
        task()
        print(array.count)
        
}
print ("result: \(array.count)")
sleep(1)
