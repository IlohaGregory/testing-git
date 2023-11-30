stateMachine = Class {}

function stateMachine:init(states)
    self.empty = {
        update = function() end,
        enter = function() end,
        exit = function() end,
        render = function() end
    }
    self.states = states or {}
    self.current = self.empty
end

function stateMachine:change(stateName, enterPara)
    assert(self.states[stateName])
    self.current = self.states[stateName]()
end

function stateMachine:update(dt)
    self.current:update(dt)
end

function stateMachine:render()
    self.current:render()
end
