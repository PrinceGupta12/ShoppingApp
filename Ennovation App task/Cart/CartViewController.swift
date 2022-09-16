//
//  CartViewController.swift
//  Ennovation App task
//
//  Created by Shiv on 16/09/22.
//

import UIKit
import Alamofire

class CartViewController: UIViewController {
    @IBOutlet weak var finalPriceLbl: UILabel!
    
    @IBOutlet weak var discountedPriceLbl: UILabel!
    @IBOutlet weak var couponBtn: UIButton!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var cartTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        couponBtn.setTitleColor(.blue, for: .normal)
        cartTblView.delegate = self
        cartTblView.dataSource = self
        
        // Do any additional setup after loading the view.
        setInitialPrice()
    }
    
    func setInitialPrice() {
        let pricesWith10Per = getInitialPrice(discount: 10)
        productPriceLbl.text = String(format: "%.2f", pricesWith10Per.price)
        discountedPriceLbl.text = String(format: "%.2f",pricesWith10Per.discountedPrice)
        finalPriceLbl.text = String(format: "%.2f",pricesWith10Per.discountedPrice)
    }
    
    func setPriceWithCoupon() {
        let pricesWith10Per = getInitialPrice(discount: 10)
        productPriceLbl.text = String(format: "%.2f",pricesWith10Per.price)
        discountedPriceLbl.text = String(format: "%.2f",pricesWith10Per.discountedPrice)
        
        let priceAfterCoupon = getPriceWith(price: pricesWith10Per.discountedPrice, discount: 5)
        finalPriceLbl.text = String(format: "%.2f",priceAfterCoupon)
    }
    
    func getPriceWith(price: Float, discount: Int)-> Float {
        var discountedPrice: Float = 0.0
        discountedPrice = (price - ((price * Float(discount))/100))
        return discountedPrice
    }
    
    func getInitialPrice(discount: Int)-> (price: Float, discountedPrice: Float) {
        var discountedPrice: Float = 0.0
        var price: Float = 0.0
        for product in cartItem {
            price = price + (product?.price ?? 0)
        }
        discountedPrice = (price - ((price * Float(discount))/100))
        return (price: price, discountedPrice: discountedPrice)
    }
    
    @IBAction func backClick(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    @IBAction func couponBtnClick(_ sender: Any) {
        if couponBtn.titleLabel?.text == "Coupon Applied!" {
            setInitialPrice()
            couponBtn.setTitleColor(.blue, for: .normal)
            couponBtn.setTitle("Apply Coupon 5 PER", for: .normal)

        } else {
            couponBtn.setTitleColor(.red, for: .normal)
            couponBtn.setTitle("Coupon Applied!", for: .normal)
            setPriceWithCoupon()
        }
    }
    
    @IBAction func placeOrderBtnClcik(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Your Order placed successfuly, Thanks for placing your order", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler:{_ in
            cartItem.removeAll()
            self.backTwo()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
}
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell") as? CartTableViewCell else { return UITableViewCell() }
        
        if let title = cartItem[indexPath.row]?.title {
            cell.titleLbl.text = title
        }
        if let price = cartItem[indexPath.row]?.price {
            cell.priceLbl.text = String(price)
        }
        if let desc = cartItem[indexPath.row]?.descriptionField {
            cell.detailLbl.text = desc
        }
        
        if let imageUrlString = cartItem[indexPath.row]?.image {
            if let imageUrl = URL(string: imageUrlString) {
                cell.productImage.af.setImage(withURL: imageUrl)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
