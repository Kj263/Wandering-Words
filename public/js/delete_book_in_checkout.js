// Deletes item from intersection table booksCheckouts
// This item has a relationship to Checkouts and Books tables

function deleteBookinCheckout(booksCheckoutsID) {
    let link = '/delete-book-in-checkout-ajax/';
    let data = {
      id: booksCheckoutsID
    };
  
    $.ajax({
      url: link,
      type: 'DELETE',
      data: JSON.stringify(data),
      contentType: "application/json; charset=utf-8",
      success: function(result) {
        deleteRow(booksCheckoutsID);
        window.location.reload()
      }
    });
  }
  
  function deleteRow(booksCheckoutsID){
      let table = document.getElementById("books-checkouts-table");
      for (let i = 0, row; row = table.rows[i]; i++) {
         if (table.rows[i].getAttribute("data-value") == booksCheckoutsID) {
              table.deleteRow(i);
              break;
         }
      }
  }
  