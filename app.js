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
// CHECKOUTS SELECT
app.get('/', function(req, res)
    {  
            // Declare Query 1
    let query1 = "SELECT checkoutID, CONCAT(Members.memberFirstName,' ',Members.memberLastName) AS member, CONCAT(Employees.employeeFirstName,' ',Employees.employeeLastName) AS employee, dateCheckedOut, dateDue FROM Checkouts INNER JOIN Members ON Checkouts.memberID = Members.memberID INNER JOIN Employees ON Checkouts.employeeID = Employees.employeeID;";

    // Query 2 is the same in both cases
    let query2 = "SELECT memberID, CONCAT(Members.memberFirstName,' ',Members.memberLastName) AS member FROM Members;";

    // Query 2 is the same in both cases
    let query3 = "SELECT employeeID, CONCAT(Employees.employeeFirstName,' ',Employees.employeeLastName) AS employee FROM Employees;";

    let query4 = "SELECT Checkouts.checkoutID, bookTitle, dateReturned FROM Checkouts INNER JOIN BooksCheckouts ON Checkouts.checkoutID = BooksCheckouts.checkoutID INNER JOIN Books on Books.bookID = BooksCheckouts.bookID ORDER BY Checkouts.checkoutID;";

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

                return res.render('index', {data: checkouts, members: members, employees: employees, checkedOutBooks: checkedOutBooks});
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
    let query2 = "SELECT bookID, bookTitle FROM Books";
    let query3 = "SELECT authorID, authorLastName FROM Authors";

    db.pool.query(query1, function(error, rows, fields){    // Execute the query

        //save booksAuthors
        let booksAuthors = rows;

        // Run the second query
        db.pool.query(query2, (error, rows, fields) => {

            // save the books
            let books = rows;

            // Run the third query
            db.pool.query(query3, (error, rows, fields) => {

                //save the authors
                let authors = rows;
                return res.render('booksAuthors', {data: booksAuthors, books: books, authors: authors});
        })
                // Render the index.hbs file, and also send the renderer
    })      
    })                                                // an object where 'data' is equal to the 'rows' we
});                                                         // received back from the query

// BOOKS IN CHECKOUTS SELECT
app.get('/booksCheckouts', function(req, res)
{  
    let query1 = "SELECT BooksCheckouts.booksCheckoutsID, Checkouts.checkoutID, Books.bookID, dateReturned FROM Checkouts INNER JOIN BooksCheckouts ON Checkouts.checkoutID = BooksCheckouts.checkoutID INNER JOIN Books on Books.bookID = BooksCheckouts.bookID";               // Define our query
    let query2 = "SELECT bookID, bookTitle FROM Books";
    let query3 = "SELECT checkoutID FROM Checkouts";

    db.pool.query(query1, function(error, rows, fields){    // Execute the query

        //save booksCheckouts
        let booksCheckouts = rows;

        // Run the second query
        db.pool.query(query2, (error, rows, fields) => {

            // save the books
            let books = rows;

            // Run the third query
            db.pool.query(query3, (error, rows, fields) => {

                //save the checkouts
                let checkouts = rows;
                return res.render('booksCheckouts', {data: booksCheckouts, books: books, checkouts: checkouts});
        })
                // Render the index.hbs file, and also send the renderer
    })      
    })                                                     // an object where 'data' is equal to the 'rows' we
});                                                         // received back from the query

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
    query1 = `INSERT INTO Checkouts (memberID, employeeID, dateCheckedOut, dateDue) VALUES ('${data['input-member']}', '${employee}', '${data['input-dateCheckedOut']}', '${data['input-dateDue']}')`;
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

// BOOKS INSERT
app.post('/add-book-form', function(req, res){
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Create the query and run it on the database
    query1 = `INSERT INTO Books (bookTitle, genre, numCopies) VALUES ('${data['input-bookTitle']}', '${data['input-genre']}', '${data['input-numCopies']}')`;
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
            res.redirect('/books');
        }
    })
});

// AUTHORS INSERT
app.post('/add-author-form', function(req, res){
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Create the query and run it on the database
    query1 = `INSERT INTO Authors (authorFirstName, authorLastName) VALUES ('${data['input-authorFirstName']}', '${data['input-authorLastName']}')`;
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
            res.redirect('/authors');
        }
    })
});

// MEMBERS INSERT
app.post('/add-member-form', function(req, res){
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Create the query and run it on the database
    query1 = `INSERT INTO Members (memberFirstName, memberLastName, memberEmail) VALUES ('${data['input-memberFirstName']}', '${data['input-memberLastName']}', '${data['input-memberEmail']}')`;
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
            res.redirect('/members');
        }
    })
});

// BooksAuthors INSERT
app.post('/add-bookAuthor-form', function(req, res){
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Create the query and run it on the database
    query1 = `INSERT INTO BooksAuthors (bookID, authorID) VALUES ('${data['input-book']}', '${data['input-author']}')`;
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
            res.redirect('/booksAuthors');
        }
    })
});

// EMPLOYEES INSERT
app.post('/add-employee-form', function(req, res){
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Create the query and run it on the database
    query1 = `INSERT INTO Employees (employeeFirstName, employeeLastName, employeeEmail) VALUES ('${data['input-employeeFirstName']}', '${data['input-employeeLastName']}', '${data['input-employeeEmail']}')`;
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
            res.redirect('/employees');
        }
    })
});

// BooksCheckouts INSERT
app.post('/add-bookCheckout-form', function(req, res){
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Create the query and run it on the database
    query1 = `INSERT INTO BooksCheckouts (bookID, checkoutID, dateReturned) VALUES ('${data['input-book']}', '${data['input-checkout']}', '${data['input-dateReturned']}')`;
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
            res.redirect('/booksCheckouts');
        }
    })
});



/*
    LISTENER
*/
app.listen(PORT, function(){            // This is the basic syntax for what is called the 'listener' which receives incoming requests on the specified PORT.
    console.log('Express started on http://classwork.engr.oregonstate.edu:' + PORT + '; press Ctrl-C to terminate.')
})