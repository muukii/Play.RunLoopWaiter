//
//  ContentView.swift
//  RunLoopWaiter
//
//  Created by muukii on 2020/10/08.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Text("Hello, world!")
        .padding()
      Button("start") {
        _await3()
      }
    }
  }
}

func _await() {

  let waiter = Waiter()

  let exp = Expectation()

  asyncTask {
    exp.fulfill()
  }

  print("start wait")
  waiter.wait(for: [exp])
  print("end wait")

}

func _await2() {

  print(1)
  RunLoop.current.wait(resultType: Void.self) { (fulfill) in
    print(2)
    asyncTask {
      print(3)
      fulfill(())
    }
  }
  print(4)

}

func _await3() {


  DispatchQueue.global().async {
    print(1)
    RunLoop.current.wait(resultType: Void.self) { (fulfill) in
      print(2)
      asyncTask {
        print(3)
        fulfill(())
      }
    }
    print(4)
  }


}

func asyncTask(completion: @escaping () -> Void) {

  print("start operation")
  DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
    print("done operation")
    completion()
  }

}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
