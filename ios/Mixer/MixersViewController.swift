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

class MixersViewController: UITableViewController {
  
  var mixers = [Mixer]()
  
  // MARK: - Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    mixers = Mixer.loadAllMixers()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 100.0
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.tableFooterView = UIView()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return mixers.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MixerCell", for: indexPath) as! MixerCell
    let mixer = mixers[(indexPath as NSIndexPath).row] as Mixer
    cell.mixer = mixer
    return cell
  }
  
   // MARK: - Navigation
  
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let selectedCell = sender as? UITableViewCell, let selectedRowIndex = (tableView.indexPath(for: selectedCell) as NSIndexPath?)?.row
      , segue.identifier == "showMixerDetailsSegue" else {
        fatalError("sender is not a UITableViewCell or was not found in the tableView, or segue.identifier is incorrect")
    }
    
    let mixer = mixers[selectedRowIndex]
    let detailViewController = segue.destination as! MixerDetailsViewController
    detailViewController.mixer = mixer
   }
  
}
