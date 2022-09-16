//
//  HomeViewController.swift
//  Ennovation App task
//
//  Created by Shiv on 15/09/22.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireImage
class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    var productArray:[Product]? = []
    var priceArray:[[String:Any]]? = []
    var titleArray:[[String:Any]]? = []
    var emailId: String?
    var Password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productCollectionView.register(UINib(nibName: "ProductCollCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollCell")
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        fetchProductList()
    }
    
    func fetchProductList() {
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://fakestoreapi.com/products")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
            if let res = self.dataToJSON(data: data) {
                let jsonData = ["data":res]
                if let apiResponseModel = Mapper<ProductModel>().map(JSONObject: jsonData) {
                    print(apiResponseModel)
                    self.productArray = apiResponseModel.data
                    DispatchQueue.main.async {
                        self.productCollectionView.reloadData()
                    }
                }
            }
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
    func dataToJSON(data: Data) -> Any? {
       do {
           return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
       } catch let myJSONError {
           print(myJSONError)
       }
       return nil
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollCell", for: indexPath) as? ProductCollCell  else { return UICollectionViewCell() }
        
        cell.titleLbl.text = productArray?[indexPath.row].title ?? ""
        cell.priceLbl.text = "\(productArray?[indexPath.row].price ?? 0)"
        if let url = URL(string: productArray?[indexPath.row].image ?? "") {
            cell.productImg.af_setImage(withURL: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = view.frame.size.width/2 - 22
        let height = width * 1.5
        return CGSize(width: view.frame.size.width/2 - 22, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailsViewController.productId = productArray?[indexPath.row].id ?? 1
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
