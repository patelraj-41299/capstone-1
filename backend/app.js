const express = require('express');
const AWS = require('aws-sdk');
const cors = require('cors');
require('dotenv').config();

// 👇 TEMPORARY: Use .env credentials (for testing only)
AWS.config.update({
  region: 'us-east-1',
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
});

const dynamoDB = new AWS.DynamoDB.DocumentClient();
const app = express();
app.use(express.json());
app.use(cors());

app.get('/health', (req, res) => res.send('OK'));

app.post('/submit', (req, res) => {
  const { name, age, surname } = req.body;

  console.log("Received:", name, age, surname); // 👈 log for debug

  const params = {
    TableName: 'mytable',
    Item: {
      id: Date.now().toString(),
      name,
      age,
      surname
    }
  };

  dynamoDB.put(params, (err) => {
    if (err) {
      console.error('DynamoDB Error:', err); // 👈 log error
      res.status(500).send('Error saving to DynamoDB');
    } else {
      res.send('Data saved successfully');
    }
  });
});

app.listen(3000, () => console.log('Server running on port 3000'));
