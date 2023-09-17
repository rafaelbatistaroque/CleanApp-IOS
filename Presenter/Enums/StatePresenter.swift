import Foundation
import Domain

public enum StatePresenter: Equatable {
    case idle,
         loading,
         success(AlertView, AddAccountOutput),
         failure(AlertView)
}
