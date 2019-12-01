using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AtomicAttraction : MonoBehaviour
{
    public GameObject _atom, _attractor;
    public Gradient _gradient;
    public Material _material;
    private Material[] _shareMaterial;
    private Color[] _sharedColor;

    public int[] _attractPoints;
    public Vector3 _spacingDirection;

    [Range(0, 20)]
    public float _spacingBetweenAtractPoints;

    [Range(0, 20)]
    public float _scaleAttractPoionts;
    private GameObject[] _attractorArray, _atomArray;

    [Range(1, 64)]
    public int _amountOfAtomsPerPoint;

    public Vector2 _atomScaleMinMax;
    private float[] _atomScaleSet;

    public float _strengthOfAttraction, _maxMagnitude, _randomPosDistance;
    public bool _useGravity;

    public float _audioScaleMultiplier, _audioEmissionMultiplier;

    [Range(0.0f,1.0f)]
    public float _tresholdEmission;

    private float[] _audioBandEmissionTreshold;
    private float[] _audioBandEmissionColor;
    private float[] _audioBandScale;

    public enum _emissionTreshold { Buffered, NoBuffer};
    public _emissionTreshold emissionTreshold = new _emissionTreshold();
    public enum _emissionColor { Buffered, NoBuffer};
    public _emissionColor emissionColor = new _emissionColor();
    public enum _atomScale { Buffered, NoBuffer};
    public _atomScale atomScale = new _atomScale();

    public bool _anumatePos;
    private Vector3 _startPoint;
    public Vector3 _destination;
    public AnimationCurve _animationCurve;
    private float _animTimer;
    public float _animSpeed;
    public int _posAnimBand;
    public bool _posAnimBuffered;

    public void OnDrawGizmos()
    {
        for (int i = 0; i < _attractPoints.Length; i++)
        {
            //float evaluateStep = 1.0f / _attractPoints.Length;
            float evaluateStep = 0.125f;

            Color color = _gradient.Evaluate(Mathf.Clamp( evaluateStep * _attractPoints[i],0,7));
            Gizmos.color = color;

            Vector3 pos = new Vector3(
                transform.position.x + (_spacingBetweenAtractPoints * i * _spacingDirection.x),
                transform.position.y + (_spacingBetweenAtractPoints * i * _spacingDirection.y),
                transform.position.z + (_spacingBetweenAtractPoints * i * _spacingDirection.z));

            Gizmos.DrawSphere(pos, _scaleAttractPoionts * 0.5f);
        }
        Gizmos.color = new Color(1, 1, 1);
        Vector3 startpoint = transform.position;
        Vector3 endpoint = transform.position + _destination;
        Gizmos.DrawLine(startpoint, endpoint);
    }

    void Start()
    {
        _startPoint = transform.position;
        _attractorArray = new GameObject[_attractPoints.Length];
        _atomArray = new GameObject[_attractPoints.Length * _amountOfAtomsPerPoint];
        _atomScaleSet = new float[_attractPoints.Length * _amountOfAtomsPerPoint];

        _audioBandEmissionTreshold = new float[8];
        _audioBandEmissionColor = new float[8];
        _audioBandScale = new float[8];
        _shareMaterial = new Material[_attractPoints.Length];
        _sharedColor = new Color[_attractPoints.Length];

        int _countAtom = 0;
        for (int i = 0; i < _attractPoints.Length; i++)
        {
            GameObject _attractorInstance = (GameObject)Instantiate(_attractor);
            _attractorArray[i] = _attractorInstance;

            _attractorInstance.transform.position = new Vector3(
                transform.position.x + (_spacingBetweenAtractPoints * i * _spacingDirection.x),
                transform.position.y + (_spacingBetweenAtractPoints * i * _spacingDirection.y),
                transform.position.z + (_spacingBetweenAtractPoints * i * _spacingDirection.z));

            _attractorInstance.transform.parent = this.transform;
            _attractorInstance.transform.localScale = new Vector3(_scaleAttractPoionts, _scaleAttractPoionts, _scaleAttractPoionts);
            _attractorInstance.GetComponent<MeshRenderer>().enabled = false;

            //set colors tp material
            Material _matInstance = new Material(_material);
            _shareMaterial[i] = _matInstance;
            _sharedColor[i] = _gradient.Evaluate(0.125f * i);

            //instantiate atoms
            for (int j = 0; j < _amountOfAtomsPerPoint; j++)
            {
                GameObject _atomInstance = (GameObject)Instantiate(_atom);
                _atomArray[_countAtom] = _atomInstance;
                _atomInstance.GetComponent<AttractTo>()._attractedTo = _attractorArray[i].transform;
                _atomInstance.GetComponent<AttractTo>()._strengthOfAttraction = _strengthOfAttraction;
                _atomInstance.GetComponent<AttractTo>()._maxMagnitude = _maxMagnitude;
                if (_useGravity)
                {
                    _atomInstance.GetComponent<Rigidbody>().useGravity = true;
                }
                else
                {
                    _atomInstance.GetComponent<Rigidbody>().useGravity = false;
                }

                _atomInstance.transform.position = new Vector3(
                    _attractorArray[i].transform.position.x + Random.RandomRange(-_randomPosDistance, _randomPosDistance),
                    _attractorArray[i].transform.position.y + Random.RandomRange(-_randomPosDistance, _randomPosDistance),
                    _attractorArray[i].transform.position.z + Random.RandomRange(-_randomPosDistance, _randomPosDistance));

                float _randomScale = Random.Range(_atomScaleMinMax.x, _atomScaleMinMax.y);
                _atomScaleSet[_countAtom] = _randomScale;
                _atomInstance.transform.localScale = new Vector3(_atomScaleSet[_countAtom], _atomScaleSet[_countAtom], _atomScaleSet[_countAtom]);
                _atomInstance.transform.parent = transform.parent.transform;
                _atomInstance.GetComponent<MeshRenderer>().material = _shareMaterial[i];

                _countAtom++; 
            }
        }
    }
    
    void Update()
    {
        SelectAudioValue();
        AtomBehavior();
        AnimatePosition();
    }

    void AtomBehavior()
    {
        int countAtom = 0;
        for (int i = 0; i < _attractPoints.Length; i++)
        {
            if (_audioBandEmissionTreshold[_attractPoints[i]] >= _tresholdEmission)
            {
                 Color _audioColor = new Color(
                     _sharedColor[i].r * _audioBandEmissionColor[_attractPoints[i]] * _audioEmissionMultiplier,
                     _sharedColor[i].g * _audioBandEmissionColor[_attractPoints[i]] * _audioEmissionMultiplier,
                     _sharedColor[i].b * _audioBandEmissionColor[_attractPoints[i]] * _audioEmissionMultiplier, 1);
                
                 _shareMaterial[i].SetColor("_EmissionColor", _audioColor);
            }
            else
            {
                Color _audioColor = new Color(0, 0, 0, 1);
                _shareMaterial[i].SetColor("_EmissionColor", _audioColor);
            }

            for (int j = 0; j < _amountOfAtomsPerPoint; j++)
            {
                //0보다 작으면 에러 발생
                if (_atomScaleSet[countAtom] + _audioBandScale[_attractPoints[i]] * _audioScaleMultiplier > 0)
                {
                    _atomArray[countAtom].transform.localScale = new Vector3(
                        _atomScaleSet[countAtom] + _audioBandScale[_attractPoints[i]] * _audioScaleMultiplier,
                        _atomScaleSet[countAtom] + _audioBandScale[_attractPoints[i]] * _audioScaleMultiplier,
                        _atomScaleSet[countAtom] + _audioBandScale[_attractPoints[i]] * _audioScaleMultiplier);
                }

                countAtom++;
            }
        }
    }

    void AnimatePosition()
    {
        if (_anumatePos)
        {
            if (_posAnimBuffered)
            {
                if (!System.Single.IsNaN(AudioPear._audioBandBuffer[_posAnimBand]))
                {
                    _animTimer += Time.deltaTime * AudioPear._audioBandBuffer[_posAnimBand] * _animSpeed;
                }
            }
            else
            {
                if (!System.Single.IsNaN(AudioPear._audioBand[_posAnimBand]))
                {
                    _animTimer += Time.deltaTime * AudioPear._audioBand[_posAnimBand] * _animSpeed;
                }
            }
            if (_animTimer >= 1)
            {
                _animTimer -= 1f;
            }
            float _alphaTime = _animationCurve.Evaluate(_animTimer);
            Vector3 endpoint = _destination + _startPoint;
            transform.position = Vector3.Lerp(_startPoint, endpoint, _alphaTime);
        }
    }

    void SelectAudioValue()
    {
        //Treshold
        if (emissionTreshold == _emissionTreshold.Buffered)
        {
            for (int i = 0; i < 8; i++)
            {
                _audioBandEmissionTreshold[i] = AudioPear._audioBandBuffer[i];
            }
        }
        if (emissionTreshold == _emissionTreshold.NoBuffer)
        {
            for (int i = 0; i < 8; i++)
            {
                _audioBandEmissionTreshold[i] = AudioPear._audioBand[i];
            }
        }

        //Color
        if (emissionColor == _emissionColor.Buffered)
        {
            for (int i = 0; i < 8; i++)
            {
                _audioBandEmissionColor[i] = AudioPear._audioBandBuffer[i];
            }
        }
        if (emissionColor == _emissionColor.NoBuffer)
        {
            for (int i = 0; i < 8; i++)
            {
                _audioBandEmissionColor[i] = AudioPear._audioBand[i];
            }
        }

        //Scale
        if (atomScale == _atomScale.Buffered)
        {
            for (int i = 0; i < 8; i++)
            {
                _audioBandScale[i] = AudioPear._audioBandBuffer[i];
            }
        }
        if (atomScale == _atomScale.NoBuffer)
        {
            for (int i = 0; i < 8; i++)
            {
                _audioBandScale[i] = AudioPear._audioBand[i];
            }
        }

    }
}
