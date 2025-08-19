// server.js - keep-alive web server
const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => res.send("✅ Bot is running 24/7"));
app.listen(PORT, () => console.log(`Keep-alive server running on port ${PORT}`));
