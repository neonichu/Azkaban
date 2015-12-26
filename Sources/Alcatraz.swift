import Foundation

private func getPackages(completion: [ATZPackage] -> ()) {
  let downloader = ATZDownloader()
  downloader.downloadPackageListWithCompletion { packageList, _ in
    let packages = ATZPackageFactory.createPackagesFromDicts(packageList)?.flatMap { $0 as? ATZPackage }
    if let packages = packages {
      completion(packages)
    }
  }
}

private enum Errors: ErrorType {
  case CouldNotReadFile(String)
}

func parsePackagesAtPath(path: String) throws -> [ATZPackage] {
  if let data = NSData(contentsOfFile: path) {
    let JSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])

    if let dict = JSON["packages"] as? [NSObject : AnyObject] {
      let packages = ATZPackageFactory.createPackagesFromDicts(dict)?.flatMap { $0 as? ATZPackage }

      if let packages = packages {
        return packages
      }
    }
  }

  throw Errors.CouldNotReadFile(path)
}

func waitForPackages(completion: [ATZPackage] throws -> ()) {
  waitFor {
    getPackages { packages in
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
