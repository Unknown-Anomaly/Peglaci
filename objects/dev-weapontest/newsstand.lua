function init()
  self.buyFactor = config.getParameter("buyFactor", root.assetJson("/merchant.config").defaultBuyFactor)

  object.setInteractive(true)
end

function onInteraction(args)
  local interactData = config.getParameter("interactData")

  interactData.recipes = {}
  local storeInventory = config.getParameter("storeInventory")
  local randomPool = config.getParameter("storeRandomPool")
  local tabs = config.getParameter("modTab")
  local addedTabs = {}
  local posY = 277
  local categories = {
      type = "radioGroup",
      toggleMode = false,
      buttons = {}
	}
  
  if #tabs > 0 then
	  for i,modtab in ipairs(tabs) do
      local tabIcon = modtab["file"]
      local tabName = modtab["label"]
      local tabFilter = modtab["filter"]
       
      addedTabs[tabName] = true
      local tabIconLabel = {
        type = "image",
        file = tabIcon,
        position = {
        5,
        posY
        },
        zlevel = 3
      }
      
      local tabNameLabel = {
        type = "label",
        value = tabName,
        position = {
        22,
        posY+2
        },
        zlevel = 3
      }
      
      local tabButton = {
          selected = true,
          position = {
          3,
          posY-2
          },
          baseImage = "/objects/dev-weapontest/interface/unselectedTab.png",
          baseImageChecked = "/objects/dev-weapontest/interface/selectedTab.png",
          data = {
          filter = tabFilter
          }
        }
      
      interactData.paneLayoutOverride["icon" .. tabName] = tabIconLabel
      interactData.paneLayoutOverride["lbl" .. tabName] = tabNameLabel
      table.insert(categories["buttons"], 1, tabButton)
      posY = posY - 18
    end
	  interactData.paneLayoutOverride["categories"] = categories
  end
      
  for genre,objects in pairs(storeInventory) do addRecipes(interactData, objects, genre) end
  for genre,objects in pairs(randomPool) do chooseRandom(interactData, objects, genre) end

  return { "OpenCraftingInterface", interactData }
end

function chooseRandom(interactData, items, category)

  local poolAmount = config.getParameter("poolAmount")
  local rotationTime = config.getParameter("rotationTime")
  local selectedItems = {}
  
  local featureCycle = math.floor(os.time() / (config.getParameter("rotationTime") * #items))
  math.randomseed(featureCycle)
  shuffle(items)
    
  if #items < poolAmount then poolAmount = #items end
  for i=1, poolAmount do table.insert(selectedItems, items[i]) end
    
  if #selectedItems > 0 then addRecipes(interactData, selectedItems, category) end
end

function addRecipes(interactData, items, category)
  
  if (#items > 0) and isTable(items[1]) then
    -- statically shuffle collections
    local featureCycle = math.floor(os.time() / (config.getParameter("rotationTime") * #items))
    math.randomseed(featureCycle)
    shuffle(items)
    math.randomseed(os.time())
    local currentFeature = math.floor(os.time() / config.getParameter("rotationTime")) % #items + 1    
    addRecipes(interactData, items[currentFeature], category)
  else
    for i, item in ipairs(items) do
      interactData.recipes[#interactData.recipes + 1] = generateRecipe(item, category)
    end
  end
end

function generateRecipe(itemName, category)
  return {
    input = { {"money", math.floor(self.buyFactor * (root.itemConfig(itemName).config.price or root.assetJson("/merchant.config").defaultItemPrice))} },
    output = itemName,
    groups = { category }
  }
end

function shuffle(list)
  for i=1,#list do
    local swapIndex = math.random(1,#list)
    list[i], list[swapIndex] = list[swapIndex], list[i]
  end
end

function isTable(object)
  return type(object) == "table"
end