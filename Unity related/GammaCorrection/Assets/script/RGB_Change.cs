using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class RGB_Change : MonoBehaviour
{
    // The script is used to change the RGB values for the background of camera.
    // This script should be assigned to the Main Camera object.


    // "RGB_target" is used to set the RGB values for the background of camera during the calibration. Usually, the settings should be the same as what you have used during the calibartion of normal display.
    float[] RGB_target = {0f,32f,64f,96f,128f,160f,192f,224f,255f};
    // "RGB_index" indicate which channel you'd like to calibrate. 1: R channel (red stimulus); 2: G channel (green stimulus); 3: B channel (blue stimulus); 4: RGB channels (achromatic stimulus).
    public int RGB_index = 1;

    // "pointer" is used to save the index of current RGB values. 
    int pointer = 0;
    Color camera_RGB;
    void Start()
    {
        // Make the fist value in "RGB_target" as the default.
        camera_RGB = this.GetComponent<Camera>().backgroundColor = new Color(RGB_target[0] / 255f, RGB_target[0] / 255f, RGB_target[0] / 255f, 0f);
    }

    // Update is called once per frame
    void Update()
    {


        if (Input.GetKeyDown(KeyCode.Space))
        {
            //Press "SPACE" key on ypur computer to present the next RGB value in "RGB_target".

            if (pointer < RGB_target.Length - 1)
            {
                pointer++;
                if (RGB_index == 1)
                    camera_RGB = this.GetComponent<Camera>().backgroundColor = new Color(RGB_target[pointer] / 255f, 0f, 0f, 0f);  //R channel
                else if (RGB_index == 2)
                    camera_RGB = this.GetComponent<Camera>().backgroundColor = new Color(0f, RGB_target[pointer] / 255f, 0f, 0f);   //G  channel
                else if (RGB_index == 3)
                    camera_RGB = this.GetComponent<Camera>().backgroundColor = new Color(0f, 0f, RGB_target[pointer] / 255f, 0f);   //B  channel
                else if (RGB_index == 4)
                    camera_RGB = this.GetComponent<Camera>().backgroundColor = new Color(RGB_target[pointer] / 255f, RGB_target[pointer] / 255f, RGB_target[pointer] / 255f, 0f);   //RGB  channels
            }
            // End the script after all RGB values in "RGB_target" being read.
            else
            {
                EditorApplication.isPlaying = false;
            }

            
            
        }
    }
}
