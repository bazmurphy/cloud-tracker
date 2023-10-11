const responseContainer = document.getElementById("response-container");
const apiLinks = document.querySelectorAll(".api-link");

apiLinks.forEach((apiLink) => {
  apiLink.addEventListener("click", async (event) => {
    event.preventDefault();
    while (responseContainer.firstChild) {
      responseContainer.removeChild(responseContainer.firstChild);
    }
    try {
      const response = await fetch(event.target.href);
      const data = await response.json();
      const jsonFormatted = JSON.stringify(data, null, 2);
      const preBlock = document.createElement("pre");
      if (jsonFormatted.includes(`"success": true,`)) {
        preBlock.className = "response-success";
      } else if (jsonFormatted.includes(`"error": true,`)) {
        preBlock.className = "response-error";
      }
      preBlock.innerText = jsonFormatted;
      responseContainer.append(preBlock);
    } catch (error) {
      console.error(error);
    }
  });
});
