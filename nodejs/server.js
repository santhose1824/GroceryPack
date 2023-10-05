const mysql = require('mysql2');
const express = require('express');
const app = express();
app.use(express.json());

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'password', // Update with your MySQL password
  database: 'GP',
});

app.post('/login', (req, res) => {
  const { email, password } = req.body;

  // Check if the provided username and password match the records in the database
  const query = 'SELECT * FROM users WHERE email = ? AND pass = ?';
  db.query(query, [email, password], (error, results) => {
    if (error) throw error;

    if (results.length > 0) {
      // Successful login
      res.status(200).json({ message: 'Login successful' });
    } else {
      // Invalid username or password
      res.status(401).json({ message: 'Invalid username or password' });
    }
  });
});

app.post('/register', (req, res) => {
  const { name, email, dateOfBirth, mobileNumber, password, address, profileImage } = req.body;

  const sql = 'INSERT INTO users (username, email, address, phone, pass, profilepic, dob) VALUES (?, ?, ?, ?, ?, ?, ?)';
  const values = [name, email, address, mobileNumber, password, profileImage, dateOfBirth];

  db.query(sql, values, (err, results) => {
    if (err) {
      console.error('Error inserting data into MySQL:', err);
      res.status(500).json({ error: 'Failed to store data' });
    } else {
      res.status(200).json({ message: 'Data stored successfully' });
    }
  });
});

db.connect((err) => {
  if (err) {
    console.error('Error connecting to MySQL:', err);
    return;
  }
  console.log('Connected to MySQL database');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
