var express = require('express');

var app = express();

app.all('/*', function(req, res, next) {
    res.header('Access-Control-Allow-Origin', "*");
    res.header('Access-Control-Allow-Headers', "X-Requested-With");
    next();
});

app.get('/users/:userId', function(req, res) {
  res.send({
      userId:req.params.userId,
      fname:"John",
      lname:"Giannakos",
      email: "j@jtgi.me",
      rooms:[
          { room: { title: "Room 1" }},
          { room: { title: "Room 2" }}
      ]
  });
});

app.get('/user', function(req, res) {
  res.send(
      {
          fname:"John",
          lname:"Giannakos",
          email: "j@jtgi.me",
          rooms:[
              { room: { title: "Room 1" }},
              { room: { title: "Room 2" }}]

      });
});

 app.get('/users', function(req, res) {
  res.send([
      {
          fname:"John",
          lname:"Giannakos",
          email: "j@jtgi.me",
          rooms:[
              { room: { title: "Room 1" }},
              { room: { title: "Room 2" }}]
      },
      {
          fname:"James",
          lname:"Brown",
          email: "j@email.me",
          rooms:[
              { room: { title: "Room 1" }},
              { room: { title: "Room 2" }}]
      }
  ]);
});

app.post('/users/sign_in', function(req, res) {
    res.cookie('signed_in', '1', {maxAge: 900000, httpOnly: false});
    res.send({email: "j@jtgi.me"});
});

app.post('/users/sign_out', function(req, res) {
    res.cookie('signed_in', '0', {httpOnly: false});
});

app.get('/users/:id/rooms', function(req, res) {
  res.send([
    {room:{
      id:1,
      name:"Chris' Room",
      description:"Description of my room",
      owned:true
    }},
    {room:{
      id:2,
      name:"Test",
      description:"My room bitch niz",
      owned:false
    }}
 
  ]);
});

app.get('/rooms/:id', function(req, res) {
    res.send(
     {room:{
      id:req.params.id,
      name:"Test",
      description:"My room bitch niz",
      owned:false
     }}
    );
});

app.get('/rooms/:id/polls', function(req, res) {
    res.send(
     {poll:{
      id:12,
      title:"Poll Test 1",
      status: "OPEN",
      pollOptions: [
          {pollOption: {
              label: "A",
              answer: "The is option A",
              voteCount: Date.getSeconds()
          }},
          {pollOption: {
              label: "B",
              answer: "This is option B",
              voteCount: Date.getMilliseconds() % 100
          }}
      ],
      userVoted: false
     }},
     {poll:{
      id:12,
      title:"Poll Test 2",
      status: "CLOSED",
      pollOptions: [
          {pollOption: {
              label: "A",
              answer: "The is option A",
              voteCount: Date.getSeconds()
          }},
          {pollOption: {
              label: "B",
              answer: "This is option B",
              voteCount: Date.getMilliseconds() % 100
          }}
      ],
      userVoted: false
     }}
    );
});


app.get('/polls/:id', function(req, res) {
    res.send(
     {poll:{
      id:req.params.id,
      title:"Poll Test 1",
      status: "OPEN",
      pollOptions: [
          {pollOption: {
              label: "A",
              answer: "The is option A",
              voteCount: Date.getSeconds()
          }},
          {pollOption: {
              label: "B",
              answer: "This is option B",
              voteCount: Date.getMilliseconds() % 100
          }}
      ],
      userVoted: false
     }}
    );
});

app.listen(8000);
console.log('Listening on port 8000...');
