
import UIKit

public protocol AppSceneFactory: class {
    
    func build() -> UIViewController
}

