
import UIKit

public protocol AppTableViewFactory: class {
    
    func build() -> UITableView
}

public extension UITableView {
    
    public class Factory: AppTableViewFactory {
        
        let style: UITableViewStyle
        
        public init(style: UITableViewStyle) {
            self.style = style
        }
        
        public func build() -> UITableView {
            return UITableView(frame: .zero, style: style)
        }
    }
}
