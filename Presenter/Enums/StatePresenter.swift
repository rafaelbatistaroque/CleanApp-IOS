import Foundation
import Domain
import Shared

public enum StatePresenter<SUCCESS, FAIL>: Equatable {
    case idle,
         loading,
         success(AlertView, SUCCESS?),
         failure(AlertView, FAIL?)
}

extension StatePresenter {

    var reflectedValue: String { String(reflecting: self) }
    public static func == (lhs: StatePresenter<SUCCESS, FAIL>, rhs: StatePresenter<SUCCESS, FAIL>) -> Bool {
        lhs.reflectedValue == rhs.reflectedValue
    }
}
