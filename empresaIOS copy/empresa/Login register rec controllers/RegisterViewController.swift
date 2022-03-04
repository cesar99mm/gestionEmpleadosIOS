//
//  RegisterViewController.swift
//  empresa
//
//  Created by APPS2T on 24/2/22.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController{
    //datos que se recibiran desde la api al hacer la llamada

    struct Data: Decodable{
        let status: Int
    }
    var status: Int?
    
    @IBOutlet weak var emailCampo: UITextField!
    @IBOutlet weak var nombreCampo: UITextField!
    @IBOutlet weak var contraCampo: UITextField!
    @IBOutlet weak var puestoCampo: UISegmentedControl!
    @IBOutlet weak var biografiaCampo: UITextField!
    @IBOutlet weak var salarioCampo: UITextField!
    @IBOutlet weak var botonRegistrar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newLayer1 = CAGradientLayer()
        newLayer1.colors =
            [UIColor.black.cgColor,UIColor.white.cgColor]
        newLayer1.frame = view.frame
        view.layer.insertSublayer(newLayer1, at: 0)
    }
    /*
    struct Puesto {
        var valor: String
    }
    let opcion = [
        Puesto(valor: "Empleado"),
        Puesto(valor: "RRHH"),
        Puesto(valor: "Directivo")
    ]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
                return opcion.count
            
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return "\(opcion[row].valor)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let puestoSeleccionado = opcion[row]
            print(puestoSeleccionado.valor)
    }*/
    @IBAction func registrar(_ sender: Any) {
        
        let body = ["email": emailCampo.text,
                    "contraseña": contraCampo.text,
                    "nombre": nombreCampo.text,
                    "puesto": puestoCampo.titleForSegment(at: puestoCampo.selectedSegmentIndex),
                    "salario": salarioCampo.text,
                    "biografia": biografiaCampo.text]
        
        let url = "http://192.168.64.2/empresa/public/api/empleados/registrar"
        
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: Data.self){response in
            self.status = response.value?.status
            print("response",response)
            print("status",response.value?.status)
            self.afterResponse()
        }
    }
    func afterResponse(){
        if (self.status == 1){
            //status ok
            let alert = UIAlertController(title: "Usuario registrado", message: "Haga login con sus credenciales", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            performSegue(withIdentifier: "registro_login", sender: nil)
        }else if (self.status == -1){
            //status al tener la contraseña mal
            print("status" ,self.status)
            let alert = UIAlertController(title: "Contraseña insegura", message: "Usa mayusculas, minusculas, numeros y minimo 6 caracteres", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            self.present(alert, animated: true, completion: nil)
        }else{
            //manejo de error por fallo de conexion o exception de base de datos (email repetido)
            let alert = UIAlertController(title: "Error", message: "error de conexion", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registro_lista"{
            let listaVista = segue.destination as! LoginViewController
        }
    }}

