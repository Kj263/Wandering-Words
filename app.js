// Citation for the following file:
// Date: 05/11/2024
// Copied from nodejs-starter-app
// Specifically copied steps 0-8
// Source URL: https://github.com/osu-cs340-ecampus/nodejs-starter-app



// App.js

/*
    SETUP
*/
var express = require('express');   // We are using the express library for the web server
var app     = express();            // We need to instantiate an express object to interact with the server in our code
PORT        = 9235;                 // Set a port number at the top so it's easy to change in the future


app.use(express.json())
app.use(express.urlencoded({extended: true}))
app.use(express.static('public'))


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
    // Declare Query 1
    let query1;

    // If there is no query string, we just perform a basic SELECT
    if (req.query.lname === undefined)
    {
        query1 = "SELECT * FROM bsg_people;";
    }

    // If there is a query string, we assume this is a search, and return desired results
    else
    {
        query1 = `SELECT * FROM bsg_people WHERE lname LIKE "${req.query.lname}%"`
    }

    // Query 2 is the same in both cases
    let query2 = "SELECT * FROM bsg_planets;";

    // Run the 1st query
    db.pool.query(query1, function(error, rows, fields){
        
        // Save the people
        let people = rows;
        
        // Run the second query
        db.pool.query(query2, (error, rows, fields) => {
            
            // Save the planets
            let planets = rows;

            return res.render('index', {data: people, planets: planets});
        })
    })
});                                                       // received back from the query

//checkouts SELECT
// app.get('/checkouts', function(req, res)
//     {  
//             // Declare Query 1
//     let query1 = "SELECT * FROM Checkouts;";

//     // Query 2 is the same in both cases
//     let query2 = "SELECT * FROM Members;";

//     // Query 2 is the same in both cases
//     let query3 = "SELECT * FROM Employees;";

//     // Run the 1st query
//     db.pool.query(query1, function(error, rows, fields){
        
//         // Save the checkouts
//         let checkouts = rows;
        
//         // Run the second query
//         db.pool.query(query2, (error, rows, fields) => {
            
//             // Save the members
//             let members = rows;
//             return res.render('checkouts', {data: checkouts, members: members});
//         })
//     })
// });                                                       // received back from the query
app.get('/checkouts', function(req, res)
    {  
            // Declare Query 1
    let query1 = "SELECT * FROM Checkouts;";

    // Query 2 is the same in both cases
    let query2 = "SELECT * FROM Members;";

    // Query 2 is the same in both cases
    let query3 = "SELECT * FROM Employees;";

    let query4 = "SELECT Checkouts.checkoutID, bookTitle, dateReturned FROM Checkouts INNER JOIN BooksCheckouts ON Checkouts.checkoutID = BooksCheckouts.checkoutID INNER JOIN Books on Books.bookID = BooksCheckouts.bookID;";

    // Run the 1st query
    db.pool.query(query1, function(error, rows, fields){
        
        // Save the checkouts
        let checkouts = rows;
        
        // Run the second query
        db.pool.query(query2, (error, rows, fields) => {
            
            // Save the members
            let members = rows;

            db.pool.query(query3, (error, rows, fields) => {

                // Save the employees
                let employees = rows;
                
                db.pool.query(query4, (error, rows, fields) => {

                //save the checked out books
                let checkedOutBooks = rows;

                return res.render('checkouts', {data: checkouts, members: members, employees: employees, checkedOutBooks: checkedOutBooks});
                })
        })
        })
    })
});                                                       // received back from the query



// BOOKS SELECT
app.get('/books', function(req, res)
    {  
        let query1 = "SELECT * FROM Books;";               // Define our query

        db.pool.query(query1, function(error, rows, fields){    // Execute the query

            res.render('books', {data: rows});                  // Render the index.hbs file, and also send the renderer
        })                                                      // an object where 'data' is equal to the 'rows' we
    });                                                         // received back from the query

// AUTHORS SELECT
app.get('/authors', function(req, res)
{  
    let query1 = "SELECT * FROM Authors;";               // Define our query

    db.pool.query(query1, function(error, rows, fields){    // Execute the query

        res.render('authors', {data: rows});                  // Render the index.hbs file, and also send the renderer
    })                                                      // an object where 'data' is equal to the 'rows' we
});                                                         // received back from the query

// MEMBERS SELECT
app.get('/members', function(req, res)
{  
    let query1 = "SELECT * FROM Members;";               // Define our query

    db.pool.query(query1, function(error, rows, fields){    // Execute the query

        res.render('members', {data: rows});                  // Render the index.hbs file, and also send the renderer
    })                                                      // an object where 'data' is equal to the 'rows' we
});                                                         // received back from the query

