### README.md

Unity Shader Start Up이라는 책과 유투브를 통해공부하고 실습한 파일 입니다.
용도별로 분류해 스크립트, 쉐이더 파일을 적용했습니다

#### Scene

##### AtomicAudioVisuals
<img src="https://postfiles.pstatic.net/MjAxOTEyMDRfNzUg/MDAxNTc1NDAyNzY1NTE0.eSz7IcQJKa0xDxOdGp0DdJLBPa95RLcnyEgE9S7Jj6Ug.y40CGL7gCPZP58-eYQyRsabf8BZt1BQauAxTBIadwfog.PNG.whdals410/UnityShader_Scene_AtomicAudioVisual_1.png?type=w773" width="40%" height="30%" title="px(픽셀) 크기 설정" alt="IMG"></img>
<img src="https://postfiles.pstatic.net/MjAxOTEyMDRfMjM0/MDAxNTc1NDAyNzY1NTE3.VfzdyKC7QVOpHTDhAErMM-Mhk2mnyqaTE8gYyR84BNwg.Qf6zTLsNqdyKR28ydMxgHurTst7RhDvRcyYFmilNfzsg.PNG.whdals410/UnityShader_Scene_AtomicAudioVisual_2.png?type=w773" width="40%" height="30%" title="px(픽셀) 크기 설정" alt="IMG"></img>

+ 음악의소리에따라 반응하는 오브젝트 구현
+ 각 음역대에 따라 중심 공의 크기를 조절

``` csharp
void SelectAudioValue()
    {
	...
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
```
+ 시작시 작은 공모양의 오브젝트 N개 생성후 Rigidbody의 .velocity.magnitude로 자석처럼 붙어다니게 구현

```csharp
void Update()
    {
       	...
            if (_rigidbody.velocity.magnitude > _maxMagnitude)
            {
                _rigidbody.velocity = _rigidbody.velocity.normalized * _maxMagnitude;
            }
        	...
    }
```

+ Post Processing으로 빛 번짐 효과 구현
***

##### AudioVisualization 
<img src="https://postfiles.pstatic.net/MjAxOTEyMDRfOTQg/MDAxNTc1NDAyNzY1NjMy.JrM0ejepteE7aiKWcuolttBc-HF1ifkJp6zhiQaM_OMg.WaaESsJRqmKNnuhepg91bvAxAbVXIzhyxbiwZghWwksg.PNG.whdals410/UnityShader_Scene_AudioVisualization_1.png?type=w773" width="40%" height="30%" title="px(픽셀) 크기 설정" alt="IMG"></img>

+ 각 음역대에 따라 큐브의 크기를 조절하여 표현
+ 음 높이에 따라 색 변환
***

##### BNT_Test
<img src="https://postfiles.pstatic.net/MjAxOTEyMDRfMjk5/MDAxNTc1NDAyNzY1NTMy.I7PGTm8QwU8y3a4yQFL_KrxuFWcqxsluHCbTiuNGxY0g.1plsBP0JZ4iXnPXhotx3x7PEnzIClX_7DK4yngXm3-Ig.PNG.whdals410/UnityShader_Scene_BNT_Test.png?type=w773" width="40%" height="30%" title="px(픽셀) 크기 설정" alt="IMG"></img>

+ 왼쪽 공에서 오른쪽 공으로 향하는 점선 표현
+ LineRenderer의 Material Shader를 제작해 C#파일로 조작
***

##### ProceduralPhyllotaxis
<img src="https://postfiles.pstatic.net/MjAxOTEyMDRfNjYg/MDAxNTc1NDAyNzY1NTY4.CF76lgmtqwhoDRq99HxmKRRzC2sfnpz92uh9XANSKI4g.JoJGea_Fr8KuAAMCQDkgsFt6OX0g5yNeoyOhbRaXcHkg.PNG.whdals410/UnityShader_Scene_ProceduralPhyllotaxis.png?type=w773" width="40%" height="30%" title="px(픽셀) 크기 설정" alt="IMG"></img>
+ Trail Renderer의 속성을 이용해 기하학 무늬 생성
***

##### ProceduralPhyllotaxis3
<img src="https://postfiles.pstatic.net/MjAxOTEyMDRfMTE2/MDAxNTc1NDAyNzY1Njc0.Df9y40a8tRFXat803XB4aMGBgID1GR0Drd4UcMQq9Bog.j_-Kc9IXa9ZyJzZ_W8H5EcEZzB0sEP-hWD5UFV5ORkYg.PNG.whdals410/UnityShader_Scene_ProceduralPhyllotaxis3.png?type=w773" width="40%" height="30%" title="px(픽셀) 크기 설정" alt="IMG"></img>
+ 음의 높낮이로 선을 긋는 속도 조절
+ 음의 높이가 높고, 소리가 클수록 더 빨리 그리게 구현
***

##### Sample Scene
<img src="https://postfiles.pstatic.net/MjAxOTEyMDRfMjI1/MDAxNTc1NDAyNzY1NzMy.cpejjaGtg8lnHoXJ0T889G50kviyMGthurFTSD5WZZ4g.nQLMl9TKcIJGAPyyHpnqol2x4vNSZd27Dolkg08jwRAg.PNG.whdals410/UnityShader_Scene_SampleScene.png?type=w773" width="40%" height="30%" title="px(픽셀) 크기 설정" alt="IMG"></img>
+ 각종 질감과 효과를 모두 모아놓은 씬
