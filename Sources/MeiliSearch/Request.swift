import Foundation

internal protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func execute(
        with request: URLRequest,
        completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

internal protocol URLSessionDataTaskProtocol {
    func resume()
}

final class Request {

    private let config: Config
    private let session: URLSessionProtocol

    init(config: Config) {
        self.config = config
        self.session = config.session
    }

    func get(
        api: String,
        param: String? = nil,
        _ completion: @escaping (Result<Data?, Swift.Error>) -> Void) {

        var urlString: String = config.url(api: api)
        if let param: String = param, !param.isEmpty {
            urlString += param
        }

        var request: URLRequest = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"

        let task: URLSessionDataTaskProtocol = session.execute(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(data))
        }

        task.resume()
    }

    func post(
        api: String,
        body: Data,
        _ completion: @escaping (Result<Data, Swift.Error>) -> Void) {

        let urlString: String = config.url(api: api)
        var request: URLRequest = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.httpBody = body

        let task: URLSessionDataTaskProtocol = session.execute(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                return
            }
            completion(.success(data))
        }

        task.resume()

    }

    func put(
        api: String,
        body: Data,
        _ completion: @escaping (Result<Data, Swift.Error>) -> Void) {

        let urlString: String = config.url(api: api)
        var request: URLRequest = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "PUT"
        request.httpBody = body

        let task: URLSessionDataTaskProtocol = session.execute(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                return
            }
            completion(.success(data))
        }

        task.resume()

    }

     func delete(
        api: String,
        _ completion: @escaping (Result<Data?, Swift.Error>) -> Void) {

        let urlString: String = config.url(api: api)
        var request: URLRequest = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "DELETE"

        let task: URLSessionDataTaskProtocol = session.execute(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(data))
        }

        task.resume()

    }

}

struct Ping {

  static func pong(_ url: URL) -> Bool {

      let lock: NSLock = NSLock()
      var sucess: Bool = false

      let task: URLSessionDataTaskProtocol = URLSession.shared.dataTask(with: url) { (_, _, error) in
          if error == nil {
              sucess = true
          }
          lock.unlock()
      }

      task.resume()
      lock.lock()
      return sucess
  }

}

extension URLSession: URLSessionProtocol {
    internal func execute(
        with request: URLRequest,
        completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        self.dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
