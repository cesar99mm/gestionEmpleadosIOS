//
//  LoginViewController.swift
//  empresa
//
//  Created by APPS2T on 24/2/22.

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    //datos que se recibiran desde la api al hacer la llamada (response)
    struct Data: Decodable {
        let token: String
        let puesto: String
        let id: Int
        let status: Int
    }
    var token:String?
    var puesto:String?
    var id:Int?
    var status:Int?
    var defaults = UserDefaults.standard
    
    @IBOutlet weak var emailCampo: UITextField!
    @IBOutlet weak var contraCampo: UITextField!
    @IBOutlet weak var loginBoton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newLayer1 = CAGradientLayer()
        newLayer1.colors =
            [UIColor.black.cgColor,UIColor.white.cgColor]
        newLayer1.frame = view.frame
        view.layer.insertSublayer(newLayer1, at: 0)
        // Do any additional setup after loading the view.
    }

    @IBAction func loguear(_ sender: Any) {
        let url = "http://192.168.64.2/empresa/public/api/empleados/login"
        let body = ["email": emailCampo.text, "contraseña": contraCampo.text]
        //body-> json que se le envia a la api, debe de coincidir
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: Data.self){response in
            print(response)
            self.token = response.value?.token
            if response.value?.token != nil {
                self.defaults.set(self.token!, forKey: "token")
            }
            //se guarda en las variables la respuesta de la api
            self.puesto = response.value?.puesto
            self.id = response.value?.id
            self.status = response.value?.status
            self.afterResponse()
        }
    }
    
    func afterResponse(){
        if(status == 1){
            print("llega1")
            print("token",token!)
            print("puesto",puesto!)
            
            print("Tu status es ",status!)
            if puesto == "empleado"{ //si es empleado solo puede ver su propio perfil
                performSegue(withIdentifier: "logueado_perfil", sender: nil)
            }else{
                performSegue(withIdentifier: "logueado_lista", sender: nil)
            }
        }else if (status == 0){
            let alert = UIAlertController(title: "Error", message: "introduzca datos validos", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            
                let alert = UIAlertController(title: "Error", message: "Compruebe su conexion", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "logueado_lista"{
            let listaVista = segue.destination as! TableusersViewController
            listaVista.token = token!
            listaVista.puesto = puesto!
            listaVista.id = id!
            self.defaults.set(self.puesto!, forKey: "rol")
            self.defaults.set(self.id!, forKey: "id")
            
        }
        if segue.identifier == "logueado_perfil"{
            let listaPerfil = segue.destination as! PerfilViewController
            listaPerfil.token = token!
            listaPerfil.rol = puesto!
            listaPerfil.id = id!
            self.defaults.set(self.puesto!, forKey: "rol")
            self.defaults.set(self.id!, forKey: "id")
        }
    }
    
}

