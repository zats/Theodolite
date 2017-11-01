//
//  ViewController.swift
//  TheodoliteFeed
//
//  Created by Oliver Rickard on 10/28/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import UIKit

import Theodolite

class ViewController: UIViewController {
  
  override func loadView() {

    let hostingView = ComponentHostingView { () -> Component in
      return ScrollComponent {
        (NewsAggregationComponent {[
          URL(string: "https://newsapi.org/v1/articles?source=techcrunch&apiKey=8a3eb75ec47c4054aed11906b84b6b3e")!,
          URL(string: "https://newsapi.org/v1/articles?source=ars-technica&sortBy=top&apiKey=8a3eb75ec47c4054aed11906b84b6b3e")!,
          URL(string: "https://newsapi.org/v1/articles?source=bbc-news&sortBy=top&apiKey=8a3eb75ec47c4054aed11906b84b6b3e")!,
          URL(string: "https://newsapi.org/v1/articles?source=business-insider&sortBy=top&apiKey=8a3eb75ec47c4054aed11906b84b6b3e")!,
          URL(string: "https://newsapi.org/v1/articles?source=buzzfeed&sortBy=top&apiKey=8a3eb75ec47c4054aed11906b84b6b3e")!,
          URL(string: "https://newsapi.org/v1/articles?source=cnn&sortBy=top&apiKey=8a3eb75ec47c4054aed11906b84b6b3e")!,
          URL(string: "https://newsapi.org/v1/articles?source=hacker-news&sortBy=top&apiKey=8a3eb75ec47c4054aed11906b84b6b3e")!,
          ]},
         direction: .vertical,
         attributes: [])
      }
    }
    hostingView.backgroundColor = .white
    
    self.view = hostingView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
