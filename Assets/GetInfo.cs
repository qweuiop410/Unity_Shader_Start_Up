using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GetInfo : MonoBehaviour
{
    public string url;

    private string getInfo;
    private string outPutInfo = "";

    private void Start()
    {
        StartCoroutine(PlayStoreVersionCheck());
    }

    void CkeckString()
    {
        string s = getInfo;
        
        for (int i = 0; i < s.Length; i++)
        {
            if (IsKorean(s[i]) == true)
            {
                outPutInfo += s[i].ToString();
            }
            else
            {
                try
                {
                    if (outPutInfo.Length > 0)
                    {
                        if (outPutInfo[outPutInfo.Length - 1] == '/')
                        {
                            outPutInfo += "";
                        }
                        else
                        {
                            outPutInfo += "/";
                        }
                    }
                }
                catch (Exception e)
                {
                    Debug.Log(e.Message);
                }
            }
        }

        Debug.Log(outPutInfo);
    }

    private IEnumerator PlayStoreVersionCheck()
    {
        WWW www = new WWW(url);
        yield return www;

        try
        {
            if (www.error == null)
            {
                int index = www.text.IndexOf("business");
                string versionText = www.text.Substring(index, 9999);

                getInfo = versionText;
                Debug.Log(versionText);
            }
            CkeckString();
        }
        catch(Exception e)
        {
            Debug.Log(e.Message);
        }
    }

    bool IsKorean(char ch)
    {
        //( 한글자 || 자음 , 모음 )
        if ((0xAC00 <= ch && ch <= 0xD7A3) || (0x3131 <= ch && ch <= 0x318E))
            return true;
        else
            return false;
    }
}
