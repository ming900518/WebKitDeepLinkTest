//
//  ContentView.swift
//  WebKitDeepLinkTest
//
//  Created by Ming Chang on 2023/6/30.
//

import SwiftUI

struct ContentView: View {
    @State private var showWebView = false
    @State private var url = ""
    var body: some View {
        NavigationView {
            Form {
                LabeledContent {
                    TextField("", text: $url, prompt: Text("https://example.com"))
                } label: {
                    Text("Enter URL")
                }
                VStack {
                    Button {
                        showWebView.toggle()
                    } label: {
                        Text("Show WebView")
                    }
                    .disabled(url == "")
                }
            }
            .navigationBarTitle(Text("WebKit Deep Link"))
        }
        .sheet(isPresented: $showWebView) {
            NavigationView {
                WebView(url: URL(string: url)!)
                    .navigationBarTitle(Text("WebView"), displayMode: .inline)
                    .toolbar {
                        ToolbarItem(placement: .navigation) {
                            Button {
                                showWebView.toggle()
                            } label: {
                                Text("Close")
                            }
                        }
                    }
            }
        }
    }
}
