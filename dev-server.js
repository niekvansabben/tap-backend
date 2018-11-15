var mysql = require('mysql');
var http = require('http');
var url = require('url');
var fs = require('fs');


var debug = true;

var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "R00t",
    database: "tap"
    
});

con.connect(function(err) {
  if (err) {
    console.error('error connecting: ' + err.stack);
    return;
  }

  console.log('connected as id ' + con.threadId);
});

con.query("SELECT * FROM routes", function (err, result) {
    if (err) throw err;
    console.log(result);
  });

http.createServer(function (req, res) {
  var q = url.parse(req.url, true);

  if (debug) {
    console.log("");
    console.log("url: \t\t" + q.path);
    console.log("pathname: \t" + q.pathname); //returns '/default.htm'
    console.log("search: \t" + q.search); //returns '?year=2017&month=february'
    console.log("search object: \t" + JSON.stringify(q.query)); //returns an object: { year: 2017, month: 'february' }
    //console.log(q.query.month); //returns 'february'
    console.log("");
  }

  if(q.pathname == "/") {
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.write("<ul><li>/routes</li><li>/route?id=1</li><li>/static_json or /read_data</li></ul>");
    res.end();
  } 
    
    
    else if (q.pathname == "/routes") {
        
        res.writeHead(200, {'Content-Type': 'application/json'});
        con.query("SELECT * FROM routes;", function (err, result) {
            
            if (err) throw err;
            res.end(JSON.stringify(result));    
            console.log(result);
            
        });
  } 
    
    else if (q.pathname == "/route") {
        
        if (q.query.id != null && Number.isInteger(Number(q.query.id))) {
            
            con.query("SELECT * FROM routes WHERE id = ?;", [q.query.id], function (err, result) {

                if (err) throw err;
                res.writeHead(200, {'Content-Type': 'application/json'});
                res.end(JSON.stringify(result));    
                console.log(result);

            });
            
        } else {
            
            res.writeHead(200, {'Content-Type': 'text/html'});
            res.end("<h1>No input given</h1>");    
            console.log("No input given");
        }
  } 
    
    else if (q.pathname == "/read_data" || q.pathname == "/static_json") {
      fs.readFile('data.json', function(err, data) {
        res.writeHead(200, {'Content-Type': 'text/html'});
        res.write(data);
        res.end();
      });
  } 
    
    else {
    res.writeHead(404, {'Content-Type': 'text/html'});
    res.write("404 Not Found");
    res.end();
  }
}).listen(2121);