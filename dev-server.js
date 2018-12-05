var mysql = require('mysql');
var http = require('http');
var url = require('url');
var fs = require('fs');


var debug = true;

var con = mysql.createConnection({
    host: "206.189.106.84",
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
    res.write("<ul><li>/routes</li>");
    res.write("<ul><li>sort=rating/timestamp</li>");
    res.write("<li>sort=</li>");
    res.write("<li>time=n (Min)</li>");
    res.write("<li>distance=m (KM)</li></ul>");
    res.write("<li>/route?id=1</li>");
    res.write("<li>/static_json or /read_data</li></ul>");
    res.end();
  } 
    
    
    else if (q.pathname == "/routes") {
        
        res.writeHead(200, {'Content-Type': 'application/json'});
        
        var sql = "SELECT * FROM (SELECT routes.id, name, description, duration_time, duration_distance, avg(ratings.rating) as avg_rating FROM routes JOIN ratings ON routes.id = ratings.route_id GROUP BY routes.id ) as temp";
        var sql_values = [];
        
        if(q.query.time != null) {
            
            sql = sql + " WHERE duration_time <= ?";
            sql_values.push(q.query.time);
            
            if(q.query.distance != null) {
                sql = sql + " AND duration_distance <= ?";
                sql_values.push(q.query.distance);
            }
        } else if(q.query.distance != null) {
            sql = sql + " WHERE duration_distance <= ?";
            sql_values.push(q.query.distance);
        }
        
        
        if (q.query.sort == "rating") {
            
            sql = sql + " ORDER BY avg_rating DESC;";

        } else if (q.query.sort == "timestamp") {
            
            sql = sql + " ORDER BY timestamp DESC;";
            
        } else {
            sql = sql + ";";
        };
        
        console.log(sql);
        console.log(sql_values);
        con.query(sql, sql_values, function (err, result) {
            
                if (err) throw err;
                res.end(JSON.stringify(result));    
                console.log(result);

            })
        
        
  } 
    
    else if (q.pathname == "/route") {
        
        if (q.query.id != null && Number.isInteger(Number(q.query.id))) {
            
            var sql = "SELECT * FROM routes WHERE id = ?;";
            con.query(sql, [q.query.id], function (err, route_result) {

                          
                var sql = "SELECT point_id, description, hint, latitude, longitude FROM route_points JOIN points ON route_points.point_id = points.id WHERE route_id = ? ORDER BY order_number ASC;";
                con.query(sql, [q.query.id], function (err, points_result) {
                    
                    var sql = "SELECT avg(`rating`) AS rating FROM ratings WHERE route_id = ? GROUP BY route_id;";
                    con.query(sql, [q.query.id], function (err, rating_result) {

                        if(debug){
                            console.log(route_result);
                            console.log(points_result);
                            console.log(rating_result);
                        }

                        if (err) throw err;
                        res.writeHead(200, {'Content-Type': 'application/json'});
                        var final_result = {};
                        final_result["id"] = route_result[0].id;
                        final_result["name"] = route_result[0].name;
                        final_result["description"] = route_result[0].description;
                        final_result["duration_time"] = route_result[0].duration_time;
                        final_result["duration_distance"] = route_result[0].duration_distance;
                        final_result["rating"] = rating_result[0].rating;
                        final_result["points"] = points_result;
                        if(debug){
                            console.log(final_result);
                        }
                        res.end(JSON.stringify(final_result));


                    });

                });

            });
            
        } else {
            
            res.writeHead(200, {'Content-Type': 'text/html'});
            res.end("<h2>No input given</h2>");    
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
}).listen(2122);