//
//  ContentView.swift
//  DownloadSwiftly
//
//  Created by Rajdeep Bharati on 03/05/20.
//  Copyright © 2020 Rajdeep Bharati. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var urlText: String = ""
    @State var url: URL!
    @State private var showingAlert = false
    @State private var noUrlEntered = false

    var body: some View {
        VStack {
            TextField("Enter the remote file url here", text: $urlText)
                .padding(EdgeInsets(top: 30, leading: 30, bottom: 10, trailing: 30))

            Button(action: {
                print("url is: \(self.urlText)")
                if self.urlText == "" {
                    self.noUrlEntered = true
                    return
                }
                let urlArr: Array = self.urlText.split(separator: "/").map(String.init)
                print(urlArr.last ?? "myfile")
                self.url = URL(string: self.urlText)!
                URLSession.shared.downloadTask(with: self.url) { url, response, error in
                    guard
                        let downloads = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first,
                        let url = url
                    else {
                        return
                    }

                    do {
                        let urlArr: Array = self.urlText.split(separator: "/").map(String.init)
                        let file = downloads.appendingPathComponent(urlArr.last ?? "myfile")
                        try FileManager.default.moveItem(atPath: url.path, toPath: file.path)
                    } catch {
                        print(error.localizedDescription)
                    }
                }.resume()
            }) {
                Text("Download")
                    .foregroundColor(.white)
            }
            .alert(isPresented: $noUrlEntered) {
                Alert(title: Text("No url entered!"), message: Text("Please enter a url to a remote file that you want to download."), dismissButton: .default(Text("Ok")))
            }

            Spacer()

            HStack {
                Button(action: {}) {
                    Text("Pause")
                }
                Button(action: {}) {
                    Text("Resume")
                }
                Button(action: {}) {
                    Text("Cancel")
                }
            }.padding(.bottom, 30)
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
