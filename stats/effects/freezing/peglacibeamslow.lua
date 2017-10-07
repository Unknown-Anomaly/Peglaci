function init()
  animator.setParticleEmitterOffsetRegion("icetrail", mcontroller.boundBox())
  animator.setParticleEmitterActive("icetrail", true)
  effect.setParentDirectives("fade=00BBFF=0.05")
  self.timer = 2.5
  script.setUpdateDelta(3)

  -- local slows = status.statusProperty("slows", {})
  -- slows["frostslow"] = 0.75
  -- status.setStatusProperty("slows", slows)
end

function update(dt)
  mcontroller.controlModifiers({
      jumpModifier = 0.25,
      speedModifier = 0.7
    })
    
    self.timer = self.timer - dt
    
    if self.timer < 0 then
      status.addEphemeralEffect("peglacibeamstop")
    end
end

function uninit()
  -- local slows = status.statusProperty("slows", {})
  -- slows["frostslow"] = nil
  -- status.setStatusProperty("slows", slows)
end