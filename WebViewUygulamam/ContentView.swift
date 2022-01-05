//
//  ContentView.swift
//  WebView
//
//  Created by Baris on 5.11.2021.
//

import SwiftUI
import WebKit

struct ContentView: View {
    
    @ObservedObject var monitor = NetworkMonitor()
    @State private var showAlertSheet = false
    
    let webView = WebView(request: URLRequest(url: URL(string: "https://www.heybej.com")!))
    /* Internet bağlantısı kontrolü */
    init() {
        if monitor.isConnected == true {
             self._showAlertSheet = State(initialValue: false)
        }
        else
        {
            self._showAlertSheet = State(initialValue: true)
        }
    }
    
    
    
    var body: some View {
        
        VStack {
            webView
           
            
            HStack {
                Button(action: {
                    self.webView.goBack()
                    
                }) {
                    Image("arrow-left")
                        .font(.title)
                        .foregroundColor(.blue)
                        .padding()
                }
                Spacer()
                
                               
                Button(action: {
                    self.webView.goHome()
                    
                }) {
                    Image("home")
                        .font(.title)
                        .foregroundColor(.blue)
                        .padding()
                }
                Spacer()
                
                Button(action: {
                    self.webView.refresh()
                    
                }) {
                    Image("refresh")
                        .font(.title)
                        .foregroundColor(.blue)
                        .padding()
                }
                Spacer()
                Button(action: {
                    self.webView.goForward()
                    
                }) {
                    Image("arrow-right")
                        .font(.title)
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            
        }
        //Network Alert Context
        .alert(isPresented: self.$showAlertSheet, content: {
            Alert(title: Text("Bağlantı yok"), message: Text("Lütfen internet bağlantınızı kontrol edin"))
        })
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        }
    }

struct WebView: UIViewRepresentable {
    let request: URLRequest
    private var webView: WKWebView?
    
    init(request: URLRequest) {
        self.webView = WKWebView()
        self.request = request
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView!
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
    func goBack() {
        webView?.goBack()
    }
    
    func goForward() {
        webView?.goForward()
    }
    
    func refresh() {
        webView?.reload()
    }
    
    func goHome() {
        webView?.load(request)
    }
}
