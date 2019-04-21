// MARK: - LibSwift Extensions

// MARK: - General Array Extensions
extension Array{
    
    /// Retrieve the element without causing an index error.
    /// If the index does not exist, nil is returned.
    ///
    /// - Parameter index: Index of the element to retrieve.
    /// - Returns: Elements retrieved
    func at(_ index:Int) -> Element?{
        return self.indices.contains(index) ? self[index] : nil
    }
}

// MARK: - Equatable && Hashable  Elements Array Extensions
extension Array where Element: Equatable & Hashable {
    
    /// Returns an array without duplication.
    var unique: [Element] {
        return Array(Set(self))
    }
    
    /// Remove a specific element from the array.
    ///
    /// - Parameter element: Element to removed
    /// - Returns: Removed element
    @discardableResult mutating func remove(of element:Element) -> Element?{
        if let index = firstIndex(of: element){
            return remove(at: index)
        }
        
        return nil
    }
}


// MARK: - String Extensions
extension String{
    
    /// Returns a string from which a specific character string has been removed.
    ///
    /// - Parameter item: String to delete.
    /// - Returns: String with specific String removed.
    func removed(_ chars:String)->String{
        return self.replacingOccurrences(of: chars, with: "")
    }
}





