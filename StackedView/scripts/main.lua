--Start of Global Scope---------------------------------------------------------

-- Table containing names of the variable states

local stateList = {
  "state1",
  "state2",
  "state3"
}

-- Creating timers

local timer_StackedView1 = Timer.create()
timer_StackedView1:setExpirationTime(1000)
timer_StackedView1:setPeriodic(true)

local timer_StackedView2 = Timer.create()
timer_StackedView2:setExpirationTime(2500)
timer_StackedView2:setPeriodic(true)

-- Declaring iterators used to loop over the stateList indices

local iterator1 = 1
local iterator2 = 1

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

-- Serving the state change events.
Script.serveEvent("StackedView.OnStateChanged_StackedView1", "OnStateChanged_StackedView1")
Script.serveEvent("StackedView.OnStateChanged_StackedView2", "OnStateChanged_StackedView2")

-- Declaring function for getter bindings - used to update the states of the StackedViews on browser refresh

--@getState_StackedView1():string
local function getState_StackedView1()
  return stateList[iterator1]
end
Script.serveFunction("StackedView.getState_StackedView1", getState_StackedView1)

--@getState_StackedView2():string
local function getState_StackedView2()
  return stateList[iterator2]
end
Script.serveFunction("StackedView.getState_StackedView2", getState_StackedView2)

-- Binding timer's OnExpired events to functions that increment the iterator and notify the events about the state change

--@handleOnExpired_StackedView1()
local function handleOnExpired_StackedView1()
  iterator1 = math.min(iterator1+1,(iterator1+2)%(#stateList+2)+1) -- this loops over the maximum list lenght
  Script.notifyEvent("OnStateChanged_StackedView1", stateList[iterator1])
end
timer_StackedView1:register("OnExpired", handleOnExpired_StackedView1)

--@handleOnExpired_StackedView2()
local function handleOnExpired_StackedView2()
  iterator2 = math.min(iterator2+1,(iterator2+2)%(#stateList+2)+1)
  Script.notifyEvent("OnStateChanged_StackedView2", stateList[iterator2])
end
timer_StackedView2:register("OnExpired", handleOnExpired_StackedView2)

-- Start the timers when the engine starts

local function main()
  timer_StackedView1:start()
  timer_StackedView2:start()
end
Script.register('Engine.OnStarted', main)

--End of Function and Event Scope-----------------------------------------------
