//
//  ViewController.swift
//  DownloadSample
//
//  Created by Vijay on 05/03/21.
//

import UIKit

class ViewController: UIViewController,URLSessionDelegate {

    @IBOutlet weak var downloadButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func downloadButtonDidTap(_ sender: Any) {
        guard let url = URL(string: "https://www.tutorialspoint.com/swift/swift_tutorial.pdf")else {return}
        
        let config = URLSessionConfiguration.default
        let session = Foundation.URLSession(configuration: config, delegate: self, delegateQueue: nil)
                            
        // Don't specify a completion handler here or the delegate won't be called
        session.downloadTask(with: url).resume()
    }
    

}


extension ViewController : URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        <#code#>
    }
    
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        print("File Downloaded Location- ",  location)
//
//        guard let url = downloadTask.originalRequest?.url else {
//            return
//        }
//        let docsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
//        let destinationPath = docsPath.appendingPathComponent(url.lastPathComponent)
//
//        try? FileManager.default.removeItem(at: destinationPath)
//
//        do{
//            try FileManager.default.copyItem(at: location, to: destinationPath)
//
//           // self.pdfUrl = destinationPath
//            print("File Downloaded Location- ",  destinationPath ?? "NOT")
//        }catch let error {
//            print("Copy Error: \(error.localizedDescription)")
//        }
//    }
//
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {

        let uploadProgress:Float = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        let progressPercent = Int(uploadProgress*100)
        print(progressPercent)
    }

    func URLSession(session: URLSession, dataTask: URLSessionDataTask, didBecomeDownloadTask downloadTask: URLSessionDownloadTask) {
        let downloadProgress:Float = Float(downloadTask.countOfBytesReceived) / Float(downloadTask.countOfBytesExpectedToReceive)
        print(downloadProgress)
    }
}
