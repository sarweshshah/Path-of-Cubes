using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DenotePosition : MonoBehaviour {

	public GameObject osc;
    
    // User inputs the channel numbers
    public int xChannel;
    public int yChannel;
    public int zChannel;

    OscReceiver receiver;
    Vector3 scale;

    void Start()
    {
        receiver = osc.GetComponent<OscReceiver>();
        scale = new Vector3(0f, 0f, 0f);
    }

    void Update()
    {
        scale.x = (float)receiver.messages[xChannel];
        scale.y = (float)receiver.messages[yChannel];
        scale.z = (float)receiver.messages[zChannel];

        
    }
}
