const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.json({
    message: "Cloud Native SRE Platform Running",
    status: "healthy"
  });
});

app.get('/health', (req, res) => {
  res.status(200).send("OK");
});

app.listen(port, () => {
  console.log(`App running on port ${port}`);
});