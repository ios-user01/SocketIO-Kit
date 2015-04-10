//
//  SocketIO.swift
//  Smartime
//
//  Created by Ricardo Pereira on 02/04/2015.
//  Copyright (c) 2015 Ricardo Pereira. All rights reserved.
//

import Foundation

class SocketIO: SocketIOEventHandlerProtocol {
    
    let url: NSURL
        
    // Default transport: WebSocket
    lazy var connection = SocketIOConnection(transport: SocketIOWebSocket())
    
    convenience init(url: String) {
        if let url = NSURL(string: url) {
            self.init(nsurl: url)
        }
        else {
            assertionFailure("Invalid URL")
            self.init(url: "")
        }
    }
    
    convenience init(nsurl: NSURL) {
        self.init(nsurl: nsurl, withOptions: SocketIOOptions())
    }
    
    convenience init(url: String, withOptions options: SocketIOOptions) {
        if let url = NSURL(string: url) {
            self.init(nsurl: url, withOptions: options)
        }
        else {
            assertionFailure("Invalid URL")
            self.init(url: "", withOptions: options)
        }
    }

    init(nsurl: NSURL, withOptions options: SocketIOOptions) {
        url = nsurl
    }
    
    func connect() -> Bool {

        return canConnect(url)
    }
    
    func connect(customTransport: SocketIOTransport) -> Bool {
        if canConnect(url) {
            connection = SocketIOConnection(transport: customTransport)
            return true
        }
        else {
            return false
        }
    }
    
    func canConnect(url: NSURL) -> Bool {
        return NSURLConnection.canHandleRequest(NSURLRequest(URL: url))
    }
    
    
    //MARK: SocketIOEventHandlerProtocol
    
    func on(event: String, withCallback callback: SocketIOCallback) -> SocketIOEventHandler {
        return connection.on(event, withCallback: callback)
    }
    
    func onAny(callback: SocketIOCallback) -> SocketIOEventHandler {
        return connection.onAny(callback)
    }
    
    func off() -> SocketIOEventHandler {
        return connection.off()
    }
    
}
