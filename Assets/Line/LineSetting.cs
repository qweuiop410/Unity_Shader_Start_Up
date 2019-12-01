using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LineSetting : MonoBehaviour
{
    private LineRenderer lr;
    private Material lineMat;

    [Header("Positions")]
    //사이 지점
    public Vector3[] positions = new Vector3[2];
    //종료 지점
    [Header("End Position Object")]
    public GameObject endPos;

    [Header("Line Setting")]
    // 라인 텍스쳐
    public Texture lineTex;

    //라인 색
    public Color lineColor;

    //이동 속도
    [Range(-30, 30)]
    public float lineSpeed = 10;

    //라인 굵기
    [Range(0, 1)]
    public float lineStartWidth = 0.5f;
    [Range(0, 1)]
    public float lineEndWidth = 0.5f;


    void Start()
    {
        lr = transform.GetComponent<LineRenderer>();
        lr.positionCount = positions.Length + 2;
        lineMat = lr.material;
    }


    void Update()
    {
        //라인의 시작점 = 현재 오브젝트의 위치
        lr.SetPosition(0, transform.position);

        //라인의 사이 지점
        for (int i = 0; i < positions.Length; i++)
        {
            lr.SetPosition(i + 1, positions[i]);
        }

        //라인의 종료 지점 = endPos의 위치
        lr.SetPosition(positions.Length + 1, endPos.transform.position);

        //라인의 시작점 굵기
        lr.startWidth = lineStartWidth;
        //라인의 종료점 굵기
        lr.endWidth = lineEndWidth;

        //쉐이더 값 참조
        lineMat.SetTexture("_MainTex", lineTex);
        lineMat.SetColor("_Color", lineColor);
        lineMat.SetFloat("_LineSpeed", lineSpeed);
    }
}
