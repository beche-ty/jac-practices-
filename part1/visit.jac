node Person {
    has name: str;

    # Node's perspective: "When a Visitor visits me"
    can greet with Visitor entry {
        print(f"{self.name} says: Welcome, visitor!");
    }
}

walker Visitor {
    has visited: set = set();
    # Walker's perspective: "When I visit a Person"

    can start with `root entry {
        visit [-->];
    }

    can meet with Person entry {
        if here.name in self.visited{
            return;
        }

        self.visited.add(here.name);

        print(f"Visitor says: Hello, {here.name}!");
        visit [-->];
    }
}

with entry {
    alice = Person(name="Alice");
    bob =Person(name="Bob");
    carlo =Person(name="Carlo");

    root ++> alice;
    alice ++>bob;
    bob++>carlo;
    carlo ++>alice;

    root spawn Visitor();
}