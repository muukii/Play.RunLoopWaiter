//
//  RunLoopWaiterTests.swift
//  RunLoopWaiterTests
//
//  Created by muukii on 2020/10/08.
//

import XCTest

@testable import RunLoopWaiter

class RunLoopWaiterTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    measure {
      let group = DispatchGroup()
      group.enter()
      asyncTask {
        group.leave()
      }
      group.wait()
    }
  }

  func testWaitRunloop() throws {
    // This is an example of a performance test case.
    measure {
      RunLoop.current.wait { (fulfill) in
        self.asyncTask {
          fulfill(())
        }
      }
    }
  }

  func asyncTask(completion: @escaping () -> Void) {

    print("start operation")
    DispatchQueue.global().async {
      print("done operation")
      completion()
    }

  }
}
