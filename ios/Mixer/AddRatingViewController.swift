/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import React

class AddRatingViewController: UIViewController {
  
  var mixer: Mixer!
  var addRatingView: RCTRootView!
    
  @IBOutlet weak var closeButton: UIButton!
  
  var currentRating: Int {
    get {
      return UserDefaults.standard.integer(forKey: "currentRating-\(mixer.identifier)")
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "currentRating-\(mixer.identifier)")
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // TODO: Add React View
    addRatingView = MixerReactModule.sharedInstance.viewForModule(
        "AddRatingApp",
        initialProperties: ["identifier": mixer.identifier, "currentRating": currentRating])
    self.view.addSubview(addRatingView)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    // TODO: Layout React View
    addRatingView.frame = self.view.bounds
  }
  
  @IBAction func cancelButtonTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
    
}
