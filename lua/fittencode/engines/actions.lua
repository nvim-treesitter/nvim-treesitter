local Actions = {
  DocumentCode = 0,
  EditCode = 1,
  ExplainCode = 2,
  FindBugs = 3,
  GenerateUnitTest = 4,
  StartChat = 5
}

local ActionsEngine = {}

function ActionsEngine.start_action(action)
  -- TODO: Implement actions
  print("Starting action: ", action)
end

function ActionsEngine.documment_code()
  ActionsEngine.start_action(Actions.DocumentCode)
end

function ActionsEngine.setup()
end

return ActionsEngine
