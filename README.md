### README.md

Unity Shader Start Up이라는 책과 유투브를 통해공부하고 실습한 파일 입니다.
용도별로 분류해 스크립트, 쉐이더 파일을 적용했습니다

![Alt text](C:\Users\KJM\Desktop\aa_1.png)

## Scene

# AtomicAudioVisuals
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

# AudioVisualization 
+ 각 음역대에 따라 큐브의 크기를 조절하여 표현
+ 음 높이에 따라 색 변환

# BNT_Test
+ 왼쪽 공에서 오른쪽 공으로 향하는 점선 표현
+ LineRenderer의 Material Shader를 제작해 C#파일로 조작

# ProceduralPhyllotaxis
+ Trail Renderer의 속성을 이용해 기하학 무늬 생성

# ProceduralPhyllotaxis3
+ 음의 높낮이로 선을 긋는 속도 조절

# Sample Scene
+ 각종 질감과 효과를 모두 모아놓은 씬
