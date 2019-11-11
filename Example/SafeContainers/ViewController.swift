//
//  ViewController.swift
//  SafeContainers
//
//  Created by Tim on 10/09/2019.
//  Copyright (c) 2019 Tim. All rights reserved.
//

import UIKit
import SafeContainers

class ViewController: UIViewController {

    let intElementsOne = [1, 2, 3, 4]
    let intElementsTwo = [4, 5, 6, 7]
    let stringElements = ["Abc", "Ced"]

    override func viewDidLoad() {
        super.viewDidLoad()

        safeArrayTest()

        safeHashContainer()
    }
}

// MARK: - Safe 数组容器
extension ViewController {
    func safeArrayTest() {
        testArrayCreate()
        testArrayAppend()
        testArrayAnd()
        testArrMap()
        testArrFiltered()
    }

    func testArrayCreate() {
        var safeArray = SafeArrayContainer<Int>(withElements: intElementsOne)
        print("====:Create safeArray intElementsOne \(safeArray.elements)")
        
        safeArray.remove(at: 4)
        print("====:Create safeArray \(safeArray.elements)")

        safeArray.reset(withElements: intElementsTwo)
        print("====:Create safeArray intElementsTwo \(safeArray.elements)")
    }
    
    func testArrayAppend() {
        var safeArray = SafeArrayContainer<String>(withElements: stringElements)
        safeArray.append("i")
        
        print("====:Append safeArray.elements \(safeArray.elements)")

        var newArray: [String] = []
        newArray.append(contentsOf: stringElements)
        newArray.append("i")
        
        print("====:Append newArray \(newArray)")
    }
    
    func testArrayAnd() {
        var safeArray = SafeArrayContainer<Int>(withElements: intElementsOne)
        
        safeArray.append(contentsOf: intElementsTwo)
        
        let newArray = intElementsOne + intElementsTwo
        
        print("====:And safeArray.elements \(safeArray.elements)")
            
        print("====:And newArray \(newArray)")
    }
    
    func testArrMap() {
        let safeArray = SafeArrayContainer<String>(withElements: stringElements)
        let mappedArray = safeArray.map { "i" + $0 }
        
        print("====:Map mappedArray.elements \(mappedArray.elements)")
        // print:  "iAbc", "iCed"
    }
    
    func testArrFiltered() {
        let safeArray = SafeArrayContainer<Int>(withElements: intElementsOne)
        let filteredArray = safeArray.filter { $0 != 1 }
        
        print("====:Filtered filteredArray.elements \(filteredArray.elements)")
        // print:  2,3,4
    }
}

// MARK: - Safe 哈希容器
extension ViewController {
    func safeHashContainer() {
        let container = WeakItemContainer<NSObject>()
        
        let object1 = NSObject()
        let object2 = NSObject()
        container.append(object1)
        container.append(object2)
        container.remove(object1)
        container.remove(object1)
        
        print("====:count \(container.count)")
        print("====:item \(container.items)")
    }
}
