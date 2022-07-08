## Source issue
```bash
/bin/sh: 1: source: not found
make: *** [Makefile:11: setup] Error 127
```

### Solution:
Replace `source` in the Make file with `.`

### Explanation from SOF:
/bin/sh is usually some other shell trying to mimic The Shell. Many distributions use /bin/bash for sh, it supports source. On Ubuntu, though, /bin/dash is used which does not support source. Most shells use . instead of source. If you cannot edit the script, try to change the shell which runs it.