$(document).ready(function(){
  $("table").each(function(){
    $(this).find("tr:odd").addClass("odd");
  });
});
