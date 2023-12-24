from foo import bar
# ^ @keyword.import
#           ^ @keyword.import
def generator():
    yield from bar(42)
    # ^ @keyword.return
    #       ^ @keyword.return
