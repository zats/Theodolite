//
//  NewsNetworkSourceComponent.swift
//  TheodoliteFeed
//
//  Created by Oliver Rickard on 10/30/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Flexbox
import Theodolite

final class NewsNetworkSourceComponent: Component, TypedComponent {
  typealias PropType = (
    name: String,
    latestNewsSource: NewsNetworkSource,
    topNewsSource: NewsNetworkSource,
    loadedAction: Action<Bool>,
    navigationCoordinator: NavigationCoordinator
  )
  typealias StateType = (
    newsItems: [NewsItem],
    didInitiateFetch: Bool
  )

  override func render() -> [Component] {

    self.fetchIfNeeded()
    

    guard let state = self.state else {
      return []
    }

    if state.newsItems.count == 0 {
      return []
    }

    var children: [FlexChild] = []

    children.append(FlexChild(
      LabelComponent(
        (props.name,
         options: LabelComponent.Options(font:
          UIFont(name: "Georgia",
                 size: 40)!))
    ), margin: Edges.init(left: 20, right: 20, top: 10, bottom: 0)))

    children.append(FlexChild(NewsNetworkSourceHScrollComponent(
      key: props.latestNewsSource.url,
      (networkSource: props.latestNewsSource,
       navigationCoordinator: props.navigationCoordinator)
    )))
    
    let first = state.newsItems.first!
    children.append(FlexChild(NewsItemFeaturedComponent(key: first.url, (first, navigationCoordinator: props.navigationCoordinator))))
    children.append(contentsOf: state.newsItems[1..<state.newsItems.count]
      .map {(item: NewsItem) -> FlexChild in
        return FlexChild(NewsItemComponent(key: item.url, (item, navigationCoordinator: props.navigationCoordinator)))
    })

    return [
      FlexboxComponent(
        (options: FlexOptions(flexDirection: .column),
         children: children)
      )
    ]
  }

  func fetchIfNeeded() {
    if !(self.state?.didInitiateFetch ?? false) {
      self.updateState(state: (newsItems: [], didInitiateFetch: true))
      self.props.topNewsSource.fetchItems({ (result) in
        self.props.loadedAction.send(true)
        switch result {
        case .error(let string):
          print("error: \(string)")
          break
        case .success(let newsItems):
          self.updateState(state: (newsItems:newsItems, didInitiateFetch: true))
          break
        }
      })
    }
  }
}
