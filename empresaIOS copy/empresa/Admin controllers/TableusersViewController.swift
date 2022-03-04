//
//  TableusersViewController.swift
//  empresa
//
//  Created by APPS2T on 24/2/22.
//

import UIKit
import Alamofire

class TableusersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var token:String? = ""
    var rol:String? = ""
    var id:Int? = nil
    
    @IBOutlet weak var tablaEmpleados: UITableView!
    struct Usuario: Codable {
        let id: Int
        let nombre: String
        let puesto: String
        let salario: Int
    }

    struct UsuarioR: Codable{
        var usuarios: [Usuario]?
    }
    
    var usuarios: [Usuario]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaEmpleados.dataSource = self
        tablaEmpleados.delegate = self
        
        let url = "http://192.168.64.2/empresa/public/api/empleados/listar"
        let body = ["token_val": token]
        print("token_val", token)
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: UsuarioR.self){response in
            
            self.usuarios = response.value?.usuarios
            print("lista de usuarios:",self.usuarios)
            
            self.tablaEmpleados.reloadData()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios?.count ?? 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "celdaID", for: indexPath) as! EmpleadoCell
        cell.nombreCampo.text = self.usuarios![indexPath.row].nombre
        cell.puestoCampo.text = self.usuarios![indexPath.row].puesto
        cell.salarioCampo.text = String(self.usuarios![indexPath.row].salario)

        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        id = self.usuarios![indexPath.row].id
        
        performSegue(withIdentifier: "lista_perfil", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "lista_perfil"{
            let listaPerfil = segue.destination as! PerfilViewController
            listaPerfil.rol = rol!
            listaPerfil.id = id!
        }
    }


}

