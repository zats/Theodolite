//
//  NewsAggregationComponent.swift
//  TheodoliteFeed
//
//  Created by Oliver Rickard on 10/30/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Flexbox
import Theodolite

final class NewsAggregationComponent: TypedComponent {
  let context = ComponentContext()
  typealias PropType = [URL]
  typealias StateType = Int

  func render() -> [Component] {
    return [
      PullToRefreshComponent(key: state) {
        (action: Handler(self, NewsAggregationComponent.didPullToRefresh),
         component:
          FlexboxComponent {
            (options: FlexOptions(flexDirection: .column),
             children:
              props
                .map {(url: URL) -> FlexChild in
                  return FlexChild(
                    NewsNetworkSourceComponent(key: url) {
                      NewsNetworkSource(url: url)}
                  )
            })
          }
        )}
    ]
  }

  func didPullToRefresh(refreshControl: UIRefreshControl) {
    print("pulled to refresh")
    self.updateState(state: (state ?? 0) + 1)
    refreshControl.endRefreshing()
  }
}