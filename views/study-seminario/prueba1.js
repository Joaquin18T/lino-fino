document.addEventListener("DOMContentLoaded",()=>{
  $('#tb-cliente').DataTable({
    serverSide: true,
    ajax: {
      url: 'http://localhost/linofino/app/controllers/Usuario.controller.php',
      type: 'POST'
    },
    columns: [
      { data: 'ID' },
      { data: 'first_name' },
      { data: 'last_name' },
      { data: 'email' },
      { data: 'gender' },
      { data: 'phone' }
      // etc...
    ]
  });
  
});