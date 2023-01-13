import Foundation

public class NetworkWrapper {
    public enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case statusCode(Int)
        case decodingError
        case unexpectedError(Error)
    }

    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func request(with request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.unexpectedError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            guard 200...299 ~= httpResponse.statusCode else {
                completion(.failure(.statusCode(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unexpectedError(NSError())))
                return
            }

            completion(.success(data))
        }.resume()
    }

    public func request<T: Decodable>(with urlRequest: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        request(with: urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(.decodingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
