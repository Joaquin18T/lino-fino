<?php require_once '../header.php'; ?>

<main>
    <div class="container-fluid px-4">
      <h1>Reporte diario</h1>
    </div>
    <div class="table-responsive">
      <table class="table" id="tb-cliente">
        <thead>
          <th>ID</th>
          <th>First Name</th>
          <th>Last Name</th>
          <th>Email</th>
          <th>Gender</th>
          <th>Phone</th>
        </thead>
        <tbody id="body-cliente">

        </tbody>
      </table>

    </div>
</main>

<?php require_once '../footer.php'; ?>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="http://localhost/linofino/js/render-table.js"></script>