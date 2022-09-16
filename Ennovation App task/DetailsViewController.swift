//
//  DetailsViewController.swift
//  Ennovation App task
//
//  Created by Shiv on 15/09/22.
//

import UIKit
import Alamofire
import ObjectMapper

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var detailsImg: UIImageView!
    @IBOutlet weak var ProductDtlLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var cartCountLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    var productId : Int? = 1
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchProductDetailDataUsingProductId(productId: productId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cartCountLbl.text = String(cartItem.count)
    }
    
    func fetchProductDetailDataUsingProductId(productId: Int?) {
        guard let productId = productId else { return }
        let urlString = "https://fakestoreapi.com/products/\(productId)"
        
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
            if let res = self.dataToJSON(data: data) {
                if let apiResponseModel = Mapper<Product>().map(JSONObject: res) {
                    print(apiResponseModel)
                    self.product = apiResponseModel
                    self.setUIData()
                }
            }
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        

    }
    
    func setUIData() {
        if let imageUrlString = self.product?.image {
            if let imageUrl = URL(string: imageUrlString) {
                detailsImg.af.setImage(withURL: imageUrl)
            }
        }
        if let tittle = self.product?.title {
            titleLbl.text = tittle
        }
        
        if let price = self.product?.price {
            priceLbl.text = String(price)
        }
        if let descp = self.product?.descriptionField {
            descLbl.text = descp
        }
    }
    
    @IBAction func backClick(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    func dataToJSON(data: Data) -> Any? {
       do {
           return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
       } catch let myJSONError {
           print(myJSONError)
       }
       return nil
    }
    @IBAction func addToCartClick(_ sender: Any) {
        cartItem.append(self.product)
        cartCountLbl.text = String(cartItem.count)
    }
    @IBAction func addToWishListClick(_ sender: Any) {
        wishListItem.append(self.product)
        let alert = UIAlertController(title: "Alert", message: "WishList feature coming soon..", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func cartIconClick(_ sender: Any) {
        if cartItem.count > 0 {
            let cartProductViewController = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
            self.navigationController?.pushViewController(cartProductViewController, animated: true)
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please add cart data", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
