import UIKit

final class RestaurantListTableViewDelegate: NSObject, UITableViewDelegate {
    // MARK: - Actions
    
    struct Actions {
        let onDidSelectRowAtIndexPath: (IndexPath) -> Void
    }
    var actions: Actions?
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        actions?.onDidSelectRowAtIndexPath(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RestaurantListView.cellSize
    }
}
