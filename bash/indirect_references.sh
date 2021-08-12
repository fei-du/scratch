#!/bin/bash -
# the actual notation is \$$var, usually preceded by an eval. this is called an indirect reference.
var=23
echo "\$var = $var"
echo "\$\$var = $$var"

# let us do it the right way.
a=letter
letter=z
echo "a = $a"
# the 'eval' forces an update of $a, sets it to the updated values of \$$a. So, we see why 'eval' so often shows up in indirect reference notation.
eval a=\$$a
echo "Now a = $a"

t=table_cell_3
table_cell_3=24
echo "table_cell_3 = $table_cell_3"
echo -n "dereferenced: "; eval echo \$$t
echo ${!t}

# indirect referencing in Bash is a multi-step process. First, take the name of a variable: varname. Then, reference it: $varname. then reference the reference: $$varname, then excape the first $: \$$varname. Finally, force a reevaluation of the expression and assign it: eval newvar=\$$varname.
# it gives bash a little of the functionality of pointers in C.
