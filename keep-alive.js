const express = require("express");
const app = express();

// Use a different port than the bot (avoid conflict)
const PORT = process.env.KEEP_ALIVE_PORT || 3000;

app.get("/", (req, res) => {
  res.send("✅ Ragnarok Bot is alive!");
});

app.listen(PORT, () =>
  console.log(`🌐 Keep-alive server running on port ${PORT}`)
);
