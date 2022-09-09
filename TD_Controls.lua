-- title:  game title
-- author: game developer
-- desc:   short description
-- script: lua

flr=math.floor
t=0

p={
	idx=256,
	facing="down",
	x=32,
	y=32,
	idle=true,
	flp=false,
	canMove=true,
	s={
		faceUp=264,
		faceDown=260,
		faceSide=268
	}
}

c={
	up=0,
	down=1,
	left=2,
	right=3,
	z=4, --A
	x=5, --B
	a=6,
	s=7
}

function Init()
	TIC=Update
end

function Main()
	cls()
	map()
	spr(p.idx,p.x,p.y,0,1,p.flp,0,2,2)
end

function Update()
	Main()
	Controls()
	t=t+1
end

Init()

col={
	ty=0,
	by=16,--default 16
	lx=0,
	rx=16 --default 16
}

function OVR()
	--top
	pix(p.x+col.lx,p.y-1+col.ty,2) pix(p.x+col.rx-1,p.y-1+col.ty,2)
	--bot
	pix(p.x+col.lx,p.y+col.by,4) pix(p.x+col.rx-1,p.y+col.by,4)
	--left
	pix(p.x-1+col.lx,p.y+col.ty,5) pix(p.x-1+col.lx,p.y+col.by-1,5)
	--right
	pix(p.x+col.rx,p.y+col.ty,11) pix(p.x+col.rx,p.y+col.by-1,10)
	--pix(p.x+16,p.y+col.ty,11) pix(p.x+16,p.y+15,10)

end

function Controls()

	if p.canMove==true then
		if btn(c.up) and not solid(p.x+col.lx,p.y-1+col.ty) and not solid(p.x+col.rx-1,p.y-1+col.ty) then
			c_up()
			p.facing="up"
		end
		
		if btn(c.down) and not solid(p.x+col.lx,p.y+col.by) and not solid(p.x+col.rx-1,p.y+col.by) then
			c_down()
			p.facing="down"
		end
		
		if btn(c.left) and not solid(p.x-1+col.lx,p.y+col.ty) and not solid(p.x-1+col.lx,p.y+col.by-1) then 
			c_left()
			p.facing="left"
		end
			
		if btn(c.right) and not solid(p.x+col.rx,p.y+col.ty) and not solid(p.x+col.rx,p.y+col.by-1) then
			c_right()
			p.facing="right"
		end
	end
end

function c_up()
	if p.facing=="up" then
		p.idx=264--[[+t%60//30*2]]
	else
		p.idx=p.s.faceUp
	end
	p.idle=false
	p.y=p.y-1
end

function c_down()
	if p.facing=="down" then
		p.idx=260--[[+t%60//30*2]]
	else
		p.idx=p.s.faceDown
	end
	p.idle=false
	p.y=p.y+1
end

function c_left()
	if p.facing=="left" then
		p.idx=268--[[+t%60//30*2]]
		p.flp=0
	else
		p.idx=p.s.faceSide
	end	
	p.flp=0
	p.idle=true
	p.x=p.x-1
end

function c_right()
	if p.facing=="right" then
		p.idx=268--[[+t%60//30*2]]
		p.flp=1
	else
		p.idx=p.s.faceSide
		p.flp=1
	end
	p.idle=true
	p.x=p.x+1
end

function solid(x,y)
	return fget(mget(flr(x/8),flr(y/8)),0)
end
-- <TILES>
-- 001:3333333333333333333333333333333333333333333333333333333333333333
-- </TILES>

-- <SPRITES>
-- 000:cccccc11ccccccc1ccccccccccccccccccccddddccccdccc1cccdccc11ccdccc
-- 001:11cccccc1cccccccccccccccccccccccddddcccccccdcccccccdccc1cccdcc11
-- 004:ccccccccccccccccccccccccccccccccccccddddccccdcccccccdcccccccdccc
-- 005:ccccccccccccccccccccccccccccccccddddcccccccdcccccccdcccccccdcccc
-- 008:cccccc11ccccccc1ccccccccccccccccccccddddccccdcccccccdcccccccdccc
-- 009:11cccccc1cccccccccccccccccccccccddddcccccccdcccccccdcccccccdcccc
-- 012:ccccccccccccccccccccccccccccccccccccddddccccdccc1cccdccc11ccdccc
-- 013:ccccccccccccccccccccccccccccccccddddcccccccdcccccccdcccccccdcccc
-- 016:11ccdccc1cccdcccccccdcccccccddddccccccccccccccccccccccc1cccccc11
-- 017:cccdcc11cccdccc1cccdccccddddcccccccccccccccccccc1ccccccc11cccccc
-- 020:ccccdcccccccdcccccccdcccccccddddccccccccccccccccccccccc1cccccc11
-- 021:cccdcccccccdcccccccdccccddddcccccccccccccccccccc1ccccccc11cccccc
-- 024:ccccdcccccccdcccccccdcccccccddddcccccccccccccccccccccccccccccccc
-- 025:cccdcccccccdcccccccdccccddddcccccccccccccccccccccccccccccccccccc
-- 028:11ccdccc1cccdcccccccdcccccccddddcccccccccccccccccccccccccccccccc
-- 029:cccdcccccccdcccccccdccccddddcccccccccccccccccccccccccccccccccccc
-- </SPRITES>

-- <MAP>
-- 007:000000000000000000000000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 008:000000000000000000000000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </MAP>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <FLAGS>
-- 000:00100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </FLAGS>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

