using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class highlightController : MonoBehaviour
{
		new Renderer renderer;
		public Material highlight_material;
		public Material default_material;

		void Start ()
		{
				//Fetch the Material from the Renderer of the GameObject
				renderer = GetComponent<Renderer> ();
		}

		void Update ()
		{
				if (transform.position.y == 0) {
						renderer.material = highlight_material;
				} else {
						renderer.material = default_material;
				}
		}
}