// EMPLOYEES SELECT
app.get('/employees', function(req, res)
{  
    let query1 = "SELECT * FROM Employees;";               // Define our query

    db.pool.query(query1, function(error, rows, fields){    // Execute the query

        res.render('employees', {data: rows});                  // Render the index.hbs file, and also send the renderer
    })                                                      // an object where 'data' is equal to the 'rows' we
});                                                         // received back from the query

// BOOKS WITH AUTHORS SELECT
app.get('/booksAuthors', function(req, res)
{  
    let query1 = "SELECT BooksAuthors.booksAuthorsID, Books.bookID, Authors.authorID FROM Books INNER JOIN BooksAuthors ON Books.bookID = BooksAuthors.bookID INNER JOIN Authors on Authors.authorID = BooksAuthors.authorID";               // Define our query

    db.pool.query(query1, function(error, rows, fields){    // Execute the query

        res.render('booksAuthors', {data: rows});                  // Render the index.hbs file, and also send the renderer
    })                                                      // an object where 'data' is equal to the 'rows' we
});                                                         // received back from the query

// BOOKS IN CHECKOUTS SELECT
app.get('/booksCheckouts', function(req, res)
{  
    let query1 = "SELECT BooksCheckouts.booksCheckoutsID, Checkouts.checkoutID, Books.bookID, dateReturned FROM Checkouts INNER JOIN BooksCheckouts ON Checkouts.checkoutID = BooksCheckouts.checkoutID INNER JOIN Books on Books.bookID = BooksCheckouts.bookID";               // Define our query

    db.pool.query(query1, function(error, rows, fields){    // Execute the query

        res.render('booksCheckouts', {data: rows});                  // Render the index.hbs file, and also send the renderer
    })                                                      // an object where 'data' is equal to the 'rows' we
});                                                         // received back from the query

//demo add
app.post('/add-person-form', function(req, res){
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Capture NULL values
    let homeworld = parseInt(data['input-homeworld']);
    if (isNaN(homeworld))
    {
        homeworld = 'NULL'
    }

    let age = parseInt(data['input-age']);
    if (isNaN(age))
    {
        age = 'NULL'
    }

    // Create the query and run it on the database
    query1 = `INSERT INTO bsg_people (fname, lname, homeworld, age) VALUES ('${data['input-fname']}', '${data['input-lname']}', ${homeworld}, ${age})`;
    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM bsg_people and
        // presents it on the screen
        else
        {
            res.redirect('/');
        }
    })
});

// CHECKOUTS INSERT
// app.js

app.post('/add-checkout-form', function(req, res){
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Capture NULL values
    let employee = parseInt(data['input-employee']);
    if (isNaN(employee))
    {
        employee = 'NULL'
    }

    // Create the query and run it on the database
    //query1 = `INSERT INTO bsg_people (fname, lname, homeworld, age) VALUES ('${data['input-fname']}', '${data['input-lname']}', ${homeworld}, ${age})`;
    query1 = `INSERT INTO Checkouts (memberID, employeeID, dateCheckedOut, dateDue) VALUES ('${data['input-member']}', '${employee}', '${data['input-dateCheckedOut']}', '${data['input-dateDue']}',)`
    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM bsg_people and
        // presents it on the screen
        else
        {
            res.redirect('/checkouts');
        }
    })
});

app.delete('/delete-person-ajax/', function(req,res,next){
    let data = req.body;
    let personID = parseInt(data.id);
    let deleteBsg_Cert_People = `DELETE FROM bsg_cert_people WHERE pid = ?`;
    let deleteBsg_People= `DELETE FROM bsg_people WHERE id = ?`;
  
  
          // Run the 1st query
          db.pool.query(deleteBsg_Cert_People, [personID], function(error, rows, fields){
              if (error) {
  
              // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
              console.log(error);
              res.sendStatus(400);
              }
  
              else
              {
                  // Run the second query
                  db.pool.query(deleteBsg_People, [personID], function(error, rows, fields) {
  
                      if (error) {
                          console.log(error);
                          res.sendStatus(400);
                      } else {
                          res.sendStatus(204);
                      }
                  })
              }
  })});



/*
    LISTENER
*/
app.listen(PORT, function(){            // This is the basic syntax for what is called the 'listener' which receives incoming requests on the specified PORT.
    console.log('Express started on http://classwork.engr.oregonstate.edu:' + PORT + '; press Ctrl-C to terminate.')
})