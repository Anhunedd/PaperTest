using UnityEngine;
using System.Collections;

public class SineWobble : MonoBehaviour
{
	public float wobbleSpeed = 5.0f;
	public Vector3 wobbleDir = Vector3.up * 0.1f;
	
	private Vector3 startPos;
	private float ang;

	// Use this for initialization
	void Start ()
	{
		startPos = transform.position;
		ang = Random.Range( 0.0f, 360.0f );
	}
	
	// Update is called once per frame
	void Update ()
	{
		ang += wobbleSpeed * Time.deltaTime;
		if (ang > 360.0f)
			ang -= 360.0f;
		Vector3 pos = startPos + wobbleDir * Mathf.Sin( ang );
		transform.position = pos;
	}
}
