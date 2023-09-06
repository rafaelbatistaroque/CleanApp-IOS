import Foundation

public enum HttpError: Error{
    case noConnectivity,badRequest,serverError,unauthorized,forbidden
}
