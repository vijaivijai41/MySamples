//
//  EQPDFViewController.swift
//  ImageUpload
//
//  Created by Vijay on 19/03/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import UIKit
import PDFKit


class EQPDFViewController: UIViewController {

    @IBOutlet weak var baseView: UIView!
    var pdfUrl: URL? = nil
    
    @IBOutlet weak var pdfView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        pdfView.autoScales = true
        if let url = pdfUrl {
            pdfView.document = PDFDocument(url: url)

        }
        self.pdfViewContrains(view: pdfView)
        self.showAnimate()
        // Do any additional setup after loading the view.
    }
    
    
    static func loadController() -> EQPDFViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EQPDFViewController") as! EQPDFViewController
        return controller
    }
    
    static func showPdf(controller: UIViewController ,pdfUrl: String) -> EQPDFViewController? {
        if let controller = loadController() {
          
            controller.pdfUrl = Bundle.main.url(forResource: "Jenish_3.0", withExtension: "pdf")
            return controller
        }
        return nil
    }
    
    
    func pdfViewContrains(view: PDFView) {
        self.pdfView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.pdfView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.pdfView.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: self.pdfView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.pdfView.rightAnchor).isActive = true
    }
    
    func showAnimate() {
        
        self.view.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { _ in
        }
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
