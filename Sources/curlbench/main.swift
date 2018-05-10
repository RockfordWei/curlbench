import PerfectCURL
import Dispatch

struct Headers: Codable {
  var connection = ""
  var host = ""
  var extra = ""
  var extra2 = ""
  private enum CodingKeys: String, CodingKey {
    case connection = "Connection"
    case host = "Host"
    case extra = "X-Extra"
    case extra2 = "X-Extra-2"
  }
}
struct HeaderJSON: Codable {
  var headers = Headers()
}

func testCURL(_ id: Int) -> Int {
  let url = "https://httpbin.org/headers"
  let accept = CURLRequest.Header.Name.accept
  let custom = CURLRequest.Header.Name.custom(name: "X-Extra")
  let custom2 = CURLRequest.Header.Name.custom(name: "X-Extra-2")
  let customValueFalse = "notValue123"
  let customValue = "value123"

  let g = DispatchGroup()
  g.enter()
  var success = 0
  CURLRequest(url, .failOnError, .addHeader(custom, customValueFalse),
              .addHeader(custom2, ""), .removeHeader(accept),
              .replaceHeader(custom, customValue))
    .perform {
      confirmation in
      do {
        let response = try confirmation()
        let headerJSON = try response.bodyJSON(HeaderJSON.self)
        success = headerJSON.headers.extra == "notValue123,value123" ? 1: 0
      } catch {
        success = 0
      }
      g.leave()
  }
  g.wait()
  return success
}

var total = 0
let loops: Int
if CommandLine.argc > 1 {
  loops = Int(CommandLine.arguments[1]) ?? 10
} else {
  loops = 10
}
print("testing", loops, "loops")
for i in 0 ..< loops {
  total += testCURL(i)
}
print("success: ", total)
