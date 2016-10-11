import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

let server = HTTPServer()
var routes = Routes()

routes.add(method: .get, uri: "/") { request, response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
    response.completed()
}

routes.add(method: .get, uri: "/api/v1/people") { request, response in
    let people = People()

    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: people.list())
    response.completed()
}

routes.add(method: .post, uri: "/api/v1/people") { request, response in
    let people = People()

    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: people.add(request))
    response.completed()
}

routes.add(method: .post, uri: "/api/v1/people/json") { request, response in
	let people = People()

    response.setHeader(.contentType, value: "application/json")
    response.appendBody(string: people.add(request.postBodyString!))
    response.completed()
}

server.addRoutes(routes)

server.serverPort = 8080

do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
