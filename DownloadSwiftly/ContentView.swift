//
//  ContentView.swift
//  DownloadSwiftly
//
//  Created by Rajdeep Bharati on 03/05/20.
//  Copyright © 2020 rb. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var urlText: String = ""
    @State var url: URL!

    var body: some View {
        VStack {
            TextField("Enter the remote file url here", text: $urlText)
                .padding(EdgeInsets(top: 30, leading: 30, bottom: 10, trailing: 30))

            Button(action: {
                print("url is: \(self.urlText)")
                let urlArr: Array = self.urlText.split(separator: "/").map(String.init)
                print(urlArr.last ?? "myfile")
                self.url = URL(string: self.urlText)!
                URLSession.shared.downloadTask(with: self.url) { url, response, error in
                    guard
                        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
                        let url = url
                    else {
                        return
                    }

                    do {
                        let urlArr: Array = self.urlText.split(separator: "/").map(String.init)
                        let file = docs.appendingPathComponent(urlArr.last ?? "myfile")
                        try FileManager.default.moveItem(atPath: url.path, toPath: file.path)
                    } catch {
                        print(error.localizedDescription)
                    }
                }.resume()
            }) {
                Text("Download")
                    .foregroundColor(.white)
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
