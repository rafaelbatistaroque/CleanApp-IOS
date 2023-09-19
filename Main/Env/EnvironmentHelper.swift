import Foundation

public final class EnvironmentHelper {
    public enum EnumVariable:String {
        case apiBaseUrl = "API_BASE_URL"
    }

    public static func variable(_ key: EnumVariable) -> String{
        guard let envVariable = Bundle.main.infoDictionary![key.rawValue] else {
            fatalError("There is no environment variable with key \(key.rawValue)")
        }

        return envVariable as! String
    }
}
