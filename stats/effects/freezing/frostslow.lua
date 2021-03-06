function init()
  animator.setParticleEmitterOffsetRegion("icetrail", mcontroller.boundBox())
  animator.setParticleEmitterActive("icetrail", true)
  effect.setParentDirectives("fade=00BBFF=0.05")

  script.setUpdateDelta(5)

  -- local slows = status.statusProperty("slows", {})
  -- slows["frostslow"] = 0.75
  -- status.setStatusProperty("slows", slows)
end

function update(dt)
  mcontroller.controlModifiers({
      jumpModifier = 0.25,
      speedModifier = 0.7
    })
end

function uninit()
  -- local slows = status.statusProperty("slows", {})
  -- slows["frostslow"] = nil
  -- status.setStatusProperty("slows", slows)
end