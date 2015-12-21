import Commander

Group {
  $0.command("install", description: "Install a plugin") { (name: String) in
    waitForPackages() { packages in
      let packages = packages.filter { $0.name == name }
      packages.forEach() { $0.installAndReport() }
    }
  }

  $0.command("list", description: "List installed plugins") {
    waitForPackages() { packages in
      let packages = packages.filter { $0.isInstalled }.map { $0.name as String }
      print(packages.joinWithSeparator("\n"))
    }
  }

  $0.command("uninstall", description: "Uninstall a plugin") { (name: String) in
    waitForPackages() { packages in
      let packages = packages.filter { $0.isInstalled && $0.name == name }
      packages.forEach() { $0.removeAndReport() }
    }
  }
}.run()
