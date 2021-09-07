const express = require("express");
const mongoose = require("mongoose");
var app = express();
var Data = require("./noteSchema");

mongoose.connect("mongodb://localhost/newDB");

mongoose.connection
  .once("open", () => {
    console.log("Connected to DB!");
  })
  .on("error", (error) => {
    console.log("Failed to connect " + error);
  });

// create note
app.post("/create", (req, res) => {
  var note = new Data({
    note: req.get("note"),
    title: req.get("title"),
    date: req.get("date"),
  });

  note.save().then(() => {
    if (note.isNew == false) {
      console.log("Saved data!");
      res.send("Saved data!");
    } else {
      console.log("Failed to save data.");
    }
  });
});

// fetch all notes
app.get("/fetch", (req, res) => {
  Data.find({}).then((DBitems) => {
    res.send(DBitems);
  });
});

// delete a note
app.post("/delete", (req, res) => {
  Data.findOneAndRemove(
    {
      _id: req.get("id"),
    },
    (err) => {
      console.log("Failed " + err);
    }
  );
  res.send("Deleted!");
});

// update a note
app.post("/update", (req, res) => {
  Data.findOneAndUpdate(
    {
      _id: req.get("id"),
    },
    {
      note: req.get("note"),
      title: req.get("title"),
      date: req.get("date"),
    },
    (err) => {
      console.log("Failed to update " + err);
    }
  );
  res.send("Updated!");
});

var server = app.listen(8081, "192.168.1.223", () => {
  console.log("Server is running.");
});
