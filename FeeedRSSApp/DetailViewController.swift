//
//  DetailViewController.swift
//  FeeedRSSApp
//
//  Created by Carlos ZR on 24/9/21.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate, CoordinatorDelegate {

    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var activity: UIActivityIndicatorView!
    
    var contenidoWeb: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        guard let urlRecibida = contenidoWeb else { return }
        guard let url = URL(string: urlRecibida) else { return }
        
        // Para cargar la url.
        let request : URLRequest = URLRequest(url: url)
        webView.load(request)
        
        // Nombrar al ViewController delegado del WKWebView.
        webView.navigationDelegate = self
    }
    
    // Método del protocolo WKNavigationDelegate. Entra en juego cuando la página comienza a cargarse.
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activity.sizeToFit()
        activity.startAnimating()
        
        // Animar el activity.
        UIActivityIndicatorView.animate(withDuration: TimeInterval(0.5)) {
            self.activity.color = .blue
            self.activity.frame.size.width += 10
            self.activity.frame.size.height -= 500
        }
    }
    
    // Cuando la página se ha terminado de cargar.
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
        activity.hidesWhenStopped = true
    }
}
