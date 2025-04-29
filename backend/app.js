const express = require('express');
const AWS = require('aws-sdk');
const cors = require('cors');
require('dotenv').config();

AWS.config.update({ region: 'us-east-1' });
const dynamoDB = new AWS.DynamoDB.DocumentClient();
const app = express();
app.use(express.json());
app.use(cors());

app.get('/health', (req, res) => res.send('OK'));

app.post('/submit', (req, res) => {
  const { name, age, surname } = req.body;

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
      console.error(err);
      res.status(500).send('Error saving to DynamoDB');
    } else {
      res.send('Data saved successfully');
    }
  });
});

app.listen(3000, () => console.log('Server running on port 3000'));
