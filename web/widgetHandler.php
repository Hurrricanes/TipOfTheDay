<?php
	header('Content-Type: application/json');

	$request = $_GET['callback'];
	if($request == 'getWidget') {
		getWidget();
	}

	function getWidget() {
		$widget = file_get_contents('widget.php');
		$jsonp = json_encode(array('html' => $widget));
		echo $jsonp;
	}

	exit;
?>