const express = require("express");
const bodyParser = require("body-parser");
const db = require("./db");

const app = express();
app.use(bodyParser.json());

// ===== CONTACTS =====
app.post("/contacts", (req, res) => {
  const { name, email, phone } = req.body;
  db.query(
    "INSERT INTO contacts (name, email, phone) VALUES (?, ?, ?)",
    [name, email, phone],
    (err, result) => {
      if (err) return res.status(500).send(err);
      res.send({ id: result.insertId, name, email, phone });
    }
  );
});
app.get("/contacts", (req, res) => {
  db.query("SELECT * FROM contacts", (err, results) => {
    if (err) return res.status(500).send(err);
    res.send(results);
  });
});

app.get("/contacts/:id", (req, res) => {
  db.query(
    "SELECT * FROM contacts WHERE id = ?",
    [req.params.id],
    (err, result) => {
      if (err) return res.status(500).send(err);
      res.send(result[0]);
    }
  );
});

app.put("/contacts/:id", (req, res) => {
  const { name, email, phone } = req.body;
  db.query(
    "UPDATE contacts SET name = ?, email = ?, phone = ? WHERE id = ?",
    [name, email, phone, req.params.id],
    (err) => {
      if (err) return res.status(500).send(err);
      res.send({ id: req.params.id, name, email, phone });
    }
  );
});

app.delete("/contacts/:id", (req, res) => {
  db.query("DELETE FROM contacts WHERE id = ?", [req.params.id], (err) => {
    if (err) return res.status(500).send(err);
    res.send({ message: "Contact deleted" });
  });
});

// ===== ADDRESSES =====
app.post("/contacts/:id/addresses", (req, res) => {
  const { address_line, city, zip_code } = req.body;
  db.query(
    "INSERT INTO addresses (contact_id, address_line, city, zip_code) VALUES (?, ?, ?, ?)",
    [req.params.id, address_line, city, zip_code],
    (err, result) => {
      if (err) return res.status(500).send(err);
      res.send({
        id: result.insertId,
        contact_id: req.params.id,
        address_line,
        city,
        zip_code,
      });
    }
  );
});

app.get("/contacts/:id/addresses", (req, res) => {
  db.query(
    "SELECT * FROM addresses WHERE contact_id = ?",
    [req.params.id],
    (err, results) => {
      if (err) return res.status(500).send(err);
      res.send(results);
    }
  );
});
