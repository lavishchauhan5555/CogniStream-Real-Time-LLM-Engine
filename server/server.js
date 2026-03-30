import dotenv from "dotenv"
dotenv.config()
import express from "express"
import path from "path";
import cors from "cors"
const app = express()
app.use(cors());
const port = process.env.PORT || 10000

app.get('/', (req, res) => {
  res.send('Hello World!')
})


// static serv client files

app.use((req, res) => {
  res.sendFile(path.join(process.cwd(), "../client/dist/index.html"));
});

app.use(express.json());

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

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
