//
//  ViewController.swift
//  FeeedRSSApp
//
//  Created by Carlos ZR on 24/9/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate, CoordinatorDelegate {

    @IBOutlet private weak var tableView: UITableView!
    
    // Array del modelo de datos creado Post.
    var posts = [Post]()
    
    // Para serializar el xml.
    var parser: XMLParser = XMLParser()
    var titulo: String = String()
    var link: String = String()
    var nombre: String = String()
    
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let url = URL(string: "https://carloszr.com/feed") else { return }
        guard let parser = XMLParser(contentsOf: url) else { return }
        // Decirle al view controller que va a ser su delegado.
        parser.delegate = self
        // Comenzar a parsear.
        parser.parse()
        
        // Para que no haya celdas vacías.
        self.tableView.tableFooterView = UIView()
    }
    
    // Métodos delegados de la clase XML Parser.
    // Extraer ciertas claves para serializar el objeto.
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        nombre = elementName
        
        if elementName == "item" {
            // Inicializar los Strings de la clase.
            titulo = String()
            link = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            if nombre == "title" {
                titulo += data
                print(titulo) // Borrar
            } else if nombre == "link" {
                link += data
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let datosPost = Post(titulo: titulo, link: link)
            posts.append(datosPost)
        }
    }
    
    // MARK: - Métodos delegados de la vista de tabla.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let tituloPost = posts[indexPath.row].titulo
        
        cell.textLabel?.text = tituloPost
        
        return cell
    }

    // Método delegado de la vista de tabla. Navega a la vista detalle.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.goDetailViewController(data: posts[indexPath.row].link)
    }
}

