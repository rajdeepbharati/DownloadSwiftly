//
//  ContentView.swift
//  DownloadSwiftly
//
//  Created by Rajdeep Bharati on 03/05/20.
//  Copyright © 2020 Rajdeep Bharati. All rights reserved.
//

import SwiftUI
//import AppKit

struct ContentView: View {
    @State var urlText: String = ""
    @State var url: URL!
    @State private var showingAlert = false
    @State private var noUrlEntered = false
    @State private var unsupportedUrl = false
//    @State private var percentageLabel = Text("")
    @State private var id = 0
    @State var filename: String = ""
    
    @EnvironmentObject var userData: UserData
    
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//        let percentDownloaded = totalBytesWritten / totalBytesExpectedToWrite
//
//        DispatchQueue.main.async {
//            self.percentageLabel = Text("\(percentDownloaded * 100)%")
//        }
//    }

    var body: some View {
        VStack {
            HStack {
                TextField("Enter the remote file url here", text: $urlText)
                    .frame(minWidth: .some(200))
    //                .padding(EdgeInsets(top: 30, leading: 30, bottom: 10, trailing: 30))

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
                            self.filename = urlArr.last ?? "myfile"
                            let file = downloads.appendingPathComponent("SwiftlyDownloaded/" + self.filename)
                            try FileManager.default.moveItem(atPath: url.path, toPath: file.path)
                            print(self.userData.ongoingDownloads)
                            self.userData.ongoingDownloads.append(Download(id: self.id, urlText: self.urlText, filename: self.filename))
                            print(self.userData.ongoingDownloads)
                            self.id += 1
                        } catch {
                            self.unsupportedUrl = true
                            print(error.localizedDescription)
                        }
                    }
                    .resume()
//                    self.userData.ongoingDownloads.append(Download(id: self.id, urlText: self.urlText, filename: self.filename))
//                    self.id += 1
                }) {
                    Text("Download")
//                        .foregroundColor(.white)
                }
                .alert(isPresented: $noUrlEntered) {
                    Alert(title: Text("No url entered!"), message: Text("Please enter a url to a remote file that you want to download."), dismissButton: .default(Text("Ok")))
                }
                .alert(isPresented: $unsupportedUrl) {
                    Alert(title: Text("Unsupported URL"), message: Text("Please enter a valid url."), dismissButton: .default(Text("Ok")))
                }

    //            Spacer()

    //            HStack {
                    Button(action: {}) {
                        Text("Pause")
                    }
                    Button(action: {}) {
                        Text("Resume")
                    }
                    Button(action: {}) {
                        Text("Cancel")
                    }
    //            }.padding(.bottom, 30)
            }
            .padding()
            
            List {
                ForEach(self.userData.ongoingDownloads) { download in
//                    Text(download)
                    HStack {
                        DownloadRow(download: download)
                    }
                }
            }
            .frame(minHeight: 150)
        }
        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData())
    }
}
#endif
