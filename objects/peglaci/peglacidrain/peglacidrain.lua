function init()
  self.drainPos = object.position()
  self.conected = 0
  self.conections = {}
  if storage.state == nil then
    output(false)
  else
    output(storage.state)
  end
end

-- Change Animation
function output(state)
  if state ~= storage.state then
    storage.state = state
    if state then
      animator.setAnimationState("drainState", "on")
    else
      animator.setAnimationState("drainState", "off")
    end
  end
end


-- Removes Liquids at current position
function drain()
  if world.liquidAt(self.drainPos) and self.conected > 0 then
    
    liquidLevel = world.destroyLiquid(self.drainPos)
    if liquidLevel == nil then
      world.forceDestroyLiquid(self.drainPos)
      liquidLevel = {1,1.0}
    end
    sendLiquid(liquidLevel)
  end
end

function sendLiquid(liquidLevel)
  selectedOutput = math.random(1,self.conected)
  world.sendEntityMessage(self.conections[selectedOutput], "receiveLiquid", liquidLevel)
end

-- Check the connected outputs. Save any peglacypurifier on conections.
function onNodeConnectionChange(args)
  nodes = object.outputNodeCount()
  self.conected = 0
  self.conections = {}
  for i=0,nodes-1 do
    for k, v in pairs(object.getOutputNodeIds(i)) do
      if world.entityName(k) == "peglaciwaterpurifier" then
        self.conected = self.conected+1
        table.insert(self.conections, k)
      end
    end
  end
end

function update(dt)
  if not object.isInputNodeConnected(0) or object.getInputNodeLevel(0) then
    output(true)
    drain()
  else
    output(false)
  end
end
