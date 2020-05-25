//
//  DownloadRow.swift
//  DownloadSwiftly
//
//  Created by Rajdeep Bharati on 21/05/20.
//  Copyright © 2020 rb. All rights reserved.
//

import SwiftUI

struct DownloadRow: View {
    var download: Download
    
    var body: some View {
        HStack {
            Text(download.filename)
        }
    }
}

#if DEBUG
struct DownloadRow_Previews: PreviewProvider {
    static var previews: some View {
        DownloadRow(download: downloadData[0])
    }
}
#endif
