import subprocess
import tkinter as tk
from tkinter import messagebox
chmod = "chmod +x ~/data/Main.sh"
sh = "sh ~/data/Main.sh"
subprocess.run(chmod, shell=True, capture_output=True, text=True)

def check_continue():
    result = messagebox.askquestion("Confirmation", "Do you want to continue?")
    if result == "yes":
        subprocess.run(sh, shell=True, capture_output=True, text=True)
        root.destroy()
    else:
        root.destroy()

root = tk.Tk()
root.title("Confirmation")

logo_image = tk.PhotoImage(file="~/data/logo.png")

logo_label = tk.Label(root, image=~logo_image)
logo_label.pack()

text_label = tk.Label(root, text="Do you want to continue?")
text_label.pack()

yes_button = tk.Button(root, text="Yes", command=check_continue)
yes_button.pack(side=tk.LEFT, padx=10)

no_button = tk.Button(root, text="No", command=check_continue)
no_button.pack(side=tk.RIGHT, padx=10)

root.mainloop()

