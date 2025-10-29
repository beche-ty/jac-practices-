node Person {
    has name: str;
}

walker Greeter {
    # runs when walker spawns at root 
    can start with `root entry {
        print("Walker starting journey!");
        visit [-->];  # Visit all connected nodes
    }
    # runs when walker visits Person nodes

    can greet with Person entry {
        print(f"Hello, {here.name}!");
        # here -curent node being visited
        visit [-->];  # Visit this person's connections
    }
    can jump with Person entry {
        print(f"{here.name} says: Jumping to the next person!");
        visit [-->];  # Continue to the next person
    }
}

with entry {
    # Build graph
    alice = Person(name="Alice");
    bob = Person(name="Bob");
    charlie = Person(name="Charlie");

    root ++> alice ++> bob ++> charlie;

    # Spawn walker
    root spawn Greeter();
}