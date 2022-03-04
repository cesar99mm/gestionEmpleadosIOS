//
//  PerfilViewController.swift
//  empresa
//
//  Created by APPS2T on 24/2/22.
//

import UIKit
import Alamofire

class PerfilViewController: UIViewController {
    var token:String? = ""
    var rol:String? = ""
    var id:Int? = nil
    var defaults = UserDefaults.standard
    
    
    var id2: Int?
    var nombre: String?
    var email: String?
    var puesto: String?
    var biografia: String?
    var salario: Int?
    
    struct DataResponse: Decodable{
        let id: Int?
        let nombre: String?
        let email: String?
        let puesto: String?
        let biografia: String?
        let salario: Int?
        
        enum CodignKeys: String, CodingKey {
            case id
            case nombre
            case email
            case puesto
            case biografia
            case salario
        }
    }
    
    @IBOutlet weak var nombreCampo: UILabel!
    @IBOutlet weak var puestoCampo: UILabel!
    @IBOutlet weak var biografiaCampo: UILabel!
    @IBOutlet weak var salarioCampo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        token = defaults.string(forKey: "token")!
        
        let url = "http://192.168.64.2/empresa/public/api/empleados/perfil"
        let body = ["token_val": token]
        
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: DataResponse.self){ [self] response in
                //si se accede desde un list con otro id o es un empleado que acaba de loguear
            if response.value?.id != nil{
                self.id2 = Int((response.value?.id)!)
            }else{
                self.id2 = nil
            }
            
            self.nombre = response.value?.nombre
            self.email = response.value?.email
            self.puesto = response.value?.puesto
            self.biografia = response.value?.biografia
            self.salario = response.value?.salario
                        
            print("id", id,"id2",id2, "nombre",nombre, "email",email, "puesto",puesto, "biografia",biografia, "salario", salario)
            nombreCampo.text = nombre!
            puestoCampo.text = puesto!
            salarioCampo.text = String(salario!)
            biografiaCampo.text = biografia!
        }
    }

    
}

        
        
