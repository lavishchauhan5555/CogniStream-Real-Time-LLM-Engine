import dotenv from "dotenv"
dotenv.config()
import express from "express"
import path from "path";
import cors from "cors"
const app = express()
app.use(cors());

app.use(express.json());




const __dirname = new URL('.', import.meta.url).pathname;

// Serve static files
app.use(express.static(path.join(__dirname, "../client/dist")));

// Catch all routes → React app
app.use((req, res) => {
  res.sendFile(path.join(__dirname, "../client/dist/index.html"));
});




app.post("/api/chat", async (req, res) => {
  try {
    const response = await fetch("http://localhost:8000/chat", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        message: req.body.message,
      }),
    });

    const data = await response.json();

    res.json(data);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "FastAPI connection failed" });
  }
});



const port = process.env.PORT || 10000

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
