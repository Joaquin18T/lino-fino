document.addEventListener("DOMContentLoaded",()=>{
let myTable = null;

(async()=>{
    const params = new URLSearchParams();
    params.append("operation", "getAllCliente");
    const data = await fetch(`http://localhost/linofino/app/controllers/Usuario.controller.php?${params}`);
    const show = await data.json();
    console.log(show);
    
    show.forEach(x => {
        document.getElementById("body-cliente").innerHTML+=`
            <tr>
                <td>${x.id}</td>
                <td>${x.first_name}</td>
                <td>${x.last_name}</td>
                <td>${x.email}</td>
                <td>${x.gender}</td>
                <td>${x.phone}</td>
            </tr>
        `;
    
    });

    myTable = $("#tb-cliente").DataTable({
        paging: true,
        searching: false,
        lengthMenu: [20, 10, 15, 20],
        pageLength: 20,
        language: {
          lengthMenu: "Mostrar _MENU_ filas por página",
          paginate: {
            previous: "Anterior",
            next: "Siguiente",
          },
          search: "Buscar:",
          info: "Mostrando _START_ a _END_ de _TOTAL_ registros",
          emptyTable: "No se encontraron registros"
        },
      });
})();

});
