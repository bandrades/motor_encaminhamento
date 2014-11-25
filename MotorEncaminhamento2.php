#!/usr/bin/php -q
<?php

require_once("../phpagi-2.20/phpagi.php");
require_once("Telefone.php");

$agi = new AGI();

// $numeroDiscado = $agi->get_variable("EXTEN");
// $numeroDiscado = $numeroDiscado["data"];

$numeroDiscado = $argv[1];

$telefoneClass = new Telefone($numeroDiscado);

$rotas = $telefoneClass->informaRotas();

$agi->verbose($rotas);
	
?>