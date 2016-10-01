//
//  ViewController.swift
//  examen
//
//  Created by nataly on 27/09/16.
//  Copyright © 2016 navi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var tablaProductos: UITableView!
    @IBOutlet weak var txfBuscar: UITextField!
    @IBOutlet weak var iActivity: UIActivityIndicatorView!
    @IBOutlet weak var tfBuscar: UITextField!
    @IBOutlet weak var vResultado: UIView!
    @IBOutlet weak var tablatext: UITableView!
    
    let delegateProductos = ProductosDelegate()
    var productos:[Producto]?
    var autotext:[String]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.iActivity.isHidden = true
        tfBuscar.delegate = self
        /*let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)*/
        tablatext.separatorStyle = UITableViewCellSeparatorStyle.none
        
      
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func dismissKeyboard() {
        print("dismissKeyboard")
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tablaProductos
        {
        if let rows = productos?.count
        {
            print(":::::::::::rows \(rows)")
            if rows == 0
            {
                vResultado.isHidden = false
            }
            else{
               vResultado.isHidden = true
            }
            return rows
        }
        else
        {
            print(":::::::::::rows cero")
            vResultado.isHidden = false
            return 0
        }
        }
        else{
            if let rows = autotext?.count
            {
                print(":::::::::::txfBuscar \(rows)")
                if rows == 0
                {
                    tablatext.isHidden = true;
                }
                
                return rows
            }else{
                print(":::::::::::txfBuscar cero")
                tablatext.isHidden = true;
                return 0
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == tablaProductos
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellproducto", for: indexPath) as! TableViewCellProducto
        
        let producto = productos?[indexPath.row]
        
        cell.nombreProducto.text = producto?.nombre
        cell.desProducto.text = producto?.precio
        cell.imagenProducto.imageFromUrl(urlString: (producto?.imagenURL)!)
        
        /*let image = UIImage(named: entry.filename)
         cell.bkImageView.image = image
         cell.headingLabel.text = entry.heading*/
        return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellbusqueda", for: indexPath) as! TableViewCellautotext
            
            cell.autoTx.text = autotext?[indexPath.row]
            
            
            return cell

        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
        if let autotxt = UserDefaults.standard.object(forKey: "autotext") as! [String]?
        {
            autotext = autotxt;
        }
        else{
            autotext = [String]()
        }
        tablatext.reloadData()
        tablatext.isHidden = false;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing")
        if textField.text != ""
        {
        autotext?.append(textField.text!)
        UserDefaults.standard.set(autotext, forKey:"autotext")
        UserDefaults.standard.synchronize()
        }
        tablatext.isHidden = true;
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        self.view.endEditing(true)
        return false
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print(range)
        print(string)
        print(textField.text)
        let newString = textField.text! + string
        print(newString)
        
        if newString.characters.count > 2
        {
            
            self.iActivity.startAnimating()
            self.iActivity.isHidden = false
            DispatchQueue.main.async {
                self.delegateProductos.buscaProducto(nombre: newString,vController:self)
            }
            
        }
        
        return true;
        
    }
    
    public func reloadTable(productos:[Producto])
    {
        self.productos = productos;
        self.tablaProductos.reloadData()
        self.iActivity.isHidden = true
        self.iActivity.stopAnimating()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("didSelectRowAt \(indexPath.row)")
        if tableView == tablatext
        {
        let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example
        
        let currentCell = tableView.cellForRow(at: indexPath!) as! TableViewCellautotext
        tfBuscar.text = currentCell.autoTx.text
            self.iActivity.startAnimating()
            self.iActivity.isHidden = false
            DispatchQueue.main.async {
                self.delegateProductos.buscaProducto(nombre:  self.tfBuscar.text!,vController:self)
            }
            self.view.endEditing(true)
        }
    }
    
   

}

