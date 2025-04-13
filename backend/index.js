require("dotenv").config();
const express = require("express");
const { ethers } = require("ethers");
const fs = require("fs");

const app = express();
app.use(express.json());

const abi = JSON.parse(fs.readFileSync("abi.json", "utf8"));

// Setup provider and signer
const provider = new ethers.JsonRpcProvider(process.env.INFURA_URL);
const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
const contract = new ethers.Contract(
    process.env.CONTRACT_ADDRESS,
    abi,
    wallet
);

app.post("/api/store-message", async (req, res) => {
    try {
        const { message } = req.body;
        const tx = await contract.storeMessage(message);
        await tx.wait();
        res.json({ success: true, txHash: tx.hash });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.get("/api/retrieve-message", async (req, res) => {
    try {
        const message = await contract.retriveMessage();
        res.json({ message });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.listen(process.env.PORT, () => {
    console.log(`Server running on port ${process.env.PORT}`);
});