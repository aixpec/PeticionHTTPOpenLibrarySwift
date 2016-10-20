//
//  ViewController.swift
//  PeticionHTTPOpenLibrary
//
//  Created by Andrés Ixpec on 19/10/16.
//  Copyright © 2016 Andrés Ixpec. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtISBN: UITextField!
    @IBOutlet weak var lblResultado: UILabel!
    var revisarConexion = Reachability()
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        self.txtISBN.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if revisarConexion.isConnectedToNetwork(){
        let resultado : String = buscarISBN(txtISBN.text!)
            lblResultado.text = resultado;
        }
        else{
            let refreshAlert = UIAlertController(title: "Error", message: "Sin conexión a internet", preferredStyle: UIAlertControllerStyle.Alert)

            presentViewController(refreshAlert, animated: true, completion: nil)
        }
        
        return true
    }
    
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        textField.text = ""
        lblResultado.text = ""
        textField.resignFirstResponder()
        return false
    }
    
    func buscarISBN(ISBN : String) -> String{
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + ISBN
        let nsURL = NSURL(string:urls)
        let datos:NSData? = NSData(contentsOfURL: nsURL!)
        let texto = NSString(data:datos!,encoding:NSUTF8StringEncoding)
        
        return texto! as String
    }
    
 
    
}

