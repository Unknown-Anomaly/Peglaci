function init()
  animator.setParticleEmitterOffsetRegion("icetrail", mcontroller.boundBox())
  animator.setParticleEmitterActive("icetrail", true)
  effect.setParentDirectives("fade=00BBFF=0.15")

  script.setUpdateDelta(5)

  local slows = status.statusProperty("slows", {})
  slows["frostslow"] = 0.75
  status.setStatusProperty("slows", slows)
end

function update(dt)
  mcontroller.controlModifiers({
      groundMovementModifier = -0.7,
      runModifier = -0.25,
      jumpModifier = -0.25
    })
end

function uninit()
  local slows = status.statusProperty("slows", {})
  slows["frostslow"] = nil
  status.setStatusProperty("slows", slows)
end