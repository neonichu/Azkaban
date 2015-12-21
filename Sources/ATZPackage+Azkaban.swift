import Foundation

extension ATZPackage {
  private func synchronousAction(action: ((String?, CGFloat) -> (), (NSError?) -> ()) -> ()) -> NSError? {
    var error: NSError?

    makeSynchronous() { semaphore in
      action({ _, _ in print("") }) { err in
        error = err
        dispatch_semaphore_signal(semaphore)
      }
    }

    return error
  }

  private func install() -> NSError? {
    return synchronousAction(self.installWithProgress)
  }

  func installAndReport() {
    if isInstalled {
      print("\(name) is already installed")
    } else {
      if let error = install() {
        print("Failed to install \(name): \(error)")
      } else {
        print("Installed \(name)")
      }
    }
  }

  private func remove() -> NSError? {
    var error: NSError?

    makeSynchronous() { semaphore in
      self.removeWithCompletion() { err in
        error = err
        dispatch_semaphore_signal(semaphore)
      }
    }

    return error
  }

  func removeAndReport() {
    if let error = remove() {
      print("Failed to uninstall \(name): \(error)")
    } else {
      print("Uninstalled \(name)")
    }
  }
}
