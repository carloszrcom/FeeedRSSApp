//
//  ViewController.swift
//  FeeedRSSApp
//
//  Created by Carlos ZR on 24/9/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, XMLParserDelegate, CoordinatorDelegate {
    
    // MARK: - Selectors

    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var dataSource = ObjectDataSource()
    var parser: XMLParser = XMLParser()
    var titulo: String = String()
    var link: String = String()
    var nombre: String = String()
    
    var coordinator: MainCoordinator?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "\(Constants.URL.main)\(Constants.EndPoint.feed)") else { return }
        guard let parser = XMLParser(contentsOf: url) else { return }
        parser.delegate = self
        parser.parse()
        
        // Para que no haya celdas vacías.
        self.tableView.tableFooterView = UIView()
    }
    
    // MARK: - Helpers
    
    // Métodos delegados de la clase XML Parser.
    // Extraer ciertas claves para serializar el objeto.
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        nombre = elementName
        
        if elementName == "item" {
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
            dataSource.posts.append(datosPost)
        }
    }
    

    // MARK: - Métodos delegados de la vista de tabla.
    
    // Método delegado de la vista de tabla. Navega a la vista detalle.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.goDetailViewController(data: dataSource.posts[indexPath.row].link)
    }
}

