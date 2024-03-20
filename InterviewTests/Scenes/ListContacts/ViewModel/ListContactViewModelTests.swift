import XCTest
@testable import Interview

class ListContactsViewModelTests: XCTestCase {
    
    var viewModel: ListContactsViewModel!
    var mockService: MockContactService!
    
    override func setUp() {
        super.setUp()
        mockService = MockContactService()
        viewModel = ListContactsViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testLoadContactsSuccess() {
        let expectedContacts = [Contact(id: 1, name: "John", photoURL: "https://example.com/photo1.jpg")]
        mockService.mockResult = .success(expectedContacts)
        
        var loadedContacts: [Contact]?
        viewModel.loadContacts { result in
            switch result {
            case .success(let contacts):
                loadedContacts = contacts
            case .failure(let error):
                XCTFail("Expected success, but got failure with error: \(error.localizedDescription)")
            }
        }
        
        XCTAssertEqual(loadedContacts, expectedContacts, "Loaded contacts do not match expected contacts")
    }
    
    func testLoadContactsFailure() {
        let expectedError = NSError(domain: "TestError", code: 0)
        mockService.mockResult = .failure(expectedError)
        
        var receivedError: NSError?
        viewModel.loadContacts { result in
            switch result {
            case .success(_):
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                receivedError = error as NSError
            }
        }
        
        XCTAssertEqual(receivedError?.domain, expectedError.domain, "Received error domain does not match expected error domain")
        XCTAssertEqual(receivedError?.code, expectedError.code, "Received error code does not match expected error code")
    }
}
