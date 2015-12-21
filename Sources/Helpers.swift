import AppKit

func makeSynchronous(block: (dispatch_semaphore_t) -> ()) {
  let semaphore = dispatch_semaphore_create(0)
  queue { block(semaphore) }
  dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
}

func queue(block: () -> ()) {
  let queue = NSOperationQueue()
  queue.addOperationWithBlock { block() }
}

func waitFor(block: () -> ()) {
  NSApplicationLoad()
  block()
  NSApp.run()
}
