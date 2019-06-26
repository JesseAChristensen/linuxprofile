'''
In jupyter: "%" is magical for a single line
            "%%" is magical for a single cell
'''

# upload example.py to pastebin and return the url
%pastebin example.py

# render static matplotlib plots within the jupyter notebook
%matplotlib inline
# render interactive matplotlib plots in jupyter notebook
%matplotlib notebook

# run a python module within the notebook
%run example.py

# write contents of cell to a file
%%writefile

# render cell contents as latex format
%%latex

# interactive debugger
%debug

# Wrap text in <div> tags in a green "success" block
<div class="alert alert-block alert-success">text</div>
# Wrap text in <div> tags in a yellow "warning" block
<div class="alert alert-block alert-warning">text</div>
# Wrap text in <div> tags in a blue "info" block
<div class="alert alert-block alert-info">text</div>
# Wrap text in <div> tags in a red "danger" block
<div class="alert alert-block alert-danger">text</div>


# render everything instead of just the outputs of a cell:
from IPython.core.interactiveshell import InteractiveShell
InteractiveShell.ast_node_interactivity = "all"


# Run python script and enter interactive mode afterwards
python -i example.py

# Do the above and run the following to debug further
import pdb
pdb.pm()
