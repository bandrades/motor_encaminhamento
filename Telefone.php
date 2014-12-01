<?php
require_once("../medoo/medoo.php");

class Telefone{

	private $db = null;
	private $numeroDiscado;

	public function __construct($numero) {
		$cfg = array(
		    'database_type' => 'mysql',
		    'database_name' => 'motor_encaminhamento',
		    'server' => 'localhost',
		    'username' => 'root',
		    'password' => 's3cr3t@',
		    'port' => 3306,
		    'charset' => 'utf8',
		    'Option' => [PDO :: ATTR_CASE => PDO :: CASE_NATURAL]
		);

		$this->db = new medoo($cfg);	
		$this->numeroDiscado = $numero;

	}

	public function informaOperadora(){

		$operadora = $this->db->get (
		    "tb_portabilidade", 
		    ["operadora_atual"], 
		    ["numero [=]" => "$this->numeroDiscado"]
		); 
		if ($operadora["operadora_atual"]==null){

			$dddNumeroDiscado = $this->informaDDD();
			$prefixoNumeroDiscado = $this->informaPrefixo();

			$query = "SELECT operadora" .
					" FROM motor_encaminhamento.tb_rangeNumero" . 
					" WHERE ddd = " . $dddNumeroDiscado .
					" AND prefixoStart <= " . $prefixoNumeroDiscado .
					" AND prefixoEnd >= " . $prefixoNumeroDiscado;

        	$operadoraAux = $this->db->query($query)->fetchAll();		

		}else{
			return $operadora["operadora_atual"];
		}
		return $operadoraAux[0][0];
	}

	public function informaAreaTarifaria(){

		$dddNumeroDiscado = $this->informaDDD();
		$prefixoNumeroDiscado = $this->informaPrefixo();
		$sufixoNumeroDiscado = $this->informaSufixo();

		$query = "SELECT billcode".
			 	" FROM motor_encaminhamento.location".
				" WHERE localarea =  '". $dddNumeroDiscado ."'".
					" AND prefix =  ". $prefixoNumeroDiscado .
					" AND sufix_start <=  ". $sufixoNumeroDiscado .
					" AND sufix_end >=  ". $sufixoNumeroDiscado ;

        $areaTarifaria = $this->db->query($query)->fetchAll();	

		return $areaTarifaria[0][0];

	}
	public function informaPrefixo(){

		if (strlen($this->numeroDiscado) == 8){
    		$PrefixoNumeroDiscado = substr($this->numeroDiscado,0,4);
		} else if (strlen($this->numeroDiscado) == 11) {
   			$PrefixoNumeroDiscado = substr($this->numeroDiscado,3,4);
		} else if(strlen($this->numeroDiscado) == 12 && substr($this->numeroDiscado,3,1) == '9') {
   			 $PrefixoNumeroDiscado = substr($this->numeroDiscado,4,4);
		} else {
    		return null;
		}
		return $PrefixoNumeroDiscado;

	}
	public function informaSufixo(){

		if (strlen($this->numeroDiscado) == 8){
    		$sufixoNumeroDiscado = substr($this->numeroDiscado,4,4);
		} else if (strlen($this->numeroDiscado) == 11) {
   			$sufixoNumeroDiscado = substr($this->numeroDiscado,7,4);
		} else if(strlen($this->numeroDiscado) == 12 && substr($this->numeroDiscado,3,1) == '9') {
   			 $sufixoNumeroDiscado = substr($this->numeroDiscado,8,4);
		} else {
    		return null;
		}
		return $sufixoNumeroDiscado;

	}

	public function informaDDD(){
		
		if (strlen($this->numeroDiscado) == 11 || (strlen($this->numeroDiscado) == 12 && substr($this->numeroDiscado,3,1) == '9') ) {
   			return substr($this->numeroDiscado,1,2);
		} 
    	return null;
	}


	public function informaPrimeiroDigitoNumero(){
		
		if (strlen($this->numeroDiscado) == 8){
    		$digito = substr($this->numeroDiscado,0,1);
		} else if (strlen($this->numeroDiscado) == 11) {
   			$digito = substr($this->numeroDiscado,3,1);
		} else if(strlen($this->numeroDiscado) == 12 && substr($this->numeroDiscado,3,1) == '9') {
   			 $digito = substr($this->numeroDiscado,4,1);
		} else {
    		return null;
		}
		return $digito;
	}

	public function informaNumeroFixoOuMovel(){

		if ( substr($this->numeroDiscado,0,4) == '0800') {
			$type = '0800';
		}
		else{
			$digito = $this->informaPrimeiroDigitoNumero();

			switch($digito){
			    case '2': 
			    case '3': 
			    case '4': 
			    case '5': 
				$type = 'FIXO';
				break;
			    case '6': 
			    case '7': 
			    case '8': 
			    case '9': 
				$type = 'CELULAR';
				break;
			    default:
				$type = 'DESCONHECIDO';
				break;
			}

		}
	
		return $type;
	}

	public function informaRotas(){
		
		$dddNumeroDiscado = $this->informaDDD();

		if($dddNumeroDiscado != null){

			$idOperadora = $this->informaOperadora();
			$tipoLigacao = $this->informaNumeroFixoOuMovel();
			$codAreaTarifaria = $this->informaAreaTarifaria();

			if($codAreaTarifaria != null){

				if($idOperadora == null){
					$query = "SELECT distinct insercao, prefixo".
							" FROM motor_encaminhamento.tb_rotas " .
							" where (tipo = '" . $tipoLigacao . "' OR tipo is null)" .
							" AND (ddd = " . $dddNumeroDiscado . " OR ddd is null)" .
							" AND operadora is null" .
							" AND (areaTarifaria =  " . $codAreaTarifaria . "  OR areaTarifaria is null)" .
							" order by tipo desc, operadora desc, areaTarifaria desc, ddd desc, peso desc";
				}else{
					$query = "SELECT distinct insercao, prefixo".
							" FROM motor_encaminhamento.tb_rotas " .
							" where (tipo = '" . $tipoLigacao . "' OR tipo is null)" .
							" AND (ddd = " . $dddNumeroDiscado . " OR ddd is null)" .
							" AND (operadora =  '" . $idOperadora . "'  OR operadora is null)" .
							" AND (areaTarifaria =  " . $codAreaTarifaria . "  OR areaTarifaria is null)" .
							" order by tipo desc, operadora desc, areaTarifaria desc, ddd desc, peso desc";
				}
			}
			else{
					if($idOperadora == null){
						$query = "SELECT distinct insercao, prefixo".
								" FROM motor_encaminhamento.tb_rotas " .
								" where (tipo = '" . $tipoLigacao . "' or tipo is null)" .
								" AND (ddd = " . $dddNumeroDiscado . " OR ddd is null)" .
								" AND operadora is null" .
								" AND areaTarifaria is null" .
								" order by tipo desc, operadora desc, areaTarifaria desc, ddd desc, peso desc";

					}
					else{
						$query = "SELECT distinct insercao, prefixo".
								" FROM motor_encaminhamento.tb_rotas " .
								" where (tipo = '" . $tipoLigacao . "' OR tipo is null)" .
								" AND (ddd = " . $dddNumeroDiscado . " OR ddd is null)" .
								" AND (operadora =  '" . $idOperadora . "'  OR operadora is null)" .
								" AND areaTarifaria is null" .
								" order by tipo desc, operadora desc, areaTarifaria desc, ddd desc, peso desc";

					}
			}


	   		 $rotas = $this->db->query($query)->fetchAll();
	   	}
	   	else{
	   		$rotas = "Numero invalido!";
	   	}

   		return $rotas;
	}

}
?>