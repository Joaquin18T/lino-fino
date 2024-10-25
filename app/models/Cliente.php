<?php

require_once 'Conexion.php';

class Cliente extends Conexion{
    public function getAll(){
        return parent::getData("sp_getAll_clients");
    }
}

// $data = new Cliente();

// echo json_encode($data->getAll());