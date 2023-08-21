import UIKit

var greeting = "Hello, playground"

protocol DomainModel {

    var id: Int { get }
}

protocol DataSource {
    func loadModels<T: DomainModel>() -> [T]
}




struct User: DomainModel {

    var id: Int
    var username: String
}

class CoreDataStorage<Model>: DataSource {
    private lazy var items = [Model]()

    func loadModels<T>() -> [T] where T : DomainModel {
        guard T.self == User.self else { return [] }
        return items as! [T]
    }
}


class RealmStorage: DataSource {

    func loadModels<T: DomainModel>() -> [T] {
        guard T.self == User.self else { return [] }

        let firstUser = User(id: 5, username: "username5")
        let secondUser = User(id: 6, username: "username6")

        return [firstUser, secondUser] as! [T]
    }
}

class CoreMemories<Model>: DataSource {
    private lazy var items = [Model]()

      func add(_ items: [Model]) {
          self.items.append(contentsOf: items)
      }

      func loadModels<T: DomainModel>() -> [T] {
          guard T.self == User.self else { return [] }
          return items as! [T]
      }

}

class ListViewController {
    
}

protocol Builder {
    func reset()
    func setNumber()
}


class Director {
    private var builder: Builder?
    func update(builder: Builder) {
        builder.setNumber()
    }

    func buildFullFeaturedProduct() {
        builder?.setNumber()
    }
}


class ConcreateBulder: Builder {
    var product = Product1()
    func reset() {
        product = Product1()
    }

    func setNumber() {
        product.callCenter()
    }

    func retrieveProduct() -> Product1 {
          let result = self.product
          reset()
          return result
      }

}

class Product1 {
    private var parts = [String]()

    func callCenter() {
        parts.append("911")
    }

    func callAreaCode() -> String {
      for str in parts {
          return str
      }
        return ""
    }
}

class Client {
    static func someClientCode(director: Director) {
        let builder = ConcreateBulder()
        builder.setNumber()
        director.update(builder: builder)
        director.buildFullFeaturedProduct()
//        builder.reset()
        print(builder.retrieveProduct().callAreaCode())

//        builder.setNumber()

    }
}

let director = Director()
Client.someClientCode(director: director)

