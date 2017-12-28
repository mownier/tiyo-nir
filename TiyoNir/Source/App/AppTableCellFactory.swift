
import UIKit

public protocol AppTableCellFactoryLaborer: class {
    
    var prototype: UITableViewCell? { get }
    
    func build(using tableView: UITableView, with reuseID: String) -> UITableViewCell
}

public protocol AppTableCellFactory {
    
    func prototype(in section: Int, at row: Int) -> UITableViewCell?
    func build(using tableView: UITableView, with reuseID: String, in section: Int, at row: Int) -> UITableViewCell
}
