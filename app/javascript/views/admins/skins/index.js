$(function(){
  $("#skins-table").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#skins-table tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) >= 0)
    });
  });
});

$(function(){
  $('#delete-selected').on('click', function(e){
    if(window.confirm('Você deseja excluir as skins selecionadas?')) {
      return true
    }
    e.preventDefault();
  });
});

$('#select-all').on('click', function() {   
  if(this.checked) {
    $(':checkbox').each(function() {
      this.checked = true;
    });
  } else {
    $(':checkbox').each(function() {
      this.checked = false;
    });
  }
});
