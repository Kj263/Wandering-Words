// Citation for the following file:
// Date: 05/11/2024
// Copied from nodejs-starter-app
// Specifically copied steps 0, 1, 2, 3, and 4
// Source URL: https://github.com/osu-cs340-ecampus/nodejs-starter-app



// App.js

/*
    SETUP
*/
var express = require('express');   // We are using the express library for the web server
var app     = express();            // We need to instantiate an express object to interact with the server in our code
PORT        = 9128;                 // Set a port number at the top so it's easy to change in the future


// Database
var db = require('./database/db-connector')

// handlebars
const { engine } = require('express-handlebars');
var exphbs = require('express-handlebars');     // Import express-handlebars
app.engine('.hbs', engine({extname: ".hbs"}));  // Create an instance of the handlebars engine to process templates
app.set('view engine', '.hbs');                 // Tell express to use the handlebars engine whenever it encounters a *.hbs file.



/*
    ROUTES
*/
// app.get('/', function(req, res)                 // This is the basic syntax for what is called a 'route'
//     {
//         res.send("The server is running by Allison!")      // This function literally sends the string "The server is running!" to the computer
//     });                                         // requesting the web site.

// app.get('/', function(req, res)
//     {
//         // Define our queries
//         query1 = 'DROP TABLE IF EXISTS diagnostic;';
//         query2 = 'CREATE TABLE diagnostic(id INT PRIMARY KEY AUTO_INCREMENT, text VARCHAR(255) NOT NULL);';
//         query3 = 'INSERT INTO diagnostic (text) VALUES ("MySQL is working for majorsal!")'; //replace with your onid
//         query4 = 'SELECT * FROM diagnostic;';

//         // Execute every query in an asynchronous manner, we want each query to finish before the next one starts

//         // DROP TABLE...
//         db.pool.query(query1, function (err, results, fields){

//             // CREATE TABLE...
//             db.pool.query(query2, function(err, results, fields){

//                 // INSERT INTO...
//                 db.pool.query(query3, function(err, results, fields){

//                     // SELECT *...
//                     db.pool.query(query4, function(err, results, fields){

//                         // Send the results to the browser
//                         res.send(JSON.stringify(results));
//                     });
//                 });
//             });
//         });
//     });


// app.get('/', function(req, res)
//     {
//         res.render('index');                    // Note the call to render() and not send(). Using render() ensures the templating engine
//     });                                         // will process this file, before sending the finished HTML to the client.


app.get('/', function(req, res)
    {  
        let query1 = "SELECT checkoutID, Members.memberLastName, Employees.employeeLastName, dateCheckedOut, dateDue FROM Checkouts INNER JOIN Members ON Checkouts.memberID = Members.memberID INNER JOIN Employees ON Checkouts.employeeID = Employees.employeeID";               // Define our query
        //let query1 = "SELECT * FROM Checkouts";
        db.pool.query(query1, function(error, rows, fields){    // Execute the query

            res.render('index', {data: rows});                  // Render the index.hbs file, and also send the renderer
        })                                                      // an object where 'data' is equal to the 'rows' we
    });                                                         // received back from the query


/*
    LISTENER
*/
app.listen(PORT, function(){            // This is the basic syntax for what is called the 'listener' which receives incoming requests on the specified PORT.
    console.log('Express started on http://classwork.engr.oregonstate.edu:' + PORT + '; press Ctrl-C to terminate.')
});