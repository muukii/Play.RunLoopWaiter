//
//  RunLoopWaiter.swift
//  RunLoopWaiter
//
//  Created by muukii on 2020/10/08.
//

import Foundation

import Foundation

public final class Expectation {

  var fulfilled: Bool = false

  public func fulfill() {
    fulfilled = true
  }
}

public final class Waiter {

  private var runloop: RunLoop?

  func wait(for expectations: [Expectation]) {

    let runloop = RunLoop.current

    self.runloop = runloop

    var isFinished: Bool {
      !expectations.contains(where: { !$0.fulfilled })
    }

    while !isFinished {
      runloop.run(mode: .default, before: Date(timeIntervalSinceNow: 0.1))
    }

  }
}

extension RunLoop {

  public func wait<Result>(
    resultType: Result.Type? = nil,
    perform: @escaping (_ fullfill: @escaping (Result) -> Void) -> Void
  ) -> Result {

    var result: Result!

    let runLoopModeRaw = RunLoop.Mode.default.rawValue._bridgeToObjectiveC()
    let cfRunLoop = getCFRunLoop()

    CFRunLoopPerformBlock(getCFRunLoop(), runLoopModeRaw) {
      perform { r in
        result = r
        CFRunLoopPerformBlock(cfRunLoop, runLoopModeRaw) {
          CFRunLoopStop(cfRunLoop)
        }
        CFRunLoopWakeUp(cfRunLoop)
      }

    }

    CFRunLoopWakeUp(cfRunLoop)

    CFRunLoopRun()

    return result
  }
  
}

