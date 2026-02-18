# Search & Destroy (for macOS)
snd - Search and destroy files or directories interactiely
Copyright (c) 2026 Yu-Sung Chang. Released under the MIT License.

Usage: snd [OPTIONS] <STRING>

Arguments:
  STRING       String to match (e.g. "microgsoft" creates the pattern "*microsoft*")
  
Options:
  -t TYPE      Search type: f (file), d (directory) [Default: both]
  -e STRING    Ignore matches containing this string (e.g. "com.apple")
  -p FOLDER    Skip/Prune an entire directory (e.g. "CloudStorage")
  -h           Display this help and exit
  -v           Display version and exit

Interface Controls:
  Arrows       Move selection
  TAB          Select multiple items for deletion
  ENTER        Confirm selection and delete
  ESC          Quit without deleting

Example:
  snd microsoft             # Find files AND directories containing 'microsoft'.
  snd -t d -e apple plugin  # Find directories containing 'plug-in' but not 'apple'.
