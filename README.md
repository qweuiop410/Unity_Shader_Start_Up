### README.md

Unity Shader Start Up이라는 책과 유투브를 통해공부하고 실습한 파일 입니다.
용도별로 분류해 스크립트, 쉐이더 파일을 적용했습니다

##Scene

AtomicAudioVisuals
+음악의소리에따라 반응하는 오브젝트 구현
+각 음역대에 따라 중심 공의 크기를 조절
This is a normal paragraph: 
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
end code block.
