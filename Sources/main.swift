import Commander

Group {
  $0.command("install", Argument("name"), Option("packages", ""),
      description: "Install a plugin") { (name: String, packages: String) in
    if let url = NSURL(string: name), lastComponent = url.lastPathComponent where name.hasPrefix("http") {
      waitFor { queue {
        let plugin = ATZPlugin(dictionary: [ "name": lastComponent, "url": name ])
        let result = plugin.installAndReport()
        exit(result ? 0 : 1)
      } }
    }

    let packageClosure = { (packages: [ATZPackage]) in
      let packages = packages.filter { $0.name == name }
      packages.forEach { $0.installAndReport() }
    }

    if packages != "" {
      packageClosure(try parsePackagesAtPath(packages))
    } else {
      waitForPackages(packageClosure)
    }
  }

  $0.command("list", description: "List installed plugins") {
    waitForPackages { packages in
      let packages = packages.filter { $0.isInstalled }.map { $0.name as String }
      print(packages.joinWithSeparator("\n"))
    }
  }

  $0.command("uninstall", description: "Uninstall a plugin") { (name: String) in
    waitForPackages { packages in
      let packages = packages.filter { $0.isInstalled && $0.name == name }
      packages.forEach { $0.removeAndReport() }
    }
  }

  $0.command("update", description: "Update all installed plugins") {
    waitForPackages { packages in
      let packages = packages.filter { $0.isInstalled }
      packages.forEach { $0.updateAndReport() }
    }
  }
}.run()
