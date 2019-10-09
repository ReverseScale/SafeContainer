// MARK: 安全数组延展
extension Array {
    
    /// 检查下标是否可以访问
    /// - Parameter index: 下标
    public func checkIndexForSafety(index: Int) -> SafeIndex? {
        if indices.contains(index) {
            return SafeIndex(indexNumber: index)
        } else {
            return nil
        }
    }

    /// 根据下标获取元素
    subscript(index: SafeIndex) -> Element {
        get {
            return self[index.indexNumber]
        }
        set {
            self[index.indexNumber] = newValue
        }
    }

    /// 根据下标获取元素
    subscript(safeIndex index: SafeIndex) -> Element {
        get {
            return self[index.indexNumber]
        }
        set {
            self[index.indexNumber] = newValue
        }
    }
}

// MARK: - 安全数组下标
public class SafeIndex {
    
    var indexNumber: Int

    init(indexNumber: Int) {
        self.indexNumber = indexNumber
    }
}
  
