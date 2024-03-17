import subprocess

chmod = "chmod +x ~/data/Main.sh"
sh = "sh ~/data/Main.sh"

subprocess.run(chmod, shell=True, capture_output=True, text=True)
subprocess.run(sh, shell=True, capture_output=True, text=True)