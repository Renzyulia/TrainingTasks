//import Foundation

import Darwin
import Foundation

/**
 The task is to implement the Shop protocol (you can do that in this file directly).
 - No database or any other storage is required, just store data in memory
 - No any smart search, use String method contains (case sensitive/insensitive - does not matter)
 – Performance optimizations for listProductsByName and listProductsByProducer are optional
 */

struct Product {
    let id: String; // unique identifier
    let name: String;
    let producer: String;
}

protocol Shop {
    /**
     Adds a new product object to the Shop.
     - Parameter product: product to add to the Shop
     - Returns: false if the product with same id already exists in the Shop, true – otherwise.
     */
    func addNewProduct(product: Product) -> Bool
    
    /**
     Deletes the product with the specified id from the Shop.
     - Returns: true if the product with same id existed in the Shop, false – otherwise.
     */
    func deleteProduct(id: String) -> Bool
    
    /**
     - Returns: 10 product names containing the specified string.
     If there are several products with the same name, producer's name is added to product's name in the format "<producer> - <product>",
     otherwise returns simply "<product>".
     */
    func listProductsByName(searchString: String) -> Set<String>
    
    /**
     - Returns: 10 product names whose producer contains the specified string,
     result is ordered by producers.
     */
    func listProductsByProducer(searchString: String) -> [String]
}

// TODO: your implementation goes here
class ShopImpl: Shop {
    var products = [Product]()
  
    func addNewProduct(product: Product) -> Bool {
        for index in 0..<products.count {
            if products[index].id == product.id {
              return false
            }
        }
        products.append(product)
        return true
    }
    
    func deleteProduct(id: String) -> Bool {
        for index in 0..<products.count {
            if products[index].id == id {
                products.remove(at: index)
                return true
            }
        }
        return false
    }
  
    func listProductsByName(searchString: String) -> Set<String> {
        var listProduct = [Product]()
        var listProductCount = 0
        for i in 0..<products.count {
            if listProductCount < 10 {
                if products[i].name.contains(searchString) {
                    listProduct.append(products[i])
                    listProductCount += 1
                }
            }
        }
        var listProductsSet = Set<String>()
        for i in (0..<listProduct.count).reversed() {
            let tempArray = listProduct.filter { product in product.name == listProduct[i].name }
            if tempArray.count <= 1 {
                listProductsSet.insert(listProduct[i].name)
                listProduct.remove(at: i)
            }
        }
        for t in 0..<listProduct.count {
            listProductsSet.insert("\(listProduct[t].producer) - \(listProduct[t].name)")
        }
        return listProductsSet
    }
    
    func listProductsByProducer(searchString: String) -> [String] {
        var listProducts = [Product]()
        var listProductsCount = 0
        for index in 0..<products.count {
            if listProductsCount < 10 {
              if products[index].producer.contains(searchString) {
                listProducts.append(products[index])
                listProductsCount += 1
                }
            }
        }
        let sortedListProducts = listProducts.sorted{$0.producer < $1.producer}
        var listProductsByName = [String]()
        for j in 0..<sortedListProducts.count{
            listProductsByName.append(sortedListProducts[j].name)
        }
        return listProductsByName
    }
}


func test(lib: Shop) {
    assert(!lib.deleteProduct(id: "1"))
    assert(lib.addNewProduct(product: Product(id: "1", name: "1", producer: "Lex")))
    assert(!lib.addNewProduct(product: Product(id: "1", name: "any name because we check id only", producer: "any producer")))
    assert(lib.deleteProduct(id: "1"))
    assert(lib.addNewProduct(product: Product(id: "3", name: "Some Product3", producer: "Some Producer2")))
    assert(lib.addNewProduct(product: Product(id: "4", name: "Some Product1", producer: "Some Producer3")))
    assert(lib.addNewProduct(product: Product(id: "2", name: "Some Product2", producer: "Some Producer2")))
    assert(lib.addNewProduct(product: Product(id: "1", name: "Some Product1", producer: "Some Producer1")))
    assert(lib.addNewProduct(product: Product(id: "5", name: "Other Product5", producer: "Other Producer4")))
    assert(lib.addNewProduct(product: Product(id: "6", name: "Other Product6", producer: "Other Producer4")))
    assert(lib.addNewProduct(product: Product(id: "7", name: "Other Product7", producer: "Other Producer4")))
    assert(lib.addNewProduct(product: Product(id: "8", name: "Other Product8", producer: "Other Producer4")))
    assert(lib.addNewProduct(product: Product(id: "9", name: "Other Product9", producer: "Other Producer4")))
    assert(lib.addNewProduct(product: Product(id: "10", name: "Other Product10", producer: "Other Producer4")))
    assert(lib.addNewProduct(product: Product(id: "11", name: "Other Product11", producer: "Other Producer4")))
    
    var byNames: Set<String> = lib.listProductsByName(searchString: "Product")
    assert(byNames.count == 10)

    byNames = lib.listProductsByName(searchString: "Some Product")
    assert(byNames.count == 4)
    assert(byNames.contains("Some Producer3 - Some Product1"))
    assert(byNames.contains("Some Product2"))
    assert(byNames.contains("Some Product3"))
    assert(!byNames.contains("Some Product1"))
    assert(byNames.contains("Some Producer1 - Some Product1"))

    var byProducer: [String] = lib.listProductsByProducer(searchString: "Producer")
    assert(byProducer.count == 10)

    byProducer = lib.listProductsByProducer(searchString: "Some Producer")
    assert(byProducer.count == 4)
    assert(byProducer[0] == "Some Product1")
    assert(byProducer[1] == "Some Product2" || byProducer[1] == "Some Product3")
    assert(byProducer[2] == "Some Product2" || byProducer[2] == "Some Product3")
    assert(byProducer[3] == "Some Product1")
}

test(lib: ShopImpl())
