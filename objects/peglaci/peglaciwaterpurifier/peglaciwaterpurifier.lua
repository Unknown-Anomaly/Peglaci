function init()
  self.watersourcePos = object.position()
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
      animator.setAnimationState("purifierState", "on")
    else
      animator.setAnimationState("purifierState", "off")
    end
  end
end

-- creates Liquids at current position
function watersourcelimit(id,amount)
  local waterlevel = world.liquidAt(self.watersourcePos)
  if not waterlevel or waterlevel[2] < 0.7 then
    world.spawnLiquid(self.watersourcePos,id,amount)
  end
end

function watersource(id,amount)
    world.spawnLiquid(self.watersourcePos,id,amount)
end

function update(dt)
  
  if object.isInputNodeConnected(0) and object.getInputNodeLevel(0)  then
    output(true)
    watersourcelimit(1,1)
  else
    output(false)
  end
end
