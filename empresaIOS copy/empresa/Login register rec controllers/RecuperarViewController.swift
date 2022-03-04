//
//  RecuperarViewController.swift
//  empresa
//
//  Created by APPS2T on 24/2/22.
//

import UIKit
import Alamofire

class RecuperarViewController: UIViewController {
//datos que se recibiran desde la api al hacer la llamada
    struct Data: Decodable {
        var status: Int
    }
    var status:Int?
    
    @IBOutlet weak var emailCampo: UITextField!
    @IBOutlet weak var enviarBoton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newLayer1 = CAGradientLayer()
        newLayer1.colors =
            [UIColor.black.cgColor,UIColor.white.cgColor]
        newLayer1.frame = view.frame
        view.layer.insertSublayer(newLayer1, at: 0)
        // Do any additional setup after loading the view.
    }

    @IBAction func recuperar(_ sender: Any) {
        let url = "http://192.168.64.2/empresa/public/api/empleados/recuperarcontra"
        let body = ["email": emailCampo.text]
        
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: Data.self){response in
            print(response)
            self.status = response.value?.status
            print(self.status)
            self.afterResponse()
        }
    }
    func afterResponse(){
        print(status)
        if status == 1{
            let alert = UIAlertController(title: "Email enviado", message: "Revise su correo", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if (status == 0){
            let alert = UIAlertController(title: "Eror", message: "Email no registrado", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Eror de conexion", message: "Compruebe su conexion", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

