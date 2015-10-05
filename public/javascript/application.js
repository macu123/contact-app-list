$(document).ready(function() {

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $(".new_contact").submit(function(e) {
    e.preventDefault();
    var self = this;
    var contact = $(self).serialize();

    $.post(
      "/contacts/create",
      contact,
      function(status) {
        var status_obj = JSON.parse(status);
        if (status_obj.result) {
          alert("The new contact was created successfully and its ID is " + status_obj.id);
          $(self)[0].reset();
        }
        else {
          alert("The new contact was failed to create!");
        }
      }).error(function() {
        alert("There is error!");
      });
  });

  $(".search_form").submit(function(e) {
    e.preventDefault();
    var self = this;
    var search_term = $(self).serialize();
    $.getJSON(
      "/contacts/search",
      search_term,
      function(data) {
        var data_str = JSON.stringify(data);
        if (data_str === "[]") {
          alert("No search result!");
        }
        else {
          alert(data_str);
          $(self)[0].reset();
        }
      }).error(function() {
        alert("there is error!");
      });
  });

  $(".show_form").submit(function(e) {
    e.preventDefault();
    var self = this;
    var contact_id = $(".contact_id_show").val();
    $.getJSON(
      "/contacts/" + contact_id,
      function(data) {
        var data_str = JSON.stringify(data);
        alert(data_str);
        $(self)[0].reset();
      }).error(function() {
        alert("there is error!");
      });
  });

  $(".delete_form").submit(function(e) {
    e.preventDefault();
    var self = this;
    var contact_id = $(".contact_id_delete").val();
    $.ajax({
      url: "/contacts/" + contact_id,
      type: "DELETE",
      success: function(status) {
        var status_obj = JSON.parse(status);
        if (status_obj.result) {
          alert("The contact was successfully deleted and its ID is " + status_obj.id);
          $(self)[0].reset();
        }
        else {
          alert("Cannot delete this contact!")
        }
      },
      error: function() {
        alert("There is error!");
      }
    });
  });

  $(".show_all_button").click(function() {
    $.getJSON("/contacts", function(result) {
      var result_str = JSON.stringify(result);
      alert(result_str);
    }).error(function() {
      alert("There is error!");
    });
  });
});
