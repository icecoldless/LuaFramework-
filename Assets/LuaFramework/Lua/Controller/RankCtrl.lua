RankCtrl = {};
local this = RankCtrl;

local luaBehaviour;
local transform;
local gameObject;
local data;
local json = require "cjson"
local util = require "3rd/cjson/util"
local isExp = false;
require "Controller/RankItem"
--构建函数--
function RankCtrl.New()
    logWarn("RankCtrl.New--->>");
    return this;
end

function RankCtrl.Awake()
    logWarn("RankCtrl.Awake--->>");
    panelMgr:CreatePanel('Rank', this.OnCreate);
end

--启动事件--
function RankCtrl.OnCreate(obj)
    gameObject = obj;

    luaBehaviour = gameObject:GetComponent('LuaBehaviour');
    logWarn("Start lua--->>"..gameObject.name);
    resMgr:LoadPrefab('rank', { 'RankItem' }, this.InitPanel);

    -- 事件注册
    luaBehaviour:AddClick(RankPanel.btnClose, this.OnClick);
    luaBehaviour:AddClick(RankPanel.btnExp,function()
        RankPanel.txtRankValue:GetComponent("Text").text = "经验值";
        this.isExp = true;
        this.Refresh();
    end);
    luaBehaviour:AddClick(RankPanel.btnCombatPower,function ()
        RankPanel.txtRankValue:GetComponent("Text").text = "战力";
        this.isExp = false;
        this.Refresh();
    end);
end

--初始化面板--
function RankCtrl.InitPanel(objs)
    ---@type table
    this.data = this.LoadData();
    table.sort(this.data.nodes,function (d1,d2)
        return d1.CombatPower<d2.CombatPower;
    end);
    local parent =RankPanel.RankItemParent;
    for i=1,#this.data.nodes do
        local go = newObject(objs[0])
        go.name = 'RankItem';
        go.transform:SetParent(parent.transform,false);
        go.transform.localScale = Vector3.one;
        go.transform.localPosition = Vector3.zero;
        local item = LuaFramework.LuaComponent.Add(go,RankItem);
        item.obj = go;
        item.rank = i;
        item.name = this.data.nodes[i]["Name"];
        item.job = this.data.nodes[i]["Job"];
        item.rankValue = this.data.nodes[i].CombatPower;
    end
end

function RankCtrl.Refresh()
    if this.isExp then
        table.sort(this.data.nodes,function (d1,d2)
            return d1.Exp<d2.Exp;
        end);
    else
        table.sort(this.data.nodes,function (d1,d2)
            return d1.CombatPower<d2.CombatPower;
        end);
    end
    ---@type UnityEngine.GameObject
    local parent =RankPanel.RankItemParent;
    -- 先删再加
    local tmp= {};
    for i = 1, parent.transform.childCount do
        tmp[i] = parent.transform:GetChild(i-1)
    end
    for i=1,#tmp do
        destroy(tmp[i].gameObject)
    end
    tmp = nil;
    resMgr:LoadPrefab('rank', { 'RankItem' }, this.CallBack);
end

function RankCtrl.CallBack(objs)
    ---@type UnityEngine.GameObject
    local parent =RankPanel.RankItemParent;
    for i=1,#this.data.nodes do
        local go = newObject(objs[0])
        go.name = 'RankItem';
        go.transform:SetParent(parent.transform,false);
        go.transform.localScale = Vector3.one;
        go.transform.localPosition = Vector3.zero;
        local item = LuaFramework.LuaComponent.Add(go,RankItem);
        item.obj = go;
        item.rank = i;
        item.name = this.data.nodes[i]["Name"];
        item.job = this.data.nodes[i]["Job"];
        if this.isExp then
            item.rankValue = this.data.nodes[i].Exp;
        else
            item.rankValue = this.data.nodes[i].CombatPower;
        end
    end
end
--cjson--
function RankCtrl.LoadData()
    local path = Util.DataPath.."lua/3rd/cjson/rank.json";
    local text =util.file_load(path);
    local t = json.decode(text)
    return t;
end

function RankCtrl.OnClick()
    destroy(gameObject)
end
--关闭事件--
function RankCtrl.Close()
    LuaFramework.Util.Log("Rank 销毁!!!")
    panelMgr:ClosePanel(CtrlNames.Rank);
end


