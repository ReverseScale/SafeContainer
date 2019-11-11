// MARK: 弱引用安全容器
import Foundation

public struct WeakItemContainer<Element> {
    
    private var weakItemsTable = NSHashTable<AnyObject>.weakObjects()
    fileprivate let semaphore = DispatchSemaphore(value: 1)

    public init() {
        
    }
    
    /// 添加元素
    /// - Parameter element: 元素
    public func append(_ element: Element) {
        guard let item = element as AnyObject? else {
            print("💣 Not AnyObject passed to append!")
            return
        }
        semaphore.wait()
        weakItemsTable.add(item)
        semaphore.signal()
    }
    
    /// 移除元素
    /// - Parameter element: 元素
    public func remove(_ element: Element) {
        guard let item = element as AnyObject? else {
            print("💣 Not AnyObject passed to remove!")
            return
        }

        semaphore.wait()
        weakItemsTable.remove(item)
        semaphore.signal()
    }
    
    /// 移除全部元素
    public func removeAll() {
        semaphore.wait()
        weakItemsTable.removeAllObjects()
        semaphore.signal()
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
