import subprocess

def run_chrome_container(url):
    command = f"docker run -e URL={url} -it chrome"
    subprocess.run(command, shell=True, check=True)

url = input("Enter the URL to open in Chrome: ")
run_chrome_container(url)
