//
//  UIImageView.swift
//  examen
//
//  Created by Praxis on 28/09/16.
//  Copyright © 2016 navi. All rights reserved.
//

import UIKit
import Alamofire

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        print(":::::::::::::::::::::::::::::::::::::\(urlString):::::::::::::::::::::::::::::::::::::::::::")
        Alamofire.request(urlString).responseData { response in
            if let data = response.result.value {
                print("********************************** response *************************************** ")
                self.image = UIImage(data: data)
            }
            else{
               print(response.response?.statusCode)
               print("********************************** Error *************************************** ")
            }
        }
    }
}
