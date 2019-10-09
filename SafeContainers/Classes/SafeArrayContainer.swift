// MARK: 安全数组延展
import Foundation

public struct SafeArrayContainer<Element> {
    // MARK: - 属性
    fileprivate var internalElements = Array<Element>()
//    fileprivate var dispatchQueue: DispatchQueue = DispatchQueue(label: "com.safeArrayContainer.queue")
    fileprivate let _lock = NSLock()

    public init(withElements elements: [Element]? = nil) {
        guard let elements = elements else { return }
        
        _lock.lock()
//        dispatchQueue.sync {
            self.internalElements.append(contentsOf: elements)
//        }
        _lock.unlock()
    }
}

// MARK: - 安全容器
public extension SafeArrayContainer {
    /// 线程安全访问 SafeArrayContainer 的元素
    var elements: [Element] {
        get {
            var elements: [Element] = []
            
            _lock.lock()
//            dispatchQueue.sync {
                elements.append(contentsOf: internalElements)
//            }
            _lock.unlock()
            return elements
        }
    }
    
    /// 重置 SafeArrayContainer 删除所有当前元素，并添加所有指定元素
    ///
    /// - Parameter elements: 添加到 SafeArrayContainer 的元素
    mutating func reset(withElements elements: [Element]) {
        
        _lock.lock()
//        dispatchQueue.sync {
            self.internalElements = elements
//        }
        _lock.unlock()
    }
    
    /// 线程安全附加单个元素
    ///
    /// - Parameter element: 元素添加
    mutating func append(_ element: Element) {
        
        _lock.lock()
//        dispatchQueue.sync {
            internalElements.append(element)
//        }
        _lock.unlock()
    }
    
    /// 线程安全附加的元素集合
    ///
    /// - Parameter elements: 集合添加
    mutating func append(contentsOf elements: [Element]) {
        
        _lock.lock()
//        dispatchQueue.sync {
            self.internalElements.append(contentsOf: elements)
//        }
        _lock.unlock()
    }
    
    /// 线程安全移除指定元素
    ///
    /// - Parameter index: 元素下标
    mutating func remove(at index: Int) {
        
//        _ = dispatchQueue.sync {
            guard (self.internalElements.checkIndexForSafety(index: index) != nil) else {
                return print("💣Index \(index) no element can be remove!")
//                return assertionFailure("Index \(index) no element can be remove!")
            }
        _lock.lock()
            self.internalElements.remove(at: index)
//        }
        _lock.unlock()
    }
    
    /// Map 返回一个数组，其中包含由提供的转换创建的元素
    ///
    /// - Parameter transform: 转换闭包
    /// - Returns: 由 map 方法创建的元素数组
    /// - Throws: 可能抛出
    func map<T>(_ transform: (Element) throws -> T) rethrows -> SafeArrayContainer<T> {
        
        var safeArray = SafeArrayContainer<T>()
        
        var results: [T] = []
        _lock.lock()
//        try dispatchQueue.sync {
            results = try self.internalElements.map(transform)
//        }
        _lock.unlock()
        safeArray.append(contentsOf: results)
        
        return safeArray
    }
    
    
    /// Filter 返回一个包含应该包含的元素的数组
    ///
    /// - Parameter isIncluded: 闭包用于确定一个元素是否应该包含在返回的数组中
    /// - Returns: 过滤元素数组
    /// - Throws: 可能抛出
    func filter(_ isIncluded: (Element) throws -> Bool) rethrows -> SafeArrayContainer<Element> {
        
        var safeArray = SafeArrayContainer<Element>()
        
        var results: [Element] = []
        
        _lock.lock()
//        try dispatchQueue.sync {
            results = try self.internalElements.filter(isIncluded)
//        }
        _lock.unlock()
        
        safeArray.append(contentsOf: results)
        
        return safeArray
    }
}
