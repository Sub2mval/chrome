// Add a context menu item to open links with Synchbit
document.addEventListener("contextmenu", (event) => {
  const link = event.target.closest("a");
  if (link) {
    event.preventDefault();
    const menu = new Menu();
    menu.append(
      new MenuItem({
        label: "Open with Synchbit",
        click: () => {
          // Run the YAML file to build the container
          runYAMLFile();
          // Pass the link's href to the Python script
          runPythonScript(link.href);
          // Open the container's output in a new tab
          window.open("http://localhost:6080");
        },
      })
    );
    menu.popup();
  }
});

// Function to run the YAML file
function runYAMLFile() {
  // Code to run the YAML file goes here
  // This would typically involve using a library like child_process
  // to run the 'docker-compose up' command
}

// Function to run the Python script
function runPythonScript(url){
  // Code to run the Python script goes here
  // This would typically involve using a library like child_process
  // to run the Python script and pass the URL as an argument
  const spawn = require('child_process').spawn;
  const pythonScript = spawn('python',['chrome.py', url]);
  pythonScript.stdout.on('data', (data) => {
    console.log(`stdout: ${data}`);
  });
  pythonScript.stderr.on('data', (data) => {
    console.error(`stderr: ${data}`);
  });
  pythonScript.on('close', (code) => {
    console.log(`child process exited with code ${code}`);
  });
}
