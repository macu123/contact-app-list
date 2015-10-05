$(document).ready(function() {

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $(".new_contact button").click(function() {
    var firstname = $("#firstname").val();
    var lastname = $("#lastname").val();
    var email = $("#email").val();
    var contact = {
      firstname: firstname,
      lastname: lastname,
      email: email
    };

    $.post(
      "/contacts/create",
      contact,
      function(status) {
        alert(status);
      });
  });

  $(".search_form button").click(function() {
    var search_term = $("#search_term").val();
    $.getJSON(
      "/contacts/search",
      search_term,
      function(data) {
        var data_str = JSON.stringify(data);
        alert(data_str);
      }).error(function() {
        alert("there is error!");
      });
  });

  $(".show_button").click(function() {

    alert("Show");
  });

  $(".delete_button").click(function() {

    alert("Delete");
  });

  $(".show_all_button").click(function() {
    $.getJSON("/contacts", function(result) {
      var result_str = JSON.stringify(result);
      alert(result_str);
    });
  });
});
