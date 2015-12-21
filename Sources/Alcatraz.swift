import Foundation

private func getPackages(completion: [ATZPackage] -> ()) {
  let downloader = ATZDownloader()
  downloader.downloadPackageListWithCompletion() { packageList, _ in
    let packages = ATZPackageFactory.createPackagesFromDicts(packageList)?.flatMap { $0 as? ATZPackage }
    if let packages = packages {
      completion(packages)
    }
  }
}

func waitForPackages(completion: [ATZPackage] throws -> ()) {
  waitFor() {
    getPackages() { packages in
      queue { do {
        try completion(packages)
        exit(0)
      } catch let error {
        print("\(error)")
        exit(1)
      } }
    }
  }
}
