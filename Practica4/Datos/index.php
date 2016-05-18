<HTML>
<HEAD>
<TITLE>APACHE BENCHMARK</TITLE>
</HEAD>
<BODY>
M1 funciona, archivo para realizar el benchmark


<?php
$tiempo_inicio = microtime(true);
for ($i=0; $i<1000000; $i++){
  $a = $i * $i;
  $b = $a - $i;
  $c = $a / $b;
  $d = 1 / $c;
}
$tiempo_fin = microtime(true);
echo "Tiempo empleado: " . round($tiempo_fin - $tiempo_inicio, 4) ;
?>

</BODY>
</HTML>

