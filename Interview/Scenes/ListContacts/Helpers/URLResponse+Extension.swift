import Foundation

extension URLResponse {
    func isHTTPStatusCodeValid() -> Bool {
        guard let httpResponse = self as? HTTPURLResponse else {
            return false
        }
        return (200...299).contains(httpResponse.statusCode)
    }
}
