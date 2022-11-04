import UIKit

final class RestaurantListTableViewDataSource: NSObject, UITableViewDataSource {
    // MARK: - Properties
    
    var items: [Restaurant] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantCellView.identifier, for: indexPath) as! RestaurantCellView
        let itemCellModel = items[indexPath.row]
//        cell.configure(with: itemCellModel)
        return cell
    }
}
