using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ParamCube : MonoBehaviour
{
    public int _band;
    public float _startScale, _scaleMultiplier;
    public bool _useBuffer;
    
    Color averageColor;
    Material mat;

    private void Start()
    {
        mat = GetComponent<Renderer>().material;
    }

    void Update()
    {
        if(_useBuffer)
            transform.localScale = new Vector3(transform.localScale.x, (AudioPear._bandBuffer[_band] * _scaleMultiplier) + _startScale, transform.localScale.z);
        else
            transform.localScale = new Vector3(transform.localScale.x, (AudioPear._FreqBand[_band] * _scaleMultiplier) + _startScale, transform.localScale.z);


        if ((AudioPear._FreqBand[_band] * _scaleMultiplier) + _startScale < 5)
            averageColor = Color.white;
        else if ((AudioPear._FreqBand[_band] * _scaleMultiplier) + _startScale < 10)
            averageColor = Color.yellow;
        else if ((AudioPear._FreqBand[_band] * _scaleMultiplier) + _startScale < 15)
            averageColor = Color.red;
        else if ((AudioPear._FreqBand[_band] * _scaleMultiplier) + _startScale < 20)
            averageColor = Color.cyan;
        else if ((AudioPear._FreqBand[_band] * _scaleMultiplier) + _startScale < 25)
            averageColor = Color.blue;
        else if ((AudioPear._FreqBand[_band] * _scaleMultiplier) + _startScale < 30)
            averageColor = Color.green;
        else if ((AudioPear._FreqBand[_band] * _scaleMultiplier) + _startScale < 35)
            averageColor = Color.magenta;
        else if ((AudioPear._FreqBand[_band] * _scaleMultiplier) + _startScale < 40)
            averageColor = Color.grey;

        mat.color = Color.Lerp(mat.color, averageColor,Time.deltaTime * 5);
    }
}
