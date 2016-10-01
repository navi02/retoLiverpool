//
//  Producto.swift
//  examen
//
//  Created by nataly on 27/09/16.
//  Copyright © 2016 navi. All rights reserved.
//

import Foundation

class Producto{
    
    var nombre: String
    var des: String
    var precio: String
    var imagenURL: String
    
    init(nombre:String, des:String, precio:String, imagenURL:String) {
        self.nombre = nombre
        self.des = des;
        self.precio = precio;
        self.imagenURL = imagenURL;
    }
    
    var description: String { return "Producto nombre: \(nombre) des: \(des) precio: \(precio) imagen \(imagenURL)" }
    
    
    
    
}



