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

import Foundation

struct Mixer {
  let identifier: Int
  let name: String
  let detail: String
  let location: String
  let thumbnail: String
  let attendeeRating: Int
}

// MARK: - Support for loading data from plist

extension Mixer {
  
  static func loadAllMixers() -> [Mixer] {
    return loadMixers(from: "Mixers")
  }
  
  fileprivate static func loadMixers(from plistName: String) -> [Mixer] {
    guard
      let path = Bundle.main.path(forResource: plistName, ofType: "plist"),
      let dictArray = NSArray(contentsOfFile: path) as? [[String : AnyObject]]
      else {
        fatalError("An error occurred while reading \(plistName).plist")
    }
    
    var mixers = [Mixer]()
    
    for dict in dictArray {
      guard
        let identifier = dict["identifier"] as? Int,
        let name = dict["name"] as? String,
        let detail = dict["detail"] as? String,
        let location = dict["location"] as? String,
        let thumbnail = dict["thumbnail"] as? String,
        let attendeeRating = dict["attendeeRating"] as? Int
        else {
          fatalError("Error parsing dict \(dict)")
      }
      
      let mixer = Mixer(
        identifier: identifier,
        name: name,
        detail: detail,
        location: location,
        thumbnail: thumbnail,
        attendeeRating: attendeeRating
      )
      
      mixers.append(mixer)
    }
    
    return mixers
  }
}
