match command.split():
# ^ @keyword.conditional
    case ["quit"]:
    # ^ @keyword.conditional
        print("Goodbye!")
        quit_game()
    case ["look"]:
    # ^ @keyword.conditional
        current_room.describe()
    case ["get", obj]:
    # ^ @keyword.conditional
        character.get(obj, current_room)
    case ["go", direction]:
    # ^ @keyword.conditional
        current_room = current_room.neighbor(direction)
    # The rest of your commands go here

match command.split():
# ^ @keyword.conditional
    case ["drop", *objects]:
    # ^ @keyword.conditional
        for obj in objects:
            character.drop(obj, current_room)

match command.split():
# ^ @keyword.conditional
    case ["quit"]: ... # Code omitted for brevity
    case ["go", direction]: pass
    case ["drop", *objects]: pass
    case _:
        print(f"Sorry, I couldn't understand {command!r}")
                                                   # ^^ @@function.macro

match command.split():
# ^ @keyword.conditional
    case ["north"] | ["go", "north"]:
    # ^ @keyword.conditional
        current_room = current_room.neighbor("north")
    case ["get", obj] | ["pick", "up", obj] | ["pick", obj, "up"]:
    # ^ @keyword.conditional
        pass

match = 2
#   ^ @variable
match, a = 2, 3
#   ^ @variable
match: int = secret
#   ^ @variable
x, match: str = 2, "hey, what's up?"
# <- @variable
#   ^ @variable
