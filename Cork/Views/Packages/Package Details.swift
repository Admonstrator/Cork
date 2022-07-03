//
//  Package Details.swift
//  Cork
//
//  Created by David Bureš on 03.07.2022.
//

import SwiftUI

class SelectedPackageInfo: ObservableObject {
    @Published var contents: String?
}

struct PackageDetailView: View {
    @State var package: BrewPackage
    
    @State var isCask: Bool
    
    @StateObject var packageInfo: SelectedPackageInfo
    
    @State private var description: String = ""
    @State private var homepage: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                Text(package.name)
                    .font(.title)
                Text(returnFormattedVersions(package.versions))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            if packageInfo.contents == nil {
                VStack {
                    ProgressView()
                    Text("Loading package info...")
                }
            } else {
                VStack(alignment: .leading) {
                    Text(description)
                    Text(.init(homepage))
                }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .onAppear {
            Task {
                if !isCask {
                    packageInfo.contents = await shell("/opt/homebrew/bin/brew", ["info", "--json", package.name])
                } else {
                    packageInfo.contents = await shell("/opt/homebrew/bin/brew", ["info", "--json=v2", "--cask", package.name])
                }
                
                description = extractPackageInfo(rawJSON: packageInfo.contents!, whatToExtract: .description)
                homepage = extractPackageInfo(rawJSON: packageInfo.contents!, whatToExtract: .homepage)
                
            }
        }
        .onDisappear {
            packageInfo.contents = nil
        }
    }
}
