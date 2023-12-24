try:
    print(1 / 0)
except Exception:
    raise RuntimeError from None
    # ^ @keyword.exception
    #                   ^ @keyword.exception
