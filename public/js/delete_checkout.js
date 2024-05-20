function deleteCheckout(checkoutID) {
  let link = '/delete-checkout-ajax/';
  let data = {
    id: checkoutID
  };

  $.ajax({
    url: link,
    type: 'DELETE',
    data: JSON.stringify(data),
    contentType: "application/json; charset=utf-8",
    success: function(result) {
      deleteRow(checkoutID);
      window.location.reload()
    }
  });
}

function deleteRow(checkoutID){
    let table = document.getElementById("checkouts-table");
    for (let i = 0, row; row = table.rows[i]; i++) {
       if (table.rows[i].getAttribute("data-value") == checkoutID) {
            table.deleteRow(i);
            break;
       }
    }
}
