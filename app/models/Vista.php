<?php

require_once 'Conexion.php';

class Vista extends Conexion
{
  private $pdo;

  public function __CONSTRUCT()
  {
    $this->pdo = parent::getConexion();
  }

  public function getAll():array{
    return parent::getData("sp_listar_vistas");
  }
}

// $vista = new Vista();
// $ruta = $vista->getAll();
// var_dump($ruta);
