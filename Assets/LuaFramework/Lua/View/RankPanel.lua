local transform;
local gameObject;

RankPanel = {};
local this = RankPanel;

--启动事件--
function RankPanel.Awake(obj)
    gameObject = obj;
    transform = obj.transform;
    this.InitPanel();
    logWarn("Awake lua--->>"..gameObject.name);
end

--初始化面板--
function RankPanel.InitPanel()
    this.btnClose = FindChildNode(transform,"btnClose").gameObject;
    this.txtRankValue=  FindChildNode(transform,"txtRankValue").gameObject;
    this.RankItemParent=FindChildNode(transform,"LstItemParent").gameObject;
    this.btnCombatPower = FindChildNode(transform,"btnCombatPower").gameObject;
    this.btnExp = FindChildNode(transform,"btnExp").gameObject;
end

--单击事件--
function RankPanel.OnDestroy()
    logWarn("OnDestroy---->>>");
end

