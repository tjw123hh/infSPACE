require 'data.blocks'
require 'data.entities'
WindowSize = cc.Director:getInstance():getOpenGLView():getFrameSize()
cc.Director:getInstance():getOpenGLView():setViewName('\xE6\x97\xA0\xE9\x99\x90\xE7\xA9\xBA\xE9\x97\xB4')
cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(960, 640, cc.ResolutionPolicy.SHOW_ALL)


MainScene = cc.Scene:create()

GUILayer = cc.Layer:create()
Cursor = cc.Sprite:create("gui/select.png")
Cursor:setAnchorPoint(0,0)
GUILayer:addChild(Cursor)

EntitiyLayer = cc.Layer:create()
Entities = {{['name'] = '', ['type'] = 'player', ['pos'] = {['x'] = 10, ['y'] = 10, ['z'] = 'main_1'}}}

BlockLayer = cc.Layer:create()
Blocks = {
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}},
	{{['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}, {['name'] = 'dirt'}}}
for x,BlocksInX in	pairs(Blocks) do
	for y,Block in pairs(BlocksInX) do
		Block['sprite'] = cc.Sprite:create('blocks/' .. Block['name'] .. '.png')
		Block['sprite']:setAnchorPoint(0, 0)
		Block['sprite']:setScale(4.0)
		Block['sprite']:setPosition(cc.p(x*32-32,y*32-32))
		BlockLayer:addChild(Block['sprite'])
	end
end


function OnTouchBegan(touch, event)
	PosOfTouch = cc.p(touch:getLocation()['x'], touch:getLocation()['y'])
	XOfTheBlockPointed = math.floor(PosOfTouch['x']/32)
	YOfTheBlockPointed = math.floor(PosOfTouch['y']/32)
	Cursor:setPosition(cc.p(XOfTheBlockPointed*32, YOfTheBlockPointed*32))
	local Angle = math.atan2(Entities[1]['sprites']['head']:getPositionX() - PosOfTouch['x'],Entities[1]['sprites']['head']:getPositionY() - (640 - PosOfTouch['y']))
	if PosOfTouch['x'] < Entities[1]['sprites']['head']:getPositionX() then
		ThetaOfHead = 90 - Angle * (180 / math.pi)
		Entities[1]['sprites']['head']:setRotation(ThetaOfHead)
		for _, Name in pairs(EntitiesData['player']['display'][1]['parts']) do
			Entities[1]['sprites'][Name]:setSpriteFrame(cc.Sprite:create('entities/player.png', EntitiesData['player']['display']['left'][Name]['rect']):getSpriteFrame())
		end
	else
		ThetaOfHead = - Angle * (180 / math.pi) - 90
		Entities[1]['sprites']['head']:setRotation(ThetaOfHead)
		for _, Name in pairs(EntitiesData['player']['display'][1]['parts']) do
			Entities[1]['sprites'][Name]:setSpriteFrame(cc.Sprite:create('entities/player.png', EntitiesData['player']['display']['right'][Name]['rect']):getSpriteFrame())
		end
	end
end
function OnTouchMoved(touch, event)
	PosOfTouch = cc.p(touch:getLocation()['x'], touch:getLocation()['y'])
	XOfTheBlockPointed = math.floor(PosOfTouch['x']/32)
	YOfTheBlockPointed = math.floor(PosOfTouch['y']/32)
	Cursor:setPosition(cc.p(XOfTheBlockPointed*32, YOfTheBlockPointed*32))
	local Angle = math.atan2(Entities[1]['sprites']['head']:getPositionX() - PosOfTouch['x'],Entities[1]['sprites']['head']:getPositionY() - (640 - PosOfTouch['y']))
	if PosOfTouch['x'] < Entities[1]['sprites']['head']:getPositionX() then
		ThetaOfHead = 90 - Angle * (180 / math.pi)
		Entities[1]['sprites']['head']:setRotation(ThetaOfHead)
		for _, Name in pairs(EntitiesData['player']['display'][1]['parts']) do
			Entities[1]['sprites'][Name]:setSpriteFrame(cc.Sprite:create('entities/player.png', EntitiesData['player']['display']['left'][Name]['rect']):getSpriteFrame())
		end
	else
		ThetaOfHead = - Angle * (180 / math.pi) - 90
		Entities[1]['sprites']['head']:setRotation(ThetaOfHead)
		for _, Name in pairs(EntitiesData['player']['display'][1]['parts']) do
			Entities[1]['sprites'][Name]:setSpriteFrame(cc.Sprite:create('entities/player.png', EntitiesData['player']['display']['right'][Name]['rect']):getSpriteFrame())
		end
	end
end
EventListenerTouch = cc.EventListenerTouchOneByOne:create()
EventListenerTouch:registerScriptHandler(OnTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
EventListenerTouch:registerScriptHandler(OnTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
MainScene:getEventDispatcher():addEventListenerWithSceneGraphPriority(EventListenerTouch, MainScene)

Update = cc.Director:getInstance():getScheduler():scheduleScriptFunc(
	function()
		for x, BlocksInX in pairs(Blocks) do
			for y,Block in pairs(BlocksInX) do
				Block['sprite']:setPosition(cc.p(x*32-32,y*32-32))
			end
		end
		for _, Entitiy in pairs(Entities) do		--����ʵ�壨�����֣���Spriteʵ��
			if Entitiy['sprites'] == nil then
				Entitiy['sprites'] = {}
				if Entitiy['action'] == nil then
					Entitiy['action'] = EntitiesData[Entitiy['type']]['display'][1]['default']
				end
				for _, Name in pairs(EntitiesData[Entitiy['type']]['display'][1]['parts']) do
					Entitiy['sprites'][Name] = cc.Sprite:create('entities/' .. Entitiy['type'] .. '.png', EntitiesData[Entitiy['type']]['display'][Entitiy['action']][Name]['rect'])
					Entitiy['sprites'][Name]:setScale(EntitiesData[Entitiy['type']]['display'][1]['scale'])
					Entitiy['sprites'][Name]:setAnchorPoint(EntitiesData[Entitiy['type']]['display'][Entitiy['action']][Name]['anchor_point'][1], EntitiesData[Entitiy['type']]['display'][Entitiy['action']][Name]['anchor_point'][2])
					Entitiy['sprites'][Name]:setPosition(cc.p(32 * (Entitiy['pos']['x']) + EntitiesData[Entitiy['type']]['display'][Entitiy['action']][Name]['offset'][1] * 2, 32 * (Entitiy['pos']['y']) + EntitiesData[Entitiy['type']]['display'][Entitiy['action']][Name]['offset'][2] * 2))--���굥λ:����	;ƫ�Ƶ�λ:����
					EntitiyLayer:addChild(Entitiy['sprites'][Name])
				end
			end
		end
	end,0.05,false)


MainScene:addChild(BlockLayer)
MainScene:addChild(EntitiyLayer)
MainScene:addChild(GUILayer)


cc.Director:getInstance():runWithScene(MainScene)