//
//  CSStepper.swift
//  ios practice
//
//  Created by Truth on 2018. 1. 24..
//  Copyright © 2018년 k1mtruth. All rights reserved.
//

import UIKit

@IBDesignable
class CSStepper: UIControl {
  
  // MARK: Constants
  
  private struct Constant {
    static let borderWidth: CGFloat = 0.5
    static let borderColor: CGColor = UIColor.blue.cgColor
  }
  
  private struct Font {
    static let leftBtn = UIFont.boldSystemFont(ofSize: 20)
    static let rightBtn = UIFont.boldSystemFont(ofSize: 20)
    static let centerLabel = UIFont.systemFont(ofSize: 16)
  }
  
  // MARK: UI
  
  public var leftBtn: UIButton = {
    let button = UIButton(type: .system)
    button.tag = -1
    button.titleLabel?.font = Font.leftBtn
    button.layer.borderWidth = Constant.borderWidth
    button.layer.borderColor = Constant.borderColor
    return button
  }()
  public var rightBtn: UIButton = {
    let button = UIButton(type: .system)
    button.tag = 1
    button.titleLabel?.font = Font.rightBtn
    button.layer.borderWidth = Constant.borderWidth
    button.layer.borderColor = Constant.borderColor
    return button
  }()
  public var centerLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.textAlignment = .center
    label.backgroundColor = .cyan
    label.layer.borderWidth = Constant.borderWidth
    label.layer.borderColor = Constant.borderColor
    return label
  }()
  
  // MARK: Properties
  
  @IBInspectable public var maximumValue: Int = 100
  @IBInspectable public var minimumValue: Int = -100
  @IBInspectable public var stepValue: Int = 1
  
  @IBInspectable
  public var value: Int = 0 {
    didSet {
      self.centerLabel.text = String(value)
      
      self.sendActions(for: .valueChanged)
    }
  }
  
  @IBInspectable
  public var leftTitle: String = "⬇︎" {
    didSet {
      self.leftBtn.setTitle(leftTitle, for: .normal)
    }
  }
  
  @IBInspectable
  public var rightTitle: String = "⬆︎" {
    didSet {
      self.rightBtn.setTitle(rightTitle, for: .normal)
    }
  }
  
  @IBInspectable
  public var bgColor: UIColor = .cyan {
    didSet {
      self.centerLabel.backgroundColor = bgColor
    }
  }
  
  // MARK: Initializing
  
  /// 스토리보드에서 호출할 초기화 메소드
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
  }
  
  /// 프로그래밍 방식으로 호출할 초기화 메소드
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  public func setup() {
    self.leftBtn.setTitle(self.leftTitle, for: .normal)
    self.rightBtn.setTitle(self.rightTitle, for: .normal)
    self.centerLabel.text = String(value)
    
    /// 영역별 객체를 서브 뷰로 추가한다.
    self.addSubview(self.leftBtn)
    self.addSubview(self.rightBtn)
    self.addSubview(self.centerLabel)
    
    /// 버튼의 터치 이벤트와 valueChange(_:) 메소드를 연결한다.
    self.leftBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
    self.rightBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
  }
  
  // MARK: Layout
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    /// 버튼의 너비 = 뷰 높이
    let btnWidth = self.frame.height
    
    /// 레이블의 너비 = 뷰 전체 크기 - 양쪽 버튼의 너비 합
    let lblWidth = self.frame.width - (btnWidth * 2)
    
    self.leftBtn.frame = CGRect(x: 0, y: 0, width: btnWidth, height: btnWidth)
    self.centerLabel.frame = CGRect(x: btnWidth, y: 0, width: lblWidth, height: btnWidth)
    self.rightBtn.frame = CGRect(x: btnWidth + lblWidth, y: 0, width: btnWidth, height: btnWidth)
  }
  
  // MARK: Actions
  
  /// value 속성의 값을 변경하는 메소드
  @objc public func valueChange(_ sender: UIButton) {
    /// 스테퍼의 값을 변경하기 전에, 미리 최소값과 최대값 범위를 벗어나지 않는지 체크한다.
    let sum = self.value + (sender.tag * self.stepValue)
    if sum > self.maximumValue || sum < self.minimumValue {
      return
    }
    
    /// 현재의 value 값에 stepValue만큼 +, - 한다.
    self.value += (sender.tag * self.stepValue)
  }
}
