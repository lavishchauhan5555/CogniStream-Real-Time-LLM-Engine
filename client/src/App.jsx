import { useState } from 'react'

import './App.css'

function App() {

  const sendMessage = async () => {
    const res = await fetch("https://cognistream-real-time-llm-engine.onrender.com/api/chat", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ message: "Hello AI" }),
    });

    const data = await res.json();
    console.log(data);
  };
  return (
    <>
    <div>
      <button onClick={sendMessage}>send message </button>
    </div>

    </>
  )
}

export default App
