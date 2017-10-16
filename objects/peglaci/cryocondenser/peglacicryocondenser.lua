require "/scripts/util.lua"

function craftingRecipe(items)
  if #items ~= 1 then return end
  local item = items[1]
  if not item or item.name ~= "filledcapturepod" then return end

  local healedParams = copy(item.parameters) or {}
  jremove(healedParams, "inventoryIcon")
  jremove(healedParams, "currentPets")
  for _,pet in pairs(healedParams.pets) do
    jremove(pet, "status")
  end
  healedParams.podItemHasPriority = true

  local healed = {
      name = item.name,
      count = item.count,
      parameters = healedParams
    }

  return {
      input = items,
      output = healed,
      duration = 1.0
    }
end

function update(dt)
  local powerOn = false

  for _,item in pairs(world.containerItems(entity.id())) do
    if item.parameters and item.parameters.podUuid then
      powerOn = true
      break
    end
  end
end
