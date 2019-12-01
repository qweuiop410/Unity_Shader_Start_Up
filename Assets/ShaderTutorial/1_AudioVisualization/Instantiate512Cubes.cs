using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Instantiate512Cubes : MonoBehaviour
{
    public GameObject _sampleCubePreafab;
    GameObject[] _sampleCube = new GameObject[512];
    public float _maxScale;

    // Start is called before the first frame update
    void Start()
    {
        //오브젝트 원형 배치
        for (int i = 0; i < 512; i++)
        {
            //오브젝트 생성
            GameObject _instanceSampleCube = (GameObject)Instantiate(_sampleCubePreafab);

            //생성한 오브젝트 현재 위치로 초기화
            _instanceSampleCube.transform.position = this.transform.position;
            _instanceSampleCube.transform.parent = this.transform;
            _instanceSampleCube.name = "SampleCube " + i;

            //( 360 / 512 = 0.703125 ) 생성된 오브젝트 1개당 0.703125 도씩 회전
            this.transform.eulerAngles = new Vector3(0, -0.703125f * i, 0);
            //회전된 방향에서 100의 길이만큼 멀어진 곳에 배치
            _instanceSampleCube.transform.position = Vector3.forward * 100;


            _sampleCube[i] = _instanceSampleCube;
        }
    }

    // Update is called once per frame
    void Update()
    {
        for (int i = 0; i < 512; i++)
        {
            if (_sampleCube != null)
            {
                _sampleCube[i].transform.localScale = new Vector3(1, (AudioPear._samplesLeft[i] * _maxScale) + 2, 1);
                //_sampleCube[i].transform.localScale = new Vector3(1, (AudioPear._samplesLeft[i] * _maxScale) + 2, 1);
            }
        }
    }
}
