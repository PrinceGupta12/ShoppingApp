//
//  ProductModel.swift
//  Ennovation App task
//
//  Created by Shiv on 15/09/22.
//

import Foundation
import ObjectMapper

class ProductModel : NSObject, NSCoding, Mappable{

    var data : [Product]?

    class func newInstance(map: Map) -> Mappable?{
        return ProductModel()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        data <- map["data"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        data = aDecoder.decodeObject(forKey: "data") as? [Product]
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if data != nil {
            aCoder.encode(data, forKey: "data")
        }
    }

}
class Product : NSObject, NSCoding, Mappable{

    var category : String?
    var descriptionField : String?
    var id : Int?
    var image : String?
    var price : Float?
    var rating : Rating?
    var title : String?


    class func newInstance(map: Map) -> Mappable?{
        return Product()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        category <- map["category"]
        descriptionField <- map["description"]
        id <- map["id"]
        image <- map["image"]
        price <- map["price"]
        rating <- map["rating"]
        title <- map["title"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         category = aDecoder.decodeObject(forKey: "category") as? String
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         image = aDecoder.decodeObject(forKey: "image") as? String
         price = aDecoder.decodeObject(forKey: "price") as? Float
         rating = aDecoder.decodeObject(forKey: "rating") as? Rating
         title = aDecoder.decodeObject(forKey: "title") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if category != nil{
            aCoder.encode(category, forKey: "category")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if rating != nil{
            aCoder.encode(rating, forKey: "rating")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }

    }

}
class Rating : NSObject, NSCoding, Mappable{

    var count : Int?
    var rate : Float?


    class func newInstance(map: Map) -> Mappable?{
        return Rating()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        count <- map["count"]
        rate <- map["rate"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         count = aDecoder.decodeObject(forKey: "count") as? Int
         rate = aDecoder.decodeObject(forKey: "rate") as? Float

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if count != nil{
            aCoder.encode(count, forKey: "count")
        }
        if rate != nil{
            aCoder.encode(rate, forKey: "rate")
        }

    }

}
