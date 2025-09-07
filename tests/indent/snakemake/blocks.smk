rule A:
    """doc"""

if True:
    rule B:
        """doc"""

use rule other from somewhere

use rule other2 from somewhere as other_alias

use rule other3 from somewhere with:
    input: 2

use rule other4 from somewhere as other_alias2 with:
    input: 2

checkpoint C:
    input: "1"

module A:
    snakefile: "x.smk"
