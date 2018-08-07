using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Runtime.InteropServices;

public class animController : MonoBehaviour
{

		public Animator anim;
		bool isAnimated = false;

		// Use this for initialization
		void Start ()
		{
				anim = GetComponent<Animator> ();
		}
	
		// Update is called once per frame
		void Update ()
		{
				if (Input.GetKeyDown ("1")) {
						if (!isAnimated) {
								anim.enabled = true;
								anim.Play ("Drop");
								isAnimated = true;
						} else {
								anim.enabled = false;
								isAnimated = false;
						}
				}
		}
}
