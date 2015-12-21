import Commander

func getPackages(completion: [ATZPackage] -> ()) {
  let downloader = ATZDownloader()
  downloader.downloadPackageListWithCompletion() { packageList, _ in
    let packages = ATZPackageFactory.createPackagesFromDicts(packageList)?.flatMap { $0 as? ATZPackage }
    if let packages = packages {
      completion(packages)
    }
  }
}

import AppKit

func waitFor(block: () -> ()) {
  NSApplicationLoad()
  block()
  NSApp.run()
}

Group {
  $0.command("list", description: "List installed plugins") {
    waitFor() {
      getPackages() { packages in
        let packages = packages.filter { $0.isInstalled }.map { $0.name as String }
        print(packages.joinWithSeparator("\n"))
        exit(0)
      }
    }
  }
}.run()
