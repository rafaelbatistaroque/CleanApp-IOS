import Foundation

public class WeakVarProxy<T:AnyObject>{
    public weak var instance: T?

    public init(_ instance:T){
        self.instance = instance
    }
}

public struct DependencyInjector{
    private static var dependencies:[String:Any] = [:]

    public static func resolve<T>() -> T {
        guard let dependecyProvided = self.dependencies[String(describing: T.self)] as? T else {
            fatalError("No provider registered for type \(T.self)")
        }

        print("Injected <-", dependecyProvided, "for type \(T.self)")
        return dependecyProvided
    }

    public static func register<T>(dependecy:T){
//        if let alreadyExists = self.dependencies[String(describing: T.self)] {
//            print("Provided for type \(T.self) already exists ->", alreadyExists)
//
//            return
//        }

        self.dependencies[String(describing: T.self)] = dependecy
        print("Provided ->", dependecy, "to \(T.self)")
    }

    public static func clear<T>(dependecy:T){
        guard (dependencies[String(describing: T.self)] != nil) else {
            fatalError("No clean type \(T.self)")
        }

        self.dependencies[String(describing: T.self)] = nil
    }
}

@propertyWrapper public class Inject<T>{
    public var wrappedValue: T

    public init(){
        self.wrappedValue = DependencyInjector.resolve()
    }

    deinit{
        print("de init Inject")
    }
}

@propertyWrapper public class Provider<T>{
    public var wrappedValue: T

    public init(wrappedValue: T){
        self.wrappedValue = wrappedValue
        DependencyInjector.register(dependecy: wrappedValue)
    }

    deinit{
        print("de init Provider")
    }
}
