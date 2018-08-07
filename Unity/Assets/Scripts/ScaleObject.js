// Channels are set in script GUI
var xChannel : float;
var yChannel : float;
var zChannel : float;

function Update () {
	// Get data from reciever	
	var x = OscReceiver.messages[xChannel];
	var y = OscReceiver.messages[yChannel];
	var z = OscReceiver.messages[zChannel];

	// Transform scale of object
	transform.localScale = Vector3(x,y,z);
}
