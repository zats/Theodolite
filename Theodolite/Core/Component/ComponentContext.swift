//
//  ComponentContext.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/29/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

internal func GetContext(_ component: Component) -> ComponentContextProtocol? {
  return getAssociatedObject(object: component, associativeKey: &kWrapperKey)
}

public protocol MountInfoProtocol {
  var mountContext: MountContext? {get set}
  var mountedLayout: Layout? {get set}
}

public struct MountInfo<ViewType: UIView>: MountInfoProtocol {
  public var currentView: ViewType? = nil
  public var mountContext: MountContext? = nil
  public var mountedLayout: Layout? = nil
}

public struct LayoutInfo {
  /** We can't store a ref to the Layout directly because that would form a retain cycle. */
  let constraint: SizeRange
  let size: CGSize
  let children: [LayoutChild]
  let extra: Any?
}

/** To allow use of the component context's mount info outside of Components where the typealiases are defined. */
public protocol ComponentContextProtocol {
  var untypedMountInfo: MountInfoProtocol {get set}
  var layoutInfo: Atomic<LayoutInfo?> {get}
}

/** The bag of information needed by the framework to do its work. This is an implementation detail of the framework */
public class ComponentContext<PropType, ViewType: UIView>: ComponentContextProtocol {
  public var untypedMountInfo: MountInfoProtocol {
    get {
      return self.mountInfo
    }
    set(newValue) {
      self.mountInfo = newValue as! MountInfo<ViewType>
    }
  }
  
  let props: PropType?
  let key: AnyHashable?
  
  public var mountInfo: MountInfo<ViewType>
  public var layoutInfo: Atomic<LayoutInfo?>
  
  init(props: PropType?,
       key: AnyHashable?) {
    self.props = props
    self.key = key
    self.mountInfo = MountInfo()
    self.layoutInfo = Atomic(nil)
  }
}

internal var kWrapperKey: Void?