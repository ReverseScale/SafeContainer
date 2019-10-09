// MARK: 弱引用安全容器
import Foundation

public struct WeakItemContainer<Element> {
    
    private var weakItemsTable = NSHashTable<AnyObject>.weakObjects()
//    fileprivate var dispatchQueue: DispatchQueue = DispatchQueue(label: "com.weakItemContainer.queue")
    fileprivate let _lock = NSLock()
    
//    public init(withElements elements: [Element]? = nil) {
//        guard let item = elements as AnyObject? else {
//            print("💣Not AnyObject passed to append!")
////            assertionFailure("Not AnyObject passed to append!")
//            return
//        }
//
//        dispatchQueue.sync {
//            self.weakItemsTable.add(item)
//        }
//    }
    
    public init() {
        
    }
    
    /// 添加元素
    /// - Parameter element: 元素
    public func append(_ element: Element) {
        guard let item = element as AnyObject? else {
            print("💣Not AnyObject passed to append!")
//            assertionFailure("Not AnyObject passed to append!")
            return
        }
        
//        dispatchQueue.sync {
//            self.weakItemsTable.add(item)
//        }
        
//        objc_sync_enter(self)
//        weakItemsTable.add(item)
//        objc_sync_exit(self)
        
        _lock.lock()
        weakItemsTable.add(item)
        _lock.unlock()
    }
    
    /// 移除元素
    /// - Parameter element: 元素
    public func remove(_ element: Element) {
        guard let item = element as AnyObject? else {
            print("💣Not AnyObject passed to remove!")
//            assertionFailure("Not AnyObject passed to remove!")
            return
        }
        
//        dispatchQueue.sync {
//            self.weakItemsTable.remove(item)
//        }
        
//        objc_sync_enter(self)
//        weakItemsTable.remove(item)
//        objc_sync_exit(self)
        
        _lock.lock()
        weakItemsTable.remove(item)
        _lock.unlock()
    }
    
    /// 移除全部元素
    public func removeAll() {
        
//        dispatchQueue.sync {
//            self.weakItemsTable.removeAllObjects()
//        }
        
//        objc_sync_enter(self)
//        weakItemsTable.removeAllObjects()
//        objc_sync_exit(self)
        
        _lock.lock()
        weakItemsTable.removeAllObjects()
        _lock.unlock()
    }
    
    /// 集合数量
    public var count: Int {
        return items.count
    }

    /// 集合内容数组
    public var items: [Element] {
        let itemArray = weakItemsTable.allObjects.compactMap { $0 as? Element }
        return itemArray
    }
}
