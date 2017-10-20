function init()
  self.spawnedEntityId = nil

  self.state = stateMachine.create({
    "spawnState"
  })
  self.state.leavingState = function(stateName)
    entity.setAnimationState("movement", "idle")
  end

  entity.setAnimationState("movement", "idle")
  entity.setInteractive(false)
end

function update(dt)
  if self.spawnedEntityId ~= nil and not world.entityExists(self.spawnedEntityId) then
    self.spawnedEntityId = nil
  end

  self.state.update(dt)
end

--------------------------------------------------------------------------------
spawnState = {}

function spawnState.enter()
  if self.spawnedEntityId ~= nil then return nil end

  return { timer = 0, spawned = false }
end

function spawnState.update(dt, stateData)
  local animation = entity.animationState("movement")
  if animation == "idle" then
    if stateData.spawned then
      return true, entity.configParameter("spawnCooldownTime")
    else
      entity.setAnimationState("movement", "spawn")
    end
  elseif animation == "spawn" then
    stateData.timer = stateData.timer + dt

    if not stateData.spawned and stateData.timer > entity.configParameter("spawnTime") then
      self.spawnedEntityId = world.spawnNpc(spawnState.spawnPosition(), "apex", "default", entity.level())
      stateData.spawned = true
    end
  elseif animation == "idleOpen" then
    stateData.timer = stateData.timer + dt

    if stateData.timer > entity.configParameter("closeTime") then
      entity.setAnimationState("movement", "close")
    end
  end

  return false
end

function spawnState.spawnPosition()
  return vec2.add(entity.position(), entity.configParameter("spawnOffset"))
end
