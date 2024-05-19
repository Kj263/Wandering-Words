// Get the objects we need to modify
let addCheckoutForm = document.getElementById('add-checkout-form-ajax');

// Modify the objects we need
addCheckoutForm.addEventListener("submit", function (e) {
    
    // Prevent the form from submitting
    e.preventDefault();

    // Get form fields we need to get data from
    let inputMember = document.getElementById("input-member");
    let inputEmployee = document.getElementById("input-employee");
    let inputDateCheckedOut = document.getElementById("input-dateCheckedOut");
    let inputDateDue = document.getElementById("input-dateDue");

    // Get the values from the form fields
    let memberValue = inputMember.value;
    let employeeValue = inputEmployee.value;
    let dateCheckedOutValue = inputDateCheckedOut.value;
    let dateDueValue = inputDateDue.value;

    // Put our data we want to send in a javascript object
    let data = {
        member: memberValue,
        employee: employeeValue,
        dateCheckedOut: dateCheckedOutValue,
        dateDue: dateDueValue
    }
    
    // Setup our AJAX request
    var xhttp = new XMLHttpRequest();
    xhttp.open("POST", "/add-checkout-ajax", true);
    xhttp.setRequestHeader("Content-type", "application/json");

    // Tell our AJAX request how to resolve
    xhttp.onreadystatechange = () => {
        if (xhttp.readyState == 4 && xhttp.status == 200) {

            // Add the new data to the table
            addRowToTable(xhttp.response);

            // Clear the input fields for another transaction
            inputMember.value = '';
            inputEmployee.value = '';
            inputDateCheckedOut.value = '';
            inputDateDue.value = '';
        }
        else if (xhttp.readyState == 4 && xhttp.status != 200) {
            console.log("There was an error with the input.")
        }
    }

    // Send the request and wait for the response
    xhttp.send(JSON.stringify(data));

})


// Creates a single row from an Object representing a single record from
// bsg_people
addRowToTable = (data) => {

    // Get a reference to the current table on the page and clear it out.
    let currentTable = document.getElementById("checkouts-table");

    // Get the location where we should insert the new row (end of table)
    let newRowIndex = currentTable.rows.length;

    // Get a reference to the new row from the database query (last object)
    let parsedData = JSON.parse(data);
    let newRow = parsedData[parsedData.length - 1]

    // Create a row and 4 cells
    let row = document.createElement("TR");
    let checkoutIDCell = document.createElement("TD");
    let memberCell = document.createElement("TD");
    let employeeCell = document.createElement("TD");
    let dateCheckedOutCell = document.createElement("TD");
    let dateDueCell = document.createElement("TD");

    let deleteCell = document.createElement("TD");

    // Fill the cells with correct data
    checkoutIDCell.innerText = newRow.checkoutID;
    memberCell.innerText = newRow.member;
    employeeCell.innerText = newRow.employee;
    dateCheckedOutCell.innerText = newRow.dateCheckedOut;
    dateDueCell.innerText = newRow.dateDue;

    deleteCell = document.createElement("button");
    deleteCell.innerHTML = "Delete";
    deleteCell.onclick = function(){
        deleteCheckout(newRow.id);
    };


    // Add the cells to the row
    row.appendChild(checkoutIDCell);
    row.appendChild(memberCell);
    row.appendChild(employeeCell);
    row.appendChild(dateCheckedOutCell);
    row.appendChild(dateDueCell);
    row.appendChild(deleteCell);

    // Add a row attribute so the deleteRow function can find a newly added row
    row.setAttribute('data-value', newRow.id);

    // Add the row to the table
    currentTable.appendChild(row);

        // Find drop down menu, create a new option, fill data in the option (full name, id),
    // then append option to drop down menu so newly created rows via ajax will be found in it without needing a refresh
    let selectMenu = document.getElementById("mySelect");
    let option = document.createElement("option");
    option.text = newRow.member;
    option.value = newRow.checkoutID;
    selectMenu.add(option);
    // End of new step 8 code.
}