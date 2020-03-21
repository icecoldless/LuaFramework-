RankItem = {
    --里面可以放一些属性
    name = "RankItem",
    rank = -1, --索引
    job = "ice",
    rankValue = 100,
    obj = nil,
}
function RankItem:Start()
    -- 设置Id
    FindChildNode(self.obj.transform,"txtRank"):GetComponent("Text").text = self.rank;
    -- 设置name
    FindChildNode(self.obj.transform,"txtName"):GetComponent("Text").text = self.name;
    -- 设置score
    FindChildNode(self.obj.transform,"txtJob"):GetComponent("Text").text = self.job;
    FindChildNode(self.obj.transform,"txtRankValue"):GetComponent("Text").text = self.rankValue;
end

--创建对象
function RankItem:New(obj)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end