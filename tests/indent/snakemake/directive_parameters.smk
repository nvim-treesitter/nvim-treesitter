rule A:
    input: a
    output: b
    params:
        a = 1,
        b = 2,
        c = 3
    shell:
        """
        touch {output}
        """

rule B:
    input: a,
    output: a,
        b
    params:

rule C:
    # test dedent after variably nested nodes
    params:
        1
    params:
        "1"
    params:
        a = 1
    params:
        a = "1"
    params:
        a = call(1)
    params:
        a = call("1")
    params:
        a = config["a"]
    params:
        b = call(config["a"])
