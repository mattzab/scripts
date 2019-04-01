awk '/^\$\$\$/{k=$0;next}{g[k]=g[k]"\n"$0}END{for(k in g)print k g[k]}' file1 file2
