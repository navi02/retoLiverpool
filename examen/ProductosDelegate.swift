//
//  productosDelegate.swift
//  examen
//
//  Created by nataly on 27/09/16.
//  Copyright © 2016 navi. All rights reserved.
//

import Alamofire
import Foundation


struct ProductosDelegate
{
    
    func buscaProducto(nombre:String,vController:ViewController){
        var productos = [Producto]()
        Alamofire.request("http://www.liverpool.com.mx/tienda?s=\(nombre)&d3106047a194921c01969dfdec083925=json").responseJSON() {
            response in
            //print(response.request)  // original URL request
            //print(response.response) // HTTP URL response
            //print(response.data)     // server data
            //print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                
                let response = JSON as! NSDictionary
                
                
                let contents = response.object(forKey: "contents") as! [NSDictionary]
                
                let mainContent = contents[0].object(forKey: "mainContent") as! [NSDictionary]
                
                let content = mainContent[2].object(forKey: "contents") as! [NSDictionary]
                
                let content2 = content[0].object(forKey: "records") as! [NSDictionary]
                
                for record : NSDictionary in content2
                {
                    if let attributes = record.object(forKey: "attributes") as? NSDictionary,let arrayNombre = attributes.object(forKey: "product.brand") as? [String],let arrayPrecio = attributes.object(forKey: "sku.list_Price") as? [String],let arrayDes = attributes.object(forKey: "product.displayName") as? [String],let arrayImagenURL = attributes.object(forKey: "product.smallImage") as? [String]
                    {
                    let producto = Producto (nombre : arrayNombre[0] , des : arrayDes[0] , precio:arrayPrecio[0] , imagenURL : arrayImagenURL[0] )
                    print(producto.description)
                    productos.append(producto)
                    }
                    
                }
                vController.reloadTable(productos: productos)
                
            }
            
        }
       
    }
    
    
}
