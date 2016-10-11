import PerfectHTTP

public class People {
    var data = [Person]()

    init() {
        data = [
        Person(firstName: "Sarah", lastName: "Conner", email: "sarah.conner@mailinator.com"),
        Person(firstName: "John", lastName: "Conner", email: "jane.smith@mailinator.com"),
        Person(firstName: "Kyle", lastName: "Reese", email: "kyle.reese@mailinator.com"),
        Person(firstName: "Marcus", lastName: "Wright", email: "marcus.wright@mailinator.com")
        ]
    }

    public func list() -> String {
        return toString()
    }

    public func add(_ request: HTTPRequest) -> String {
        let new = Person(
            firstName: request.param(name: "firstName")!,
            lastName: request.param(name: "lastName")!,
            email: request.param(name: "email")!
        )
        data.append(new)
        return toString()
    }

    public func add(_ json: String) -> String {
        do {
            let incoming = try json.jsonDecode() as! [String: String]
            let new = Person(
                firstName: incoming["firstName"]!,
                lastName: incoming["lastName"]!,
                email: incoming["email"]!
            )
            data.append(new)
        } catch {
            return "ERROR"
        }
        return toString()
    }

    private func toString() -> String {
        var out = [String]()

        for m in self.data {
            do {
                out.append(try m.jsonEncodedString())
            } catch {
                print(error)
            }
        }
        return "[\(out.joined(separator: ","))]"
    }

}
