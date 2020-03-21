using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEngine;

[System.Serializable]
public class Node
{
    public string Name;
    public int Exp;
    public string Job;
    public int CombatPower;
}
[System.Serializable]
public class NodeClass
{
    public List<Node> nodes;
}
public class MyTest : MonoBehaviour
{
    private string filePath = "Assets/LuaFramework/Lua/3rd/cjson/rank.json";
    public NodeClass nodeClass;
    // Start is called before the first frame update
    void Start()
    {
        string nodejson = JsonUtility.ToJson(nodeClass);
        Debug.Log(nodejson);
        using (FileStream fs = new FileStream(filePath, FileMode.OpenOrCreate))
        {
            using (StreamWriter sw = new StreamWriter(fs, Encoding.UTF8))
            {
                sw.WriteLine(nodejson);
            }
        }
    }
}
