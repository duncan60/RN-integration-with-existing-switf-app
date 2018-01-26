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

class MixerDetailsViewController: UIViewController {
  
  var mixer: Mixer!
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var detailLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var ratingImageView: UIImageView!
  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var myRatingLabel: UILabel!
  @IBOutlet weak var addRattingButton: UIButton!
  @IBOutlet weak var responseSegmentedControl: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Details"
    nameLabel.text = mixer.name
    detailLabel.text = mixer.detail
    locationLabel.text = mixer.location
    ratingImageView.image = imageForOverall(mixer.attendeeRating)
    thumbnailImageView.image = UIImage(named: mixer.thumbnail)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Current user rating is used to set UI controls and labels
    let currentRating = UserDefaults.standard.integer(forKey: "currentRating-\(mixer.identifier)")
    myRatingLabel.text = currentRating > 0 ? String(repeating: "★", count: currentRating) : "None"
    let addButtonTitle = currentRating > 0 ? "Change My Rating": "Add Rating"
    addRattingButton.setTitle(addButtonTitle, for: UIControlState())
    responseSegmentedControl.selectedSegmentIndex = currentRating > 0 ? 2 : 0
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    detailLabel.sizeToFit()
  }
  
  func imageForOverall(_ rating: Int) -> UIImage? {
    let imageName = "\(rating)Stars"
    return UIImage(named: imageName)
  }
  
  @IBAction func responseSegmentControlTapped(_ sender: UISegmentedControl) {
    // Attended button tapped
    if sender.selectedSegmentIndex == 2 {
      performSegue(withIdentifier: "showAddRatingSegue", sender: sender)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let addRatingViewController = segue.destination as! AddRatingViewController
    addRatingViewController.mixer = mixer
  }
  
}
