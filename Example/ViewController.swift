//
//  ViewController.swift
//  Example
//
//  Created by Viktor Golubenkov on 08.02.2021.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController  {
    
    @IBOutlet var fetchDataOutlet: UIButton!
    
    @IBOutlet var titleLabelOutlet: UILabel!
    @IBOutlet var subtitleLabelOutlet: UILabel!
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var imageDescriptionLabelOutlet: UILabel!
    
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    @IBOutlet weak var selectedIDLabelOutlet: UILabel!
    @IBOutlet weak var selectedTextLabelOutlet: UILabel!
    
    @IBOutlet weak var someDataOneLabelOutlet: UILabel!
    @IBOutlet weak var someDataTwoLabelOutlet: UILabel!
    @IBOutlet weak var someDataThreeLabelOutlet: UILabel!
    @IBOutlet weak var someDataFourLabelOutlet: UILabel!
    
    // base url
    let url = "https://pryaniky.com/static/json/sample.json"

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDataOutlet.layer.cornerRadius = 10
        segmentControlOutlet.isHidden = true
        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeIn) {
            self.fetchDataOutlet.center.y -= 999
            self.fetchDataOutlet.frame.size.width = 200
        }
        animator.startAnimation()
    }
    
    
    
    //MARK: - Manager

    func getDataFromPryaniki() {

        // data request
        AF.request(url)
            .response { ( response ) in
                guard let data = response.data else { return }
                let jsonDecoder = JSONDecoder()
                do {
                let decodedData = try jsonDecoder.decode(PryanikiData.self, from: data)
                    
                    self.titleLabelOutlet.text = decodedData.data[0].name
                    self.subtitleLabelOutlet.text = decodedData.data[0].data.text
                    self.imageDescriptionLabelOutlet.text = decodedData.data[1].data.text
                    self.selectedIDLabelOutlet.text = String(decodedData.data[2].data.variants![0].id)
                    self.selectedTextLabelOutlet.text = decodedData.data[2].data.variants![0].text
                    self.someDataOneLabelOutlet.text = decodedData.view[0]
                    self.someDataTwoLabelOutlet.text = decodedData.view[1]
                    self.someDataThreeLabelOutlet.text = decodedData.view[2]
                    self.someDataFourLabelOutlet.text = decodedData.view[3]
                    
                } catch {
                    print(error)
                }
            }
        // image request
        AF.request("https://pryaniky.com/static/img/logo-a-512.png").responseImage { (response) in
            if case .success(let image) = response.result {
                self.imageViewOutlet.image = image
            }
        }
    }
    
    func firstChoice() {
        // data request (first segment)
        AF.request(url)
            .response { ( response ) in
                guard let data = response.data else { return }
                let jsonDecoder = JSONDecoder()
                do {
                let decodedData = try jsonDecoder.decode(PryanikiData.self, from: data)
                    self.selectedIDLabelOutlet.text = String(decodedData.data[2].data.variants![0].id)
                    self.selectedTextLabelOutlet.text = decodedData.data[2].data.variants![0].text
                } catch {
                    print(error)
                }
            }
    }
    
    func secondChoice() {
        // data request (second segment)
        AF.request(url)
            .response { ( response ) in
                guard let data = response.data else { return }
                let jsonDecoder = JSONDecoder()
                do {
                let decodedData = try jsonDecoder.decode(PryanikiData.self, from: data)
                    self.selectedIDLabelOutlet.text = String(decodedData.data[2].data.variants![1].id)
                    self.selectedTextLabelOutlet.text = decodedData.data[2].data.variants![1].text
                } catch {
                    print(error)
                }
            }
    }
    func thirdChoice() {
        // data request (third segment)
        AF.request(url)
            .response { ( response ) in
                guard let data = response.data else { return }
                let jsonDecoder = JSONDecoder()
                do {
                let decodedData = try jsonDecoder.decode(PryanikiData.self, from: data)
                    self.selectedIDLabelOutlet.text = String(decodedData.data[2].data.variants![2].id)
                    self.selectedTextLabelOutlet.text = decodedData.data[2].data.variants![2].text
                } catch {
                    print(error)
                }
            }
    }

    
}



//MARK: - Actions

extension ViewController {

    @IBAction func fetchDataPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.75) {
            self.fetchDataOutlet.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.fetchDataOutlet.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
        getDataFromPryaniki()
        segmentControlOutlet.isHidden = false
        segmentControlOutlet.selectedSegmentIndex = 0
    }
    
    @IBAction func changeData(_ sender: UISegmentedControl) {
        
        switch segmentControlOutlet.selectedSegmentIndex {
        case 0:
            firstChoice()
        case 1:
            secondChoice()
        case 2:
            thirdChoice()
        default:
            break
        }
        
    }
    
}


