//
//  UserData.swift
//  DownloadSwiftly
//
//  Created by Rajdeep Bharati on 21/05/20.
//  Copyright © 2020 rb. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
//    @Published var showFavoritesOnly = false
//    @Published var landmarks = landmarkData
    @Published var ongoingDownloads = downloadData
}
