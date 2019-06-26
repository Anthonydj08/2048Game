
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoGame()
    composer.gotoScene( "game", { time=800, effect="slideLeft" }  )
end
 
local function gotoRecordes()
    composer.gotoScene( "recordes", { time=800, effect="slideLeft" }  )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	
	local background = display.newImageRect( sceneGroup, "images/background.png", 800, 1400 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY

	local title = display.newImageRect( sceneGroup, "images/2048.png", 120, 120 )
    title.x = display.contentCenterX
	title.y = 100
	
	local playButton = display.newText(sceneGroup, "Novo Jogo", display.contentCenterX, 300, "Exo2-Medium.ttf", 35)
	playButton:setFillColor(0.66, 0.58, 0.52)
 
    local RecordesButton = display.newText( sceneGroup, "Recordes", display.contentCenterX, 360, "Exo2-Medium.ttf", 35 )
	RecordesButton:setFillColor(0.66, 0.58, 0.52)
	
	playButton:addEventListener( "tap", gotoGame )
    RecordesButton:addEventListener( "tap", gotoRecordes )
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
