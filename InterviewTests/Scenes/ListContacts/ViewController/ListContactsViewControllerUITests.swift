import XCTest
@testable import Interview

class ListContactsViewControllerUITests: XCTestCase {
    
    var viewController: ListContactsViewController!
    
    override func setUp() {
        super.setUp()
        viewController = ListContactsViewController()
        _ = viewController.view
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testTableViewExists() {
        XCTAssertNotNil(viewController.tableView, "Table view should exist")
    }
    
    func testTableViewDataSourceIsSet() {
        XCTAssertNotNil(viewController.tableView.dataSource, "Table view data source should be set")
        XCTAssertTrue(viewController.tableView.dataSource is ListContactsViewController, "Table view data source should be set to ListContactsViewController")
    }
    
    func testTableViewDelegateIsSet() {
        XCTAssertNotNil(viewController.tableView.delegate, "Table view delegate should be set")
        XCTAssertTrue(viewController.tableView.delegate is ListContactsViewController, "Table view delegate should be set to ListContactsViewController")
    }
    
    func testActivityIndicatorExists() {
        XCTAssertNotNil(viewController.activity, "Activity indicator should exist")
    }
}
