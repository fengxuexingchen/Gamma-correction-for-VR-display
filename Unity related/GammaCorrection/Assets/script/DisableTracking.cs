
using UnityEngine;
using UnityEngine.XR;

public class DisableTracking : MonoBehaviour
{
    private GameObject cam;
    
    void Start()
    {
        XRDevice.DisableAutoXRCameraTracking(GetComponent<Camera>(), true);   
        cam = GameObject.Find("Main Camera");                               
        cam.transform.position = new Vector3(0, 0, 0);                                    
        cam.transform.rotation = new Quaternion(0, 0, 0, 0);                 
    }
    
    void Update()
    {
        
    }

}
