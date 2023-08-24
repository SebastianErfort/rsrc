# Option 1: distinguish by file name
FILENAME == "file1" {}
FILENAME == "file2" {}

# Option 2 for two non-empty files: NR != FNR for file 2
FNR == NR {} # file 1
FNR != NR {} # file 2: NR includes line count of file 1
