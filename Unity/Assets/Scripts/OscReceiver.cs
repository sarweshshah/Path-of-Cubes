using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OscReceiver : MonoBehaviour
{
    // Make sure you have UDPPacketIO.cs and Osc.cs in the standard assets folder
    public string RemoteIP = "127.0.0.1";
    public int SendToPort = 57131;
    public int ListenerPort = 57130;

    public Transform controller;
    public Osc handler;

    // Messages are accessible from this instance in other scripts
    public object[] messages;

    public void Start()
    {	
        // Set up OSC connection
        UDPPacketIO udp = GetComponent<UDPPacketIO>();
        udp.init(RemoteIP, SendToPort, ListenerPort);
        handler = GetComponent<Osc>();
        handler.init(udp);
			
        // Listen to the channels set in the Processing sketch
        handler.SetAddressHandler("/sensorX", ListenEvent);
        handler.SetAddressHandler("/sensorY", ListenEvent);
        handler.SetAddressHandler("/sensorZ", ListenEvent);

        messages = new object[3];
    }

    public void ListenEvent(OscMessage oscMessage)
    {
        switch (oscMessage.Address)
        {
            case "/sensorX":
                messages[0] = oscMessage.Values[0];
                break;
            case "/sensorY":
                messages[1] = oscMessage.Values[0];
                break;
            case "/sensorZ":
                messages[2] = oscMessage.Values[0];
                break;
        }
    }
}
