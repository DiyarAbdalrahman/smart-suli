const express = require("express");
const { json } = require("body-parser");
const app = express();
const path = require("path");
const mysql = require("mysql");
const port = 1331;

app.set("view engine", "ejs");
app.use(express.static(path.join(__dirname, "public")));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

const con = mysql.createConnection({
  port: 1234,
  host: "127.0.0.1",
  user: "root",
  password: "",
  database: "hospitals",
});

con.connect((err) => {
  if (err) throw err;
  console.log("db and server are connected");
});

//login path

app.get("/login", (req, res) => {
  console.log("hey from login");
  res.render("login");
});

app.post("/login", (req, res) => {
  const { Lusername, Lpassword } = req.body;

  const sql = `SELECT * FROM hospitals WHERE username = ? AND password_hash = ?`;
  con.query(sql, [Lusername, Lpassword], (err, result) => {
    if (err) throw err;

    if (result.length > 0) {
      res.status(200).redirect("/");
    } else {
      res.send("Invalid username or password");
    }
  });
});

//Home path
app.get(["/", "/home", "/Home"], (req, res) => {
  console.log("hey from home");
  res.sendFile(path.join(__dirname, "index.html"));
});

//store patient path

app.post("/store", (req, res) => {
  console.log("store in db path");
  var sql = `Insert into patient_information(patient_id, patient_name, disease_name, test_result_date, test_result) values ('${req.body.pid}', '${req.body.pname}', '${req.body.diseaseName}','${req.body.infoDate}','${req.body.testResult}')`;
  con.query(sql, (err, results) => {
    if (err) throw err;
    console.log("data is stored in db");
  });
  res.redirect("/");
});
//show data path
app.get("/show", (req, res) => {
  con.query("SELECT * FROM patient_information", (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: "Internal Server Error" });
      return;
    }
    res.json(results);
  });
});
//

app.listen(port, () => {
  console.log(`Now we are on port ${port}`);
});
