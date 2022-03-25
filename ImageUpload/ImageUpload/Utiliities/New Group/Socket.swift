//
//  Socket.swift
//  ImageUpload
//
//  Created by Vijay on 22/11/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import Starscream

class EQSocket {
   
    func connect() {
        var request = URLRequest(url: URL(string: "http://127.0.1.1:8888/")!)
        request.timeoutInterval = 5
        //request.setValue("1.0.0", forHTTPHeaderField: "x-fi-access-token")
        //request.setValue("1.0", forHTTPHeaderField: "x-api-version")
       

        //let encoder = JSONEncoder()
        //let paramsData = try? encoder.encode(params)
        //request.httpBody = paramsData
        
        let socket = WebSocket(url: URL(string: "https://127.0.1.1:8080")!)
        
        socket.advancedDelegate = self
        socket.connect()
        
        if socket.isConnected {
          // do cool stuff.
        }
    }

}

extension EQSocket: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
         print("connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
         print("connected")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
         print("connected")
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
         print("connected")
    }
    
    
}

extension EQSocket:WebSocketAdvancedDelegate {
    func websocketDidConnect(socket: WebSocket) {
        print("connected")
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: Error?) {
        print("dis connected")
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String, response: WebSocket.WSResponse) {
        print(response)
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: Data, response: WebSocket.WSResponse) {
        print(socket)
    }
    
    func websocketHttpUpgrade(socket: WebSocket, request: String) {
        print(request)
    }
    
    func websocketHttpUpgrade(socket: WebSocket, response: String) {
        print(response)
    }
    
   
}

