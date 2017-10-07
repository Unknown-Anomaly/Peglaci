require "/items/active/weapons/ranged/gunfire.lua"

IcethrowerAttack = GunFire:new()

function IcethrowerAttack:init()
  GunFire.init(self)

  self.active = false
end

function IcethrowerAttack:update(dt, fireMode, shiftHeld)
  GunFire.update(self, dt, fireMode, shiftHeld)

  if self.weapon.currentAbility == self then
    if not self.active then self:activate() end
  elseif self.active then
    self:deactivate()
  end
end

function IcethrowerAttack:muzzleFlash()
  --disable normal muzzle flash
end

function IcethrowerAttack:activate()
  self.active = true
  animator.playSound("fireStart")
  animator.playSound("fireLoop", -1)
  animator.setAnimationState("firing", "charge")
end

function IcethrowerAttack:deactivate()
  self.active = false
  animator.stopAllSounds("fireStart")
  animator.stopAllSounds("fireLoop")
  animator.playSound("fireEnd")
  animator.setAnimationState("firing", "fire")
end
