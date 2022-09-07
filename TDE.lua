-- title:  game title
-- author: game developer
-- desc:   short description
-- script: lua

t=0
w,h=240,136
flr=math.floor
debug=false
 
p={
	idx=256,
	x=0,
	y=0,
	vx=0,
	vy=0,
	vmax=1,
	flp=0
}
 
coll={
	tlx=0, --Defines where the left collider is
	tly=0, --Defines where the top collider is
	trx=15,--Defines where the right collider is
	cly1=7,--Defines where the left top mid collider is
	cly2=8,--Defines where the left bottom mid collider is
	cry1=7,--Defines where the right top mid collider is
	cry2=8 --Defines where the right bottom mid collider is
}
 
function Init()
	TIC=Update
end

function Debug()
	if debug then
		pix(p.x%240+coll.tlx+p.vx,p.y%136+coll.tly+p.vy,2) --top left
		pix(p.x%240+coll.trx+p.vx,p.y%136+coll.tly+p.vy,2) --top right
		pix(p.x%240+7+p.vx,p.y%136+coll.tly+p.vy,15) --top mid
		pix(p.x%240+8+p.vx,p.y%136+coll.tly+p.vy,15) --top mid
		pix(p.x%240+coll.tlx+p.vx,p.y%136+15+p.vy,2) --bottom left
		pix(p.x%240+coll.trx+p.vx,p.y%136+15+p.vy,2) --bottom right
		pix(p.x%240+7+p.vx,p.y%136+16+p.vy,7) --bottom mid
		pix(p.x%240+8+p.vx,p.y%136+16+p.vy,7) --bottom mid
		--On ground indicators
		pix(p.x%240+coll.tlx,p.y%136+16+p.vy,12) --bottom left
		pix(p.x%240+coll.trx,p.y%136+16+p.vy,12) --bottom right
		--Middle left indicators
		pix(p.x%240+coll.tlx+p.vx,p.y%136+coll.cly1,8) --left center
		pix(p.x%240+coll.tlx+p.vx,p.y%136+coll.cly2,8) --left center
		--Middle right indicators
		pix(p.x%240+coll.trx+p.vx,p.y%136+coll.cry1,8) --right center
		pix(p.x%240+coll.trx+p.vx,p.y%136+coll.cry2,8) --right center
	end
end
 
function Main()
	cls()
	map((p.x//240)*30,(p.y//136)*17,30,17,0,0,0,1,AnimTiles)
	spr(p.idx,p.x%240,p.y%136,14,1,p.flp,0,2,2)
end
 
function Update()
	Main()
	Player()
	
	if keyp(9) and not debug then
		debug=true
	elseif keyp(9) and debug then
		debug=false
	end
end

function OVR()
	Debug()
end

function Player()
	if btn(0) then 
		p.vy=-p.vmax
	elseif btn(1) then 
		p.vy=p.vmax
	else
		p.vy=0
	end
	
	if btn(2) then 
		p.vx=-p.vmax
	elseif btn(3) then
		p.vx=p.vmax
	else
		p.vx=0
	end
	
	--side collider detection
	if solid(p.x+coll.tlx+p.vx,p.y+coll.tly+p.vy,0) or 
		solid(p.x+coll.trx+p.vx,p.y+coll.tly+p.vy,0) or
		solid(p.x+coll.tlx+p.vx,p.y+15+p.vy,0) or
		solid(p.x+coll.trx+p.vx,p.y+15+p.vy,0) or
		solid(p.x+coll.tlx+p.vx,p.y+coll.cly1,0) or
		solid(p.x+coll.tlx+p.vx,p.y+coll.cly2,0) or
		solid(p.x+coll.trx+p.vx,p.y+coll.cry1,0) or
		solid(p.x+coll.trx+p.vx,p.y+coll.cry2,0) then
		p.vx=0
		print("detected side",0,0,2)
	end
	--top and bottom collider detection
	if solid(p.x+coll.tlx,p.y+15+p.vy,0) or --bot corner l
		solid(p.x+coll.trx,p.y+15+p.vy,0) or --bot corner r
		solid(p.x+7+p.vx,p.y+15+p.vy,0) or --mid bot
		solid(p.x+8+p.vx,p.y+15+p.vy,0) or --mid bot
		solid(p.x+coll.tlx+p.vx,p.y+p.vy,0) or --top corner l
		solid(p.x+coll.trx+p.vx,p.y+p.vy,0) or --top corner r
		solid(p.x+7+p.vx,p.y+p.vy,0) or --mid top
		solid(p.x+8+p.vx,p.y+p.vy,0) then --mid top
		p.vy=0
		print("detected top",0,8,2)
	end
	
	p.x=p.x+p.vx
	p.y=p.y+p.vy
end
 
Init()
 
function solid(x,y,f)
	return fget(mget(flr(x//8),flr(y//8)),f)
end

-- <TILES>
-- 001:9000000900000000000000000009900000099000000000000000000090000009
-- 002:2000000200000000000000000002200000022000000000000000000020000002
-- 003:4444444444444444444444444444444444444444444444444444444444444444
-- 004:bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
-- </TILES>

-- <SPRITES>
-- 000:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 001:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 002:eccccccccc888888caaaaaaaca888888cacccccccacccccccacc0ccccacc0ccc
-- 003:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0c0cca0c0c0cca0c0c
-- 016:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 017:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 018:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 019:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- </SPRITES>

-- <MAP>
-- 000:100000000000000000000000000000000000000000000000000000000020100000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 005:000000000000000000000000000000000000404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 006:000000000000000000000000000000000000303000000000000000000000000000000000000000000000003030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 007:000000000000000000000000300000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 008:000000000000000000000000300000000000000000000000000000000000000000000000000000000000000030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 009:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 010:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 011:000000000000000000000000000000000000000000000000000000000000000000000000000000000000003030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 012:000000000000000000000000000000000000003000000000000000000000000000000000000000000000003030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 016:100000000000000000000000000000000000000000000000000000000020100000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 017:100000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 033:100000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
-- 000:00000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </FLAGS>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

