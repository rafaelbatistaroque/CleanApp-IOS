import Foundation
import UIKit

extension UIControl {
    func simulate(event: UIControl.Event){
        self.allTargets.forEach { target in
            self.actions(forTarget: target, forControlEvent: event)?.forEach { action in
                (target as NSObject).perform(Selector(action))
            }
        }
    }

    func simulateTap(){
        simulate(event: .touchUpInside)
    }
}
