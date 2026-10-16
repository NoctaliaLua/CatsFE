--no need to get and index the library tables with function names every time the script uses them
local osclock=os.clock
local tspawn=task.spawn
local tdelay=task.delay
local twait=task.wait
local schar=string.char
local ssub=string.sub
local sfind=string.find
local supper=string.upper
local mrandom=math.random
local sin=math.sin
local cos=math.cos
local abs=math.abs
local min=math.min
local sqrt=math.sqrt
local clamp=math.clamp
local tinsert=table.insert
local tclear=table.clear
local tclone=table.clone
local tfind=table.find
local cyield=coroutine.yield
local cresume=coroutine.resume
local crunning=coroutine.running
local vmagnitude=vector.magnitude --faster than indexing with Magnitude
local vnormalize=vector.normalize --faster than indexing with Unit

--the script doesnt have to read global varaibles every time to get them
--why not have them saved in local varaibles for faster access times
local next=next
local pcall=pcall
local xpcall=xpcall
local type=type
local typeof=typeof
local game=game
local sethiddenproperty=sethiddenproperty or set_hidden_property or sethiddenprop
local setscriptable=setscriptable or set_scriptable
local replicatesignal=replicatesignal or replicate_signal

local i=Instance.new 
local v2=Vector2.new 
local v3=Vector3.new
local c3=Color3.new 
local cf=CFrame.new
local cfl=CFrame.lookAt
local angles=CFrame.fromEulerAngles --faster than .Angles
local u2=UDim2.new 
local e=Enum 
local rp=RaycastParams.new 
local cs=ColorSequence.new 
local csk=ColorSequenceKeypoint.new 

local sine=osclock()
local deltaTime=0
local v3_0=v3()
local v3_101=v3(1,0,1)
local v3_010=v3(0,1,0)
local cf_0=cf()
local v3_xz=v3_101*10
local v3_xzL=v3_101*250.1
local v3_net=v3_010*25.01

local enumphysics=e.HumanoidStateType.Physics
local enumragdoll=e.HumanoidStateType.Ragdoll
local enumrunning=e.HumanoidStateType.Running
local enumseated=e.HumanoidStateType.Seated
local enumMD=e.MouseBehavior.Default

local sm=v3_010/2
local dense=PhysicalProperties.new(100,0,0,100,100)
local light=PhysicalProperties.new(0.0001,0,0,100,100)
local humstatesbl=e.HumanoidStateType:GetEnumItems()
table.remove(humstatesbl,tfind(humstatesbl,enumrunning))
table.remove(humstatesbl,tfind(humstatesbl,e.HumanoidStateType.None))

--not "local function rs" to not assign debug names
local rs=function()
	local s=""
	for i=1,mrandom(8,15) do
		if mrandom(2)==2 then
			s=s..schar(mrandom(65,90))
		else
			s=s..schar(mrandom(97,122))
		end
	end
	return s
end

--it runs even faster if u call __index and __newindex metamethods directly
local getMetamethodFromErrorStack=function(userdata,f,test)
	local ret=nil
	xpcall(f,function()
		ret=debug.info(2,"f")
	end,userdata,nil,0)
	if (type(ret)~="function") or not test(ret) then
		return f
	end
	return ret
end
local insSet=getMetamethodFromErrorStack(game,function(a,b,c) a[b]=c end,function(f) local a=i("Folder") local b=rs() f(a,"Name",b) return a.Name==b end)
local insGet=getMetamethodFromErrorStack(game,function(a,b) return a[b] end,function(f) local a=i("Folder") local b=rs() a.Name=b return f(a,"Name")==b end)
local cfGet=getMetamethodFromErrorStack(cf_0,function(a,b) return a[b] end,function(f) return f(cf(1,2,3),"Position")==v3(1,2,3) end)
local cfMul=getMetamethodFromErrorStack(cf_0,function(a,b) return a*b end,function(f) return angles(1,2,3)*angles(1,2,3)==f(angles(1,2,3),angles(1,2,3)) end)
local cfAdd=getMetamethodFromErrorStack(cf_0,function(a,b) return a+b end,function(f) return cf(1,2,3)+v3(1,2,3)==f(cf(1,2,3),v3(1,2,3)) end)
local v3Get=getMetamethodFromErrorStack(v3_0,function(a,b) return a[b] end,function(f) return v3(1,2,3).Unit==f(v3(1,2,3),"Unit") end)
local v2Get=getMetamethodFromErrorStack(v2(),function(a,b) return a[b] end,function(f) return f(v2(1,2),"Y")==2 end)
--multiplying and adding vector3 is faster if you use the * and + operators
--its faster to multiply X and Y of vector2 than to multiply vector2 and then get X and Y from it

--no need to index instances every time to call their functions
local Clone=insGet(game,"Clone")
local ClearAllChildren=insGet(game,"ClearAllChildren")
local Destroy=insGet(game,"Destroy")
local IsA=insGet(game,"IsA")
local FindFirstChildOfClass=insGet(game,"FindFirstChildOfClass")
local FindFirstChildWhichIsA=insGet(game,"FindFirstChildWhichIsA")
local GetChildren=insGet(game,"GetChildren")
local IsDescendantOf=insGet(game,"IsDescendantOf")
local QueryDescendants=insGet(game,"QueryDescendants")
local GetPropertyChangedSignal=insGet(game,"GetPropertyChangedSignal")

--findfirstchildofclass faster than getservice
local plrs=FindFirstChildOfClass(game,"Players")
local rus=FindFirstChildOfClass(game,"RunService")
local ws=FindFirstChildOfClass(game,"Workspace")
local uis=FindFirstChildOfClass(game,"UserInputService")
local gs=FindFirstChildOfClass(game,"GuiService")
local sg=FindFirstChildOfClass(game,"StarterGui")
local lp=insGet(plrs,"LocalPlayer")
local pg=FindFirstChildOfClass(lp,"PlayerGui")
local mouse=insGet(lp,"GetMouse")(lp)
local preanimation=insGet(rus,"PreAnimation")
local stepped=insGet(rus,"Stepped")
local heartbeat=insGet(rus,"Heartbeat")
local renderstepped=insGet(rus,"RenderStepped")

local GetPlayers=insGet(plrs,"GetPlayers")
local BreakJoints=insGet(i("Model"),"BreakJoints")
local ChangeState=insGet(i("Humanoid"),"ChangeState")
local SetStateEnabled=insGet(i("Humanoid"),"SetStateEnabled")
local GetJoints=insGet(insGet(ws,"Terrain"),"GetJoints")
local SetCoreGuiEnabled=insGet(sg,"SetCoreGuiEnabled")
local GetCoreGuiEnabled=insGet(sg,"GetCoreGuiEnabled")
local Raycast=insGet(ws,"Raycast")
local Connect=heartbeat.Connect
local Disconnect=Connect(GetPropertyChangedSignal(game,"CreatorId"),type).Disconnect
local Wait=heartbeat.Wait
local GetMouseLocation=insGet(uis,"GetMouseLocation")
local GetFocusedTextBox=insGet(uis,"GetFocusedTextBox")
local GetMouseDelta=insGet(uis,"GetMouseDelta")
local IsMouseButtonPressed=insGet(uis,"IsMouseButtonPressed")
local IsKeyDown=insGet(uis,"IsKeyDown")

local Inverse=cfGet(cf_0,"Inverse")
local Lerp=cfGet(cf_0,"Lerp")

local aligns={
	--[[
		example: 
		{PartName="Right Arm",meshid="123456789",textureid="123456789",AccessoryName="Name",C0=cf(1,2,3)*angles(1,2,3)},

		PartName (required) - the name of the body part you want to align the hat to
		meshid (optional) - mesh id of the mesh of the accessory you want to align
		textureid (optional) - texture id of the mesh of the accessory you want to align
		AccessoryName (optional) - instance name of the accessory you want to align 
		C0 (optional) - offset from the target body part to the accessory (defaults to cf(0,0,0) if unspecified)
		
		accessories will align to the first entry whose criteria they match
		(unspecified meshid/textureid/accessoryname accepts all accessories)
		
		each entry aligns one accessory at most
	]]

	-- unknown head
	{PartName="Head",meshid="11601535857",C0=angles(0,3.141592653589793,0)},

	-- patchma gear arms
	{PartName="Left Arm",meshid="13831073174",C0=cfMul(cf(0.017,0,-0.23),angles(-1.4835298641951802,-0.15707963267948966,2.199114857512855))},
	{PartName="Right Arm",meshid="13839903766",C0=cfMul(cf(0,-0.62,-0.01),angles(1.6580627893946132,0.15707963267948966,-2.199114857512855))},

	-- patchma yellow leg
	{PartName="Left Leg",meshid="11159370334",textureid="11159285454",C0=angles(1.5707963267948966,0,1.5707963267948966)},

	-- patchma lego piece leg
	{PartName="Right Leg",meshid="12652772399",textureid="12652775021",C0=cf(0,-0.125,0)},

	-- offsale white rig
	-- a ton of offsaled black torso's
	{PartName="Torso",meshid="14768666349"},
	{PartName="Torso",meshid="14241018198"},
	{PartName="Torso",meshid="13421774668"},
	{PartName="Left Leg",meshid="14255522247",C0=angles(1.5707963267948966,0,1.5707963267948966)},
	{PartName="Right Leg",meshid="14255522247",C0=angles(-1.5707963267948966,0,1.5707963267948966)},
	{PartName="Left Arm",meshid="14768684979",C0=angles(0,0,1.5707963267948966)},
	{PartName="Right Arm",meshid="14768684979",C0=angles(0,0,1.5707963267948966)},

	-- og fur body, r15 arms, smiley legs rig
	{PartName="Head",meshid="13953154391"},
	{PartName="Torso",meshid="13778226115"},
	{PartName="Left Leg",meshid="11159370334",textureid="11159284657",C0=angles(1.5707963267948966,0,1.5707963267948966)},
	{PartName="Right Leg",meshid="11263221350",textureid="11263219250",C0=angles(-1.5707963267948966,0,1.5707963267948966)},
	{PartName="Left Arm",meshid="12344207333",C0=angles(2,0,0)},
	{PartName="Right Arm",meshid="12344206657",C0=angles(2,0,0)},

	-- torso for both "white limbs black torso rig" and "black rig"
	{PartName="Torso",meshid="110684113028749"},
	-- white limbs black torso rig
	{PartName="Head",meshid="13058343355",C0=angles(0,3.141592653589793,0)},
	{PartName="Left Leg",meshid="139733645770094",C0=angles(0,0,1.5707963267948966)},
	{PartName="Right Leg",meshid="99608462237958",C0=angles(0,0,1.5707963267948966)},
	{PartName="Left Arm",meshid="90736849096372",C0=angles(0,0,1.5707963267948966)},
	{PartName="Right Arm",meshid="105141400603933",C0=angles(0,0,1.5707963267948966)},
	-- head for black rigs
	{PartName="Head",meshid="13953153289"},
	-- lay offsale black rig
	{PartName="Left Leg",meshid="17387586286",C0=angles(1.5707963267948966,0,1.5707963267948966)},
	{PartName="Right Leg",meshid="17387586286",C0=angles(-1.5707963267948966,0,1.5707963267948966)},
	{PartName="Left Arm",meshid="17374767929",C0=angles(1.5707963267948966,0,1.5707963267948966)},
	{PartName="Right Arm",meshid="17374767929",C0=angles(-1.5707963267948966,0,1.5707963267948966)},
	-- 7ws offsale black rig
	{PartName="Left Leg",meshid="125405780718494",C0=angles(1.5707963267948966,0,1.5707963267948966)},
	{PartName="Right Leg",meshid="125405780718494",C0=angles(-1.5707963267948966,0,1.5707963267948966)},
	{PartName="Left Arm",meshid="125405780718494",C0=angles(1.5707963267948966,0,1.5707963267948966)},
	{PartName="Right Arm",meshid="125405780718494",C0=angles(-1.5707963267948966,0,1.5707963267948966)},

	-- meshless rig
	{PartName="Head",meshid="13953094351"},
	{PartName="Torso",meshid="127552124837034",C0=angles(0,0,1.5707963267948966)},
	{PartName="Left Leg",meshid="121304376791439"},
	{PartName="Right Leg",meshid="121304376791439"},
	{PartName="Left Arm",meshid="117287001096396"},
	{PartName="Right Arm",meshid="117287001096396"},

	-- head for noob rig
	{PartName="Head",meshid="13058309233",C0=angles(0,3.141592653589793,0)},
	-- lay offsale noob rig
	{PartName="Torso",meshid="18640899369"},
	{PartName="Left Leg",meshid="18640901641"},
	{PartName="Right Leg",meshid="18640901641"},
	{PartName="Left Arm",meshid="18640914129"},
	{PartName="Right Arm",meshid="18640914129"},
	-- 7ws offsale noob rig
	{PartName="Torso",meshid="126825022897778"},
	{PartName="Left Leg",textureid="73798034827573",C0=angles(0,0,1.5707963267948966)},
	{PartName="Right Leg",textureid="73798034827573",C0=angles(0,0,1.5707963267948966)},
	{PartName="Left Arm",textureid="135650240593878",C0=angles(0,0,1.5707963267948966)},
	{PartName="Right Arm",textureid="135650240593878",C0=angles(0,0,1.5707963267948966)},

	-- white torso
	{PartName="Torso",meshid="126825022897778"},

	-- lay onsale gray torso white arm black leg rig
	{PartName="Torso",meshid="139792224823925"},
	{PartName="Left Leg",meshid="83395427313429",C0=angles(0,0,1.5707963267948966)},
	{PartName="Right Leg",meshid="83395427313429",C0=angles(0,0,1.5707963267948966)},
	{PartName="Left Arm",meshid="105263225400272",C0=angles(0,0,1.5707963267948966)},
	{PartName="Right Arm",meshid="105263225400272",C0=angles(0,0,1.5707963267948966)},

	-- shownape/geecee auto rig
	{PartName="Head",AccessoryName="Accessory (autorig_Head)"},
	{PartName="Torso",AccessoryName="Accessory (autorig_Torso)"},
	{PartName="Left Leg",AccessoryName="Accessory (autorig_LeftLeg)"},
	{PartName="Right Leg",AccessoryName="Accessory (autorig_RightLeg)"},
	{PartName="Left Arm",AccessoryName="Accessory (autorig_LeftArm)"},
	{PartName="Right Arm",AccessoryName="Accessory (autorig_RightArm)"},

	-- free rig
	{PartName="Left Arm",meshid="4324138105",textureid="4324138210",C0=angles(-1.6144295580947547,1.5707963267948966,0)*cf(-0.125,0.3,0)},
	{PartName="Left Arm",meshid="4154474745",textureid="4154474807",C0=angles(1.5271630954950384,-1.5707963267948966,0)*cf(-0.125,-0.3,0)},
	{PartName="Right Arm",meshid="3030546036",textureid="3650191503",C0=angles(1.5271630954950384,1.5707963267948966,0)*cf(0.125,-0.3,0)},
	{PartName="Right Arm",meshid="3030546036",textureid="3443321249",C0=angles(-1.6144295580947547,-1.5707963267948966,0)*cf(0.125,0.3,0)},
	{PartName="Left Leg",meshid="3030546036",textureid="3360974849",C0=angles(1.5271630954950384,1.5707963267948966,0)*cf(-0.125,-0.35,0)},
	{PartName="Left Leg",meshid="3030546036",textureid="3360978739",C0=angles(-1.6144295580947547,-1.5707963267948966,0)*cf(-0.125,0.3,0)},
	{PartName="Right Leg",meshid="3030546036",textureid="3033898741",C0=angles(1.5271630954950384,-1.5707963267948966,0)*cf(0.125,-0.35,0)},
	{PartName="Right Leg",meshid="3030546036",textureid="3409604993",C0=angles(-1.6144295580947547,1.5707963267948966,0)*cf(0.125,0.3,0)},
	{PartName="Torso",meshid="4819720316",textureid="4819722776",C0=angles(0,0,0.2617993877991494)}
}

local makeplaceholder=function(v)
	if not insGet(v,"Archivable") then
		insSet(v,"Archivable",true)
	end
	v=Clone(v)
	local mesh=FindFirstChildOfClass(v,"SpecialMesh")
	if mesh then
		insSet(mesh,"Parent",nil)
		ClearAllChildren(v)
		ClearAllChildren(mesh)
		insSet(mesh,"Name",rs())
		insSet(mesh,"Parent",v)
	else
		ClearAllChildren(v)
	end
	insSet(v,"Name",rs())
	insSet(v,"Anchored",true)
	insSet(v,"CanCollide",false)
	insSet(v,"Transparency",0.25)
	return v
end
local emptyfunction=function() end
local allowshiftlock=nil
local ctrltp=nil
local placeholders=nil
local clickfling=nil
local flingoffset=nil
local flingvel=nil
local flingrotvel=nil
local flingtargetting=nil
local highlightflingtargets=nil
local discharscripts=nil
local flingchangestate=nil
local respawntp=nil
local disguiscripts=nil
local breakjointsmethod=nil
local simrad=false
local hidedeatheffect=nil

local c=nil
local cons={}
local cframes={}
local hrpcon0=nil
local hrpcon1=nil
local flingtable={}
local plrcleanups={}
local onnewcamera=nil

--settings, the old patchma settings list is gone. these are the values its defaults had (ctrl click tp and click fling are on)
local hlparent=nil --where the fling highlights go, set when the gui is built
local restoreAllowSleep=nil
placeholders=true
highlightflingtargets=true
allowshiftlock=true
ctrltp=false --off: left click is used by the weapons
clickfling=false
flingtargetting=(sethiddenproperty and 3) or (setscriptable and 2) or 0
flingoffset=-v3_010
flingvel=v3(0,16000,0)
flingrotvel=v3(16000,0,16000)
flingchangestate=3
respawntp=3
disguiscripts=true
discharscripts=function(v)
	if IsA(v,"Script") then --mind Enum.RunContext.Client
		insSet(v,"Disabled",true)
	end
end
breakjointsmethod=(replicatesignal and 4) or 1
hidedeatheffect=true
simrad=true

local stopreanimate=function() 
	if c then
		c=nil
		for i,v in next,cframes do
			local p=i.v
			if p then
				Destroy(p)
			end
		end
		tclear(cframes)
		if hrpcon0 then
			Disconnect(hrpcon0)
			Disconnect(hrpcon1)
			hrpcon0=nil
		end
		for i,v in next,flingtable do
			if v then --it could be false
				Destroy(v)
			end
		end
		tclear(flingtable)
		for i,v in next,cons do
			Disconnect(v)
		end
		tclear(cons)
		for i,cleanupfunc in next,plrcleanups do
			cleanupfunc()
		end
		tclear(plrcleanups)
		insSet(uis,"MouseBehavior",enumMD)
		if restoreAllowSleep then
			restoreAllowSleep()
			restoreAllowSleep=nil
		end
		onnewcamera()
		return true
	end
	return false
end
local reanimate=function()
	--[[
		FDless reanimate by MyWorld continued by rqz
		optimize the optimized
	]]
	local novoid=true --prevents parts from going under workspace.FallenPartsDestroyHeight if you control them
	local speedlimit=3000 --makes your parts move slower if the magnitude of their velocity is higher than this
	local retVelTime=0.51 --time that claimed parts have velocity to reclaim in case u lose them
	local walkSpeed=16 --your walkspeed (can be changed at runtime)
	local jumpPower=50 --your jump power (can be changed at runtime)
	local gravity=196.2 --how fast the characters velocity decreases while falling (can be changed at runtime)
	local ctrlclicktp=ctrltp --makes you teleport where u point ur mouse cursor at when click and hold ctrl down

	if stopreanimate() then return end

	local cam=nil
	--theres a way to have ws.currentcamera nil on heartbeat and still have the game run normally
	local refcam=function()
		local newcam=insGet(ws,"CurrentCamera")
		while not newcam do
			Wait(GetPropertyChangedSignal(ws,"CurrentCamera"))
			newcam=insGet(ws,"CurrentCamera")
		end
		cam=newcam
	end
	refcam()
	local camcf=insGet(cam,"CFrame")
	local enumCamS=e.CameraType.Scriptable
	local camt=insGet(cam,"CameraType")
	local camcon0=nil
	local camcon1=nil
	local camcon2=nil
	onnewcamera=function()
		refcam()
		if camcon0 then 
			Disconnect(camcon0)
			Disconnect(camcon1)
			camcon0=nil
		end
		if not c then 
			if insGet(cam,"CameraType")==enumCamS then
				insSet(cam,"CameraType",camt)
			end
			return Disconnect(camcon2) 
		end
		camcon0=Connect(GetPropertyChangedSignal(cam,"CFrame"),function()
			if insGet(cam,"CFrame")~=camcf then
				insSet(cam,"CFrame",camcf)
			end
		end)
		camcon1=Connect(GetPropertyChangedSignal(cam,"CameraType"),function()
			if insGet(cam,"CameraType")~=enumCamS then
				insSet(cam,"CameraType",enumCamS)
			end
		end)
		if insGet(cam,"CameraType")~=enumCamS then
			insSet(cam,"CameraType",enumCamS)
		end
		if insGet(cam,"CFrame")~=camcf then
			insSet(cam,"CFrame",camcf)
		end
	end
	camcon2=Connect(GetPropertyChangedSignal(ws,"CurrentCamera"),onnewcamera)

	local wsGravity=insGet(ws,"Gravity")
	tinsert(cons,Connect(GetPropertyChangedSignal(ws,"Gravity"),function()
		wsGravity=insGet(ws,"Gravity")
	end))

	local fpdh=insGet(ws,"FallenPartsDestroyHeight")
	novoid=novoid and (fpdh+1)

	local cfr=nil
	c=insGet(lp,"Character")
	if c and IsDescendantOf(c,ws) then
		cfr=QueryDescendants(c,">BasePart#HumanoidRootPart")[1] or QueryDescendants(c,">BasePart#Torso")[1] or QueryDescendants(c,">BasePart#UpperTorso")[1] or FindFirstChildWhichIsA(c,"BasePart")
		if cfr then
			cfr=insGet(cfr,"CFrame")
		else
			cfr=cfMul(insGet(cam,"Focus"),cf(0,-1.5,0))
		end
	else
		c=true
		cfr=cfMul(insGet(cam,"Focus"),cf(0,-1.5,0))
	end

	onnewcamera()

	local Yvel=0
	local pos=cfGet(cfr,"Position")
	cfr=cfl(pos,pos+cfGet(cfr,"LookVector")*v3_101)
	local primarypart=nil
	local shiftlock=false
	local firstperson=false
	local xzvel=v3_0
	local v3_0150=v3_010*1.5
	local camcfLV=cfGet(camcf,"LookVector")
	local camrot=cfl(v3_0,camcfLV)
	local camrotX,camrotY=cfGet(camrot,"ToEulerAnglesYXZ")(camrot)
	local camcfRV=cfGet(camrot,"RightVector")
	local cammag=-vmagnitude((cfGet(camcf,"Position")-(pos+v3_0150)))
	
	local R6parts={ 
		head={Name="Head"},
		torso={Name="Torso"},
		root={Name="HumanoidRootPart"},
		leftArm={Name="Left Arm"},
		rightArm={Name="Right Arm"},
		leftLeg={Name="Left Leg"},
		rightLeg={Name="Right Leg"}
	}
	local rootpart=R6parts.root
	for i,v in next,R6parts do
		cframes[v]=cfr
	end
	local joints={
		{
			Name="Neck",
			Part0=R6parts.torso,Part1=R6parts.head,
			C0=cf(0,1,0,-1,0,0,0,0,1,0,1,-0),
			C1=cf(0,-0.5,0,-1,0,0,0,0,1,0,1,-0)
		},
		{
			Name="RootJoint",
			Part0=rootpart,Part1=R6parts.torso,
			C0=cf(0,0,0,-1,0,0,0,0,1,0,1,-0),
			C1=cf(0,0,0,-1,0,0,0,0,1,0,1,-0)
		},
		{
			Name="Right Shoulder",
			Part0=R6parts.torso,Part1=R6parts.rightArm,
			C0=cf(1,0.5,0,0,0,1,0,1,-0,-1,0,0),
			C1=cf(-0.5,0.5,0,0,0,1,0,1,-0,-1,0,0)
		},
		{
			Name="Left Shoulder",
			Part0=R6parts.torso,Part1=R6parts.leftArm,
			C0=cf(-1,0.5,0,0,0,-1,0,1,0,1,0,0),
			C1=cf(0.5,0.5,0,0,0,-1,0,1,0,1,0,0)
		},
		{
			Name="Right Hip",
			Part0=R6parts.torso,Part1=R6parts.rightLeg,
			C0=cf(1,-1,0,0,0,1,0,1,-0,-1,0,0),
			C1=cf(0.5,1,0,0,0,1,0,1,-0,-1,0,0)
		},
		{
			Name="Left Hip",
			Part0=R6parts.torso,Part1=R6parts.leftLeg,
			C0=cf(-1,-1,0,0,0,-1,0,1,0,1,0,0),
			C1=cf(-0.5,1,0,0,0,-1,0,1,0,1,0,0)
		}
	}

	local refreshedjoints={}
	local refreshjointsI=nil
	refreshjointsI=function(part)
		refreshedjoints[part]=true
		for i,v in next,joints do
			local part0=v.Part0
			local part1=v.Part1
			if part1 and (part0==part) then
				cframes[part1]=cfMul(cframes[part],cfMul(v.C0,Inverse(v.C1)))
				if not refreshedjoints[part1] then
					refreshjointsI(part1)
				end
			elseif part0 and (part1==part) then
				cframes[part0]=cfMul(cframes[part],cfMul(v.C1,Inverse(v.C0)))
				if not refreshedjoints[part0] then
					refreshjointsI(part0)
				end
			end
		end
	end
	refreshjointsI(rootpart)
	tclear(refreshedjoints)

	local attachments={
		RightShoulderAttachment={R6parts.rightArm,cf(0,1,0,1,0,0,0,1,0,0,0,1)},
		RightGripAttachment={R6parts.rightArm,cf(0,-1,0,1,0,0,0,1,0,0,0,1)},
		LeftFootAttachment={R6parts.leftLeg,cf(0,-1,0,1,0,0,0,1,0,0,0,1)},
		LeftShoulderAttachment={R6parts.leftArm,cf(0,1,0,1,0,0,0,1,0,0,0,1)},
		LeftGripAttachment={R6parts.leftArm,cf(0,-1,0,1,0,0,0,1,0,0,0,1)},
		RootAttachment={rootpart,cf(0,0,0,1,0,0,0,1,0,0,0,1)},
		RightFootAttachment={R6parts.rightLeg,cf(0,-1,0,1,0,0,0,1,0,0,0,1)},
		NeckAttachment={R6parts.torso,cf(0,1,0,1,0,0,0,1,0,0,0,1)},
		BodyFrontAttachment={R6parts.torso,cf(0,0,-0.5,1,0,0,0,1,0,0,0,1)},
		BodyBackAttachment={R6parts.torso,cf(0,0,0.5,1,0,0,0,1,0,0,0,1)},
		LeftCollarAttachment={R6parts.torso,cf(-1,1,0,1,0,0,0,1,0,0,0,1)},
		RightCollarAttachment={R6parts.torso,cf(1,1,0,1,0,0,0,1,0,0,0,1)},
		WaistFrontAttachment={R6parts.torso,cf(0,-1,-0.5,1,0,0,0,1,0,0,0,1)},
		WaistCenterAttachment={R6parts.torso,cf(0,-1,0,1,0,0,0,1,0,0,0,1)},
		WaistBackAttachment={R6parts.torso,cf(0,-1,0.5,1,0,0,0,1,0,0,0,1)},
		HairAttachment={R6parts.head,cf(0,0.6,0,1,0,0,0,1,0,0,0,1)},
		HatAttachment={R6parts.head,cf(0,0.6,0,1,0,0,0,1,0,0,0,1)},
		FaceFrontAttachment={R6parts.head,cf(0,0,-0.6,1,0,0,0,1,0,0,0,1)},
		FaceCenterAttachment={R6parts.head,cf(0,0,0,1,0,0,0,1,0,0,0,1)}
	}

	local getPart=function(name,blacklist)
		if blacklist then
			for i,v in next,cframes do
				if (i.Name==name) and not tfind(blacklist,i) then
					return i
				end
			end
		else
			for i,v in next,cframes do
				if i.Name==name then
					return i
				end
			end
		end
		return nil
	end

	local getJoint=function(name)
		for i,v in next,joints do
			if v.Name==name then
				return v
			end
		end
		return {C0=cf_0,C1=cf_0}
	end

	local getPartFromMesh=function(m,t,blacklist)
		if blacklist then
			for v,_ in next,cframes do
				if v.m and (not tfind(blacklist,v)) and sfind(v.m,m) and sfind(v.t,t) then
					return v
				end
			end
		else
			for v,_ in next,cframes do
				if v.m and sfind(v.m,m) and sfind(v.t,t) then
					return v
				end
			end
		end
		local p={m=m,t=t}
		cframes[p]=cfr
		local j={C0=cf_0,C1=cf_0,Part0=p}
		p.j=j
		return p
	end
	local getPartJoint=function(p)
		if cframes[p] then
			local j=p.j
			if j then
				return j
			end
			for i,v in next,joints do
				if v.Part0==p then
					return v
				end
			end
			for i,v in next,joints do
				if v.Part1==p then
					return v
				end
			end
		end
		return nil
	end

	local getAccWeldFromMesh=function(m,t)
		return getPartJoint(getPartFromMesh(m,t))
	end

	local raycastparams=rp()
	raycastparams.FilterType=e.RaycastFilterType.Exclude
	raycastparams.RespectCanCollide=true
	local rayfilter={}
	local characters={}
	local refreshrayfilter=function()
		tclear(rayfilter)
		for i,v in next,characters do
			tinsert(rayfilter,v)
		end
		raycastparams.FilterDescendantsInstances=rayfilter
	end
	local rootparts={}
	for i,v in next,aligns do
		v.p=getPart(v.PartName)
		if not v.meshid then
			v.meshid=""
		end 
		if not v.textureid then
			v.textureid=""
		end 
	end
	local makePartCons=function(p,t)
		if (t.p==p) and insGet(p,"Anchored") then
			t.p=nil
		end
		local con0=Connect(GetPropertyChangedSignal(p,"Anchored"),function()
			if insGet(p,"Anchored") then
				if t.p==p then
					t.c=nil
					t.p=nil
				end
			elseif not t.p then
				t.p=p
			end
		end)
		local con1=nil
		con1=Connect(insGet(p,"AncestryChanged"),function()
			if not IsDescendantOf(p,ws) then
				Disconnect(con0)
				Disconnect(con1)
				if t.p==p then
					t.p=nil
				end
			end
		end)
	end
	local ondes=function(v)
		if IsA(v,"Attachment") then
			local v1=attachments[insGet(v,"Name")]
			if v1 then
				local p=insGet(v,"Parent")
				if insGet(p,"Parent")~=c then
					local meshid=nil
					local textureid=nil
					if IsA(p,"MeshPart") then
						meshid=insGet(p,"MeshId")
						textureid=insGet(p,"TextureID")
					elseif IsA(p,"BasePart") then
						local sm=FindFirstChildOfClass(p,"SpecialMesh")
						if sm then
							meshid=insGet(sm,"MeshId")
							textureid=insGet(sm,"TextureId")
						else
							return
						end
					else
						return
					end
					for i,_ in next,cframes do
						if (meshid==i.m) and (textureid==i.t) then
							local p1=i.p
							if p1 then
								if p1==p then
									return
								end
							else
								i.p=p
								makePartCons(p,i)
								return
							end
						else
							local j=i.j
							if j and sfind(meshid,i.m) and sfind(textureid,i.t) then
								i.m=meshid
								i.t=textureid
								i.l=insGet(p,"Position")
								i.p=p
								makePartCons(p,i)
								i.j=nil
								i.Name=insGet(p,"Name")
								j.C0=insGet(v,"CFrame")
								j.C1=v1[2]
								j.Part1=v1[1]
								tinsert(joints,j)
								return
							end
						end
					end
					local n=insGet(insGet(p,"Parent"),"Name")
					for i,l in next,aligns do
						if l.p and sfind(meshid,l.meshid) and sfind(textureid,l.textureid) and ((not l.AccessoryName) or (l.AccessoryName==n)) then
							local t={Name=insGet(p,"Name"),l=insGet(p,"Position"),m=meshid,t=textureid,p=p}
							makePartCons(p,t)
							if placeholders then
								t.v=makeplaceholder(p)
								t.b=false
							end
							cframes[t]=insGet(p,"CFrame")
							tinsert(joints,{Part0=t,Part1=l.p,C0=l.C0 or cf_0,C1=cf_0})
							l.p=nil
							return
						end
					end
					local t={Name=insGet(p,"Name"),l=insGet(p,"Position"),m=meshid,t=textureid,p=p}
					makePartCons(p,t)
					if placeholders then
						t.v=makeplaceholder(p)
						t.b=false
					end
					cframes[t]=insGet(p,"CFrame")
					tinsert(joints,{Part0=t,Part1=v1[1],C0=insGet(v,"CFrame"),C1=v1[2]})
				end
			end
		end
	end
	
	local simradv=1000
	local enumH=e.CoreGuiType.Health
	local onplayer=function(v)
		simradv=simradv+1000
		local lastc=nil
		local con0=nil
		local con1=nil
		local oncharacter=function()
			local newc=insGet(v,"Character")
			if newc and (newc~=lastc) then
				lastc=newc

				if con0 then
					Disconnect(con0)
					Disconnect(con1)
					con0=nil
				end

				characters[v]=newc
				refreshrayfilter()

				local hrp=QueryDescendants(newc,">BasePart#HumanoidRootPart")[1]
				if hrp then
					rootparts[v]=hrp
				else
					local refresh=true					
					local threshold=false
					tdelay(0.5,function()
						refresh=true
						threshold=true
					end)
					con0=Connect(preanimation,function()
						if refresh then
							if threshold then
								hrp=QueryDescendants(newc,">BasePart#HumanoidRootPart")[1] or QueryDescendants(newc,">BasePart#Torso")[1] or QueryDescendants(newc,">BasePart#UpperTorso")[1] or FindFirstChildWhichIsA(newc,"BasePart")
							else
								hrp=QueryDescendants(newc,">BasePart#HumanoidRootPart")[1]
							end
							if hrp then
								rootparts[v]=hrp
								Disconnect(con0)
								Disconnect(con1)
								con0=nil
								return
							end
							refresh=false
						end
					end)
					con1=Connect(insGet(newc,"ChildAdded"),function()
						refresh=true
					end)
				end
			end
		end

		local charcon=Connect(GetPropertyChangedSignal(v,"Character"),oncharacter)
		oncharacter()
		plrcleanups[v]=function()
			simradv=simradv-1000
			characters[v]=nil
			rootparts[v]=nil
			if con0 then
				Disconnect(con0)
				Disconnect(con1)
				con0=nil
			end
			Disconnect(charcon)
		end
	end
	tinsert(cons,Connect(insGet(plrs,"PlayerRemoving"),function(v)
		local cleanup=plrcleanups[v]
		if cleanup then
			cleanup()
			plrcleanups[v]=nil
		end
	end))
	for i,v in next,GetPlayers(plrs) do simradv=simradv+1000 if v~=lp then tspawn(onplayer,v) end end
	tinsert(cons,Connect(insGet(plrs,"PlayerAdded"),onplayer))
	if disguiscripts then
		tinsert(cons,Connect(insGet(pg,"DescendantAdded"),function(v)
			if IsA(v,"Script") then --mind Enum.RunContext.Client
				insSet(v,"Disabled",true) 
			end
		end))
	end

	local lastc=nil
	local oncharacter=function()
		local newc=insGet(lp,"Character")
		if newc and (newc~=lastc) then
			lastc=newc

			if hrpcon0 then
				Disconnect(hrpcon0)
				Disconnect(hrpcon1)
				hrpcon0=nil
			end

			if discharscripts then
				Connect(insGet(newc,"DescendantAdded"),discharscripts)
				for i,v in next,QueryDescendants(newc,"Script") do
					insSet(v,"Disabled",true)
				end
			end

			characters[lp]=newc
			refreshrayfilter()
			
			local hrp=QueryDescendants(newc,">BasePart#HumanoidRootPart")[1]
			if not hrp then
				local refresh=true
				local threshold=false
				tdelay(0.5,function()
					refresh=true
					threshold=true
				end)
				local thread=crunning()
				hrpcon1=Connect(preanimation,function()
					if refresh then
						if threshold then
							hrp=QueryDescendants(newc,">BasePart#HumanoidRootPart")[1] or QueryDescendants(newc,">BasePart#Torso")[1] or QueryDescendants(newc,">BasePart#UpperTorso")[1] or FindFirstChildWhichIsA(newc,"BasePart")
						else
							hrp=QueryDescendants(newc,">BasePart#HumanoidRootPart")[1]
						end
						if hrp then
							Disconnect(hrpcon0)
							Disconnect(hrpcon1)
							hrpcon0=nil
							cresume(thread)
							return
						end
						refresh=false
					end
				end)
				hrpcon0=Connect(insGet(newc,"ChildAdded"),function()
					refresh=true
				end)
				cyield()
				Wait(stepped)
			end
			
			c=newc
			if next(flingtable) then
				local hum=FindFirstChildOfClass(c,"Humanoid")
				if hum then
					if flingchangestate==3 then
						ChangeState(hum,enumphysics)
						SetStateEnabled(hum,enumseated,false)
					elseif flingchangestate==1 then
						ChangeState(hum,enumphysics)
					else
						if flingchangestate==2 then
							SetStateEnabled(hum,enumseated,false)
						end
						if flingtargetting~=0 then
							ChangeState(hum,enumragdoll)
							SetStateEnabled(hum,enumrunning,false)
						end
					end
				end
				twait(0.25)
				for i1,v in next,tclone(flingtable) do
					if not c then
						return
					end
					if flingtargetting==3 then
						sethiddenproperty(hrp,"PhysicsRepRootPart",i1)
					elseif flingtargetting==2 then
						setscriptable(hrp,"PhysicsRepRootPart",true)
						insSet(hrp,"PhysicsRepRootPart",i1)
						setscriptable(hrp,"PhysicsRepRootPart",false)
					elseif flingtargetting==1 then
						local hrpcpp=insGet(hrp,"CustomPhysicalProperties")
						local tparent=insGet(i1,"Parent")
						local tcfr=insGet(i1,"CFrame")

						local model=i("Model")
						local hum=i("Humanoid",model)
						for i,v in next,humstatesbl do
							SetStateEnabled(hum,v,false)
						end

						local restorejoints={}
						for i,v in next,GetJoints(hrp) do
							restorejoints[v]=insGet(v,"Parent")
							insSet(v,"Parent",nil)
						end
						for i,v in next,GetJoints(i1) do
							restorejoints[v]=insGet(v,"Parent")
							insSet(v,"Parent",nil)
						end

						local tcfr1=cf(cfGet(tcfr,"Position")+v3_010*mrandom(10000,20000))
						insSet(i1,"Parent",ws)
						insSet(i1,"CFrame",tcfr1)
						insSet(hrp,"Parent",model)
						insSet(hrp,"CFrame",tcfr1+(insGet(hrp,"Size")+insGet(i1,"Size"))*sm)
						insSet(i1,"CustomPhysicalProperties",dense)
						insSet(hrp,"CustomPhysicalProperties",light)
						insSet(model,"Parent",ws)
						ChangeState(hum,enumrunning)
						if not insGet(i1,"CanCollide") then
							insSet(i1,"CanCollide",true)
						end
						Wait(stepped)
						for i,v in next,restorejoints do
							insSet(i,"Parent",v)
						end
						insSet(i1,"CFrame",tcfr)
						insSet(i1,"Parent",tparent)
						insSet(hrp,"CustomPhysicalProperties",hrpcpp)
						insSet(hrp,"Parent",newc)
						Destroy(model)
					end
					local startpos=insGet(i1,"Position")
					local stoptime=sine+(((flingtargetting~=0) and 0.1) or 3)
					while true do
						if insGet(i1,"Anchored") or not IsDescendantOf(i1,ws) then
							break
						end
						if vmagnitude(startpos-insGet(i1,"Position"))>200 then
							break
						end
						if flingtargetting~=0 then
							local tcf=cfAdd(insGet(i1,"CFrame"),flingoffset)
							if novoid and (cfGet(tcf,"Y")<novoid) then
								tcf=cfAdd(tcf,v3_010*(novoid-cfGet(tcf,"Y")))
							end
							insSet(hrp,"CFrame",tcf)
							insSet(hrp,"AssemblyLinearVelocity",flingvel)
						else
							local tcf=cfAdd(insGet(i1,"CFrame"),insGet(i1,"AssemblyLinearVelocity")*(sin(sine*15)+1)+flingoffset)
							if novoid and (cfGet(tcf,"Y")<novoid) then
								tcf=cfAdd(tcf,v3_010*(novoid-cfGet(tcf,"Y")))
							end
							insSet(hrp,"CFrame",tcf)
							insSet(hrp,"AssemblyLinearVelocity",insGet(i1,"AssemblyLinearVelocity")*v3_101*75)
						end
						insSet(hrp,"AssemblyAngularVelocity",flingrotvel)
						if sine>stoptime then
							break
						end
						twait()
					end
					if v then
						Destroy(v)
					end
					flingtable[i1]=nil
				end
				if flingtargetting==3 then
					sethiddenproperty(hrp,"PhysicsRepRootPart",nil)
				elseif flingtargetting==2 then
					setscriptable(hrp,"PhysicsRepRootPart",true)
					insSet(hrp,"PhysicsRepRootPart",nil)
					setscriptable(hrp,"PhysicsRepRootPart",false)
				elseif flingtargetting==1 then
					SetStateEnabled(hum,enumrunning,true)
					ChangeState(hum,enumrunning)
				end
				if respawntp==0 then
					insSet(hrp,"AssemblyLinearVelocity",v3_0)
					insSet(hrp,"AssemblyAngularVelocity",v3_0)
					insSet(hrp,"CFrame",cfr)
					twait(0.3)
				end
			end
			if respawntp==0 then
				twait()
			elseif respawntp==1 then
				local startpos=pos+v3(mrandom(-32,32),0,mrandom(-32,32))
				local dir=nil
				local poscheck=true
				while poscheck do
					poscheck=false
					for i,v in next,rootparts do
						local diff=(startpos-insGet(v,"Position"))*v3_101
						if vmagnitude(diff)<10 then
							poscheck=true
							dir=dir or (vnormalize(diff)*3)
							startpos=startpos+dir
						end
					end
					local diff=(startpos-pos)*v3_101
					if vmagnitude(diff)<10 then
						poscheck=true
						dir=dir or (vnormalize(diff)*3)
						startpos=startpos+dir
					end
				end
				startpos=cfAdd(cfGet(cfr,"Rotation"),startpos)
				insSet(hrp,"CFrame",startpos)
				insSet(hrp,"AssemblyLinearVelocity",v3_0)
				insSet(hrp,"AssemblyAngularVelocity",v3_0)
				twait(0.3)
			elseif respawntp==2 then
				insSet(hrp,"CFrame",cfAdd(cfr,cfGet(cfr,"RightVector")*3.5-cfGet(cfr,"LookVector")*3.5))
				insSet(hrp,"AssemblyLinearVelocity",v3_0)
				insSet(hrp,"AssemblyAngularVelocity",v3_0)
				twait(0.3)
			elseif respawntp==3 then
				local t=osclock()+0.3
				local startcf=cfAdd(cfMul(cfGet(cfr,"Rotation"),angles(1.5707963267948966,0,0)),pos*v3_101+v3_010*min(fpdh+30,v3Get(pos,"Y")-5))
				while twait() do
					insSet(hrp,"CFrame",startcf)
					insSet(hrp,"AssemblyLinearVelocity",v3_0)
					insSet(hrp,"AssemblyAngularVelocity",v3_0)
					if osclock()>t then
						break
					end
				end
			end
			if newc~=c then
				return
			end
			primarypart=insGet(newc,"PrimaryPart") or hrp
			if hidedeatheffect and GetCoreGuiEnabled(sg,enumH) then
				SetCoreGuiEnabled(sg,enumH,false)
			end
			--accessories whose attachments the rig doesnt know would be left behind as loose parts once the joints break (thats the hats falling off),
			--so remember where they are now and keep them on the root part afterwards
			local looseacc={}
			local hrpcf=hrp and insGet(hrp,"CFrame")
			for _,acc in next,GetChildren(newc) do
				if hrpcf and IsA(acc,"Accoutrement") then
					local handle=acc:FindFirstChild("Handle")
					if handle and IsA(handle,"BasePart") then
						local known=false
						for _,a in next,GetChildren(handle) do
							if IsA(a,"Attachment") and attachments[insGet(a,"Name")] then
								known=true
								break
							end
						end
						if not known then
							tinsert(looseacc,{handle,cfMul(Inverse(hrpcf),insGet(handle,"CFrame"))})
						end
					end
				end
			end
			if breakjointsmethod==4 then
				local h=FindFirstChildOfClass(newc,"Humanoid")
				if h then
					replicatesignal(insGet(h,"ServerBreakJoints"))
				else
					BreakJoints(newc)
				end
			elseif breakjointsmethod==1 then
				BreakJoints(newc)
				local h=FindFirstChildOfClass(newc,"Humanoid")
				if h then
					insSet(h,"Health",0)
				end
			elseif breakjointsmethod==2 then
				local h=FindFirstChildOfClass(newc,"Humanoid")
				if h then
					insSet(h,"Health",0)
				else
					BreakJoints(newc)
				end
			else
				BreakJoints(newc)
			end
			cons.ondes=Connect(insGet(newc,"DescendantAdded"),ondes)
			for i,v in next,QueryDescendants(newc,"Attachment") do
				ondes(v)
			end
			for _,l in next,looseacc do
				local p=l[1]
				local meshid,textureid="",""
				if IsA(p,"MeshPart") then
					meshid=insGet(p,"MeshId")
					textureid=insGet(p,"TextureID")
				else
					local sm=FindFirstChildOfClass(p,"SpecialMesh")
					if sm then
						meshid=insGet(sm,"MeshId")
						textureid=insGet(sm,"TextureId")
					end
				end
				local t={Name=insGet(p,"Name"),l=insGet(p,"Position"),m=meshid,t=textureid,p=p}
				makePartCons(p,t)
				if placeholders then
					t.v=makeplaceholder(p)
					t.b=false
				end
				cframes[t]=insGet(p,"CFrame")
				tinsert(joints,{Part0=t,Part1=rootpart,C0=cf_0,C1=l[2]})
			end
		end
	end
	tinsert(cons,Connect(GetPropertyChangedSignal(lp,"Character"),oncharacter))
	oncharacter()

	--parts only stay yours while the server thinks they are inside your simulation radius, so make it as big as it goes
	--(the old version only tried a plain assignment, which fails on most executors and then silently did nothing)
	local setsimrad=emptyfunction
	if simrad then
		local simsetters={
			function(n)
				insSet(lp,"SimulationRadius",n)
				insSet(lp,"MaximumSimulationRadius",n)
			end,
			sethiddenproperty and function(n)
				sethiddenproperty(lp,"SimulationRadius",n)
				sethiddenproperty(lp,"MaximumSimulationRadius",n)
			end,
			setscriptable and function(n)
				setscriptable(lp,"SimulationRadius",true)
				setscriptable(lp,"MaximumSimulationRadius",true)
				insSet(lp,"SimulationRadius",n)
				insSet(lp,"MaximumSimulationRadius",n)
			end
		}
		setsimrad=function()
			for k=1,3 do
				local f=simsetters[k]
				if f and pcall(f,simradv) then
					setsimrad=function()
						f(simradv)
					end
					return
				end
			end
			setsimrad=emptyfunction
		end
	end
	pcall(function()
		local physics=settings().Physics
		local oldAllowSleep=physics.AllowSleep
		physics.AllowSleep=false --sleeping parts stop being simulated and then dont follow you anymore
		restoreAllowSleep=function()
			pcall(function()
				settings().Physics.AllowSleep=oldAllowSleep
			end)
		end
	end)

	local mradN05=-0.008726646259971648
	local pi2=math.pi/2-0.0001
	local npi2=-pi2
	local KeyCode=e.KeyCode
	local enumYXZ=e.RotationOrder.YXZ
	local enumMB2=e.UserInputType.MouseButton2
	local enumMLCP=e.MouseBehavior.LockCurrentPosition
	local enumMLC=(insGet(uis,"TouchEnabled") and enumMLCP) or e.MouseBehavior.LockCenter 
	local enumMW=e.UserInputType.MouseWheel
	local enumMM=e.UserInputType.MouseMovement

	local mouseBehavior=insGet(uis,"MouseBehavior")
	tinsert(cons,Connect(GetPropertyChangedSignal(uis,"MouseBehavior"),function()
		if insGet(uis,"MouseBehavior")~=mouseBehavior then
			insSet(uis,"MouseBehavior",mouseBehavior)
		end
	end))

	local mode="default"
	local defaultmode={}
	local modes={default=defaultmode}
	--things the script on top of the engine can hook into: frame (called every frame before the joints get refreshed), noFling, lastroot
	local hooks={}

	local lerpsIdle=emptyfunction
	local lerpsWalk=emptyfunction
	local lerpsJump=emptyfunction
	local lerpsFall=emptyfunction

	local addmode=function(key,mode)
		if (type(key)~="string") or (type(mode)~="table") then
			return
		end
		for i,v in next,mode do
			if type(v)~="function" then
				mode[i]=nil
			end
		end
		if key=="default" then
			defaultmode=mode
			modes.default=mode
			lerpsIdle=mode.idle or emptyfunction
			lerpsWalk=mode.walk or emptyfunction
			lerpsJump=mode.jump or emptyfunction
			lerpsFall=mode.fall or emptyfunction
			if mode.modeEntered then
				mode.modeEntered()
			end
		elseif #key==1 then
			key=KeyCode[supper(ssub(key,1,1))]
			modes[key]=mode
		end
	end

	local keyW=KeyCode.W
	local Wpressed=IsKeyDown(uis,keyW)
	local keyA=KeyCode.A
	local Apressed=IsKeyDown(uis,keyA)
	local keyS=KeyCode.S
	local Spressed=IsKeyDown(uis,keyS)
	local keyD=KeyCode.D
	local Dpressed=IsKeyDown(uis,keyD)
	local keySpace=KeyCode.Space
	local jumpingInput=IsKeyDown(uis,keySpace)

	local FWmovement=0
	local RTmovement=0
	local isWalking=false
	local refreshKeyboardMovement=function()
		if Wpressed then if Spressed then if Dpressed then if Apressed then isWalking=false else FWmovement=0 RTmovement=1 isWalking=true end else if Apressed then FWmovement=0 RTmovement=-1 isWalking=true else isWalking=false end end else FWmovement=1 if Dpressed then if Apressed then RTmovement=0 else RTmovement=1 end else if Apressed then RTmovement=-1 else RTmovement=0 end end isWalking=true end else if Spressed then FWmovement=-1 if Dpressed then if Apressed then RTmovement=0 else RTmovement=1 end else if Apressed then RTmovement=-1 else RTmovement=0 end end isWalking=true else if Dpressed then if Apressed then isWalking=false else FWmovement=0 RTmovement=1 isWalking=true end else if Apressed then FWmovement=0 RTmovement=-1 isWalking=true else isWalking=false end end end end
	end
	refreshKeyboardMovement()

	local keyShift=KeyCode.LeftShift
	tinsert(cons,Connect(insGet(uis,"InputBegan"),function(a)
		if insGet(gs,"MenuIsOpen") or GetFocusedTextBox(uis) then
			return
		end
		a=insGet(a,"KeyCode")
		if a==keyW then
			Wpressed=true
			refreshKeyboardMovement()
		elseif a==keyA then
			Apressed=true
			refreshKeyboardMovement()
		elseif a==keyS then
			Spressed=true
			refreshKeyboardMovement()
		elseif a==keyD then
			Dpressed=true
			refreshKeyboardMovement()
		elseif a==keySpace then
			jumpingInput=true
		elseif a==keyShift then
			shiftlock=allowshiftlock and not shiftlock
		elseif modes[a] then
			local modeLeft=modes[mode].modeLeft
			if modeLeft then
				modeLeft()
			end
			if mode==a then
				mode="default"
			else
				mode=a
			end
			local modet=modes[mode]
			lerpsIdle=modet.idle or defaultmode.idle or emptyfunction
			lerpsWalk=modet.walk or defaultmode.walk or emptyfunction
			lerpsJump=modet.jump or defaultmode.jump or emptyfunction
			lerpsFall=modet.fall or defaultmode.fall or emptyfunction
			if modes[mode].modeEntered then
				modes[mode].modeEntered()
			end
		end
	end))
	tinsert(cons,Connect(insGet(uis,"InputEnded"),function(a)
		a=insGet(a,"KeyCode")
		if a==keyW then
			Wpressed=false
			refreshKeyboardMovement()
		elseif a==keyA then
			Apressed=false
			refreshKeyboardMovement()
		elseif a==keyS then
			Spressed=false
			refreshKeyboardMovement()
		elseif a==keyD then
			Dpressed=false
			refreshKeyboardMovement()
		elseif a==keySpace then
			jumpingInput=false
		end
	end))

	local thumbstickEndX=0
	local thumbstickStartY=0

	local thumbstickSizeMultiplier=0

	local jumpStartX=0
	local jumpStartY=0
	local jumpEndX=0
	local jumpEndY=0

	local thumbstickInputObject=nil
	local jumpInputObject=nil
	local cameraRotateInputObject=nil
	local cameraZoomInputObject=nil

	local thumbstickTouchStart=v3_0
	local cameraZoomInputMagnitude=0

	tinsert(cons,Connect(insGet(uis,"TouchStarted"),function(inputObject)
		if insGet(gs,"MenuIsOpen") or GetFocusedTextBox(uis) then
			return
		end

		local touchPos=insGet(inputObject,"Position")
		local touchX=v3Get(touchPos,"X")
		local touchY=v3Get(touchPos,"Y")

		if (not thumbstickInputObject) and touchX<thumbstickEndX and touchY>thumbstickStartY then
			thumbstickInputObject=inputObject
			thumbstickTouchStart=insGet(inputObject,"Position")
			isWalking=false
		elseif (not jumpInputObject) and touchY>jumpStartY and touchX>jumpStartX and touchX<jumpEndX and touchY<jumpEndY then
			jumpInputObject=inputObject
			jumpingInput=true
		elseif not cameraRotateInputObject then
			cameraRotateInputObject=inputObject
		else
			cameraZoomInputObject=inputObject
			cameraZoomInputMagnitude=vmagnitude(insGet(cameraRotateInputObject,"Position")-insGet(cameraZoomInputObject,"Position"))
		end
	end))
	tinsert(cons,Connect(insGet(uis,"TouchMoved"),function(inputObject)
		local touchPos=insGet(inputObject,"Position")
		local touchX=v3Get(touchPos,"X")
		local touchY=v3Get(touchPos,"Y")
		if inputObject==thumbstickInputObject then
			local direction=insGet(inputObject,"Position")-thumbstickTouchStart
			local directionMag=vmagnitude(direction)/thumbstickSizeMultiplier
			if directionMag>0.05 then
				isWalking=true
				direction=vnormalize(direction)*min(1,(directionMag-0.05)/0.95) 
				FWmovement=-v3Get(direction,"Y")
				RTmovement=v3Get(direction,"X")
			else
				isWalking=false
			end
		elseif inputObject==jumpInputObject then
			jumpingInput=touchY>jumpStartY and touchX>jumpStartX and touchX<jumpEndX and touchY<jumpEndY
		else
			if cameraZoomInputObject then
				local newMagnitude=vmagnitude(insGet(cameraRotateInputObject,"Position")-insGet(cameraZoomInputObject,"Position"))
				cammag=cammag+(newMagnitude-cameraZoomInputMagnitude)*0.04*(0.75-cammag/4)
				cameraZoomInputMagnitude=newMagnitude
				if cammag<0 then
					firstperson=false
				else
					cammag=0
					firstperson=true
				end
			elseif inputObject==cameraRotateInputObject then
				local rotation=GetMouseDelta(uis)
				camrotX=clamp(v2Get(rotation,"Y")*mradN05+camrotX,npi2,pi2)
				camrotY=v2Get(rotation,"X")*mradN05+camrotY
				camrot=angles(camrotX,camrotY,0,enumYXZ)
				camcfLV=cfGet(camrot,"LookVector")
				camcfRV=cfGet(camrot,"RightVector")
			end
		end
	end))
	tinsert(cons,Connect(insGet(uis,"TouchEnded"),function(inputObject)
		if inputObject==thumbstickInputObject then
			thumbstickInputObject=nil
			isWalking=false
		elseif inputObject==jumpInputObject then
			jumpInputObject=nil
			jumpingInput=false
		elseif inputObject==cameraRotateInputObject then
			cameraRotateInputObject=nil
			cameraZoomInputObject=nil
		elseif inputObject==cameraZoomInputObject then
			cameraZoomInputObject=nil
		end
	end))

	local refreshTouchRegions=function()
		local sX=insGet(mouse,"ViewSizeX")
		local sY=insGet(mouse,"ViewSizeY")
		local isSmallScreen=min(sX,sY)<=500

		sY=sY+insGet(gs,"TopbarInset").Height

		thumbstickEndX=sX*0.4
		thumbstickStartY=(sY+0)*0.333

		if isSmallScreen then
			thumbstickSizeMultiplier=35
			jumpStartX=sX-95
			jumpStartY=sY-90
			jumpEndX=jumpStartX+70
			jumpEndY=jumpStartY+70
		else
			thumbstickSizeMultiplier=60
			jumpStartX=sX-170
			jumpStartY=sY-210
			jumpEndX=jumpStartX+120
			jumpEndY=jumpStartY+120
		end
	end
	tinsert(cons,Connect(GetPropertyChangedSignal(mouse,"ViewSizeX"),refreshTouchRegions))
	tinsert(cons,Connect(GetPropertyChangedSignal(mouse,"ViewSizeY"),refreshTouchRegions))
	tinsert(cons,Connect(GetPropertyChangedSignal(gs,"TopbarInset"),refreshTouchRegions))
	refreshTouchRegions()

	local mouseCameraMove=false
	tinsert(cons,Connect(insGet(uis,"InputChanged"),function(a,b)
		if b then return end
		local inputType=insGet(a,"UserInputType")
		if mouseCameraMove and inputType==enumMM then
			local rotation=GetMouseDelta(uis)
			camrotX=clamp(v2Get(rotation,"Y")*mradN05+camrotX,npi2,pi2)
			camrotY=v2Get(rotation,"X")*mradN05+camrotY
			camrot=angles(camrotX,camrotY,0,enumYXZ)
			camcfLV=cfGet(camrot,"LookVector")
			camcfRV=cfGet(camrot,"RightVector")
		elseif inputType==enumMW then
			cammag=cammag+v3Get(insGet(a,"Position"),"Z")*(0.75-cammag/4)
			if cammag<0 then
				firstperson=false
			else
				cammag=0
				firstperson=true
			end
		end
	end))

	local fling=function(target)
		local noFling=hooks.noFling
		if noFling and noFling() then
			return false
		end
		if typeof(target)~="Instance" then
			target=insGet(mouse,"Target")
			if not target then
				return false
			end
		end
		if not IsDescendantOf(target,ws) then
			return false
		end
		if IsA(target,"BasePart") or IsA(target,"Humanoid") then 
			target=insGet(target,"Parent") 
			if IsA(target,"Accoutrement") then
				target=insGet(target,"Parent")
			end
		end
		if (not IsA(target,"Model")) or (target==c) then
			return false
		end
		local targetpart=QueryDescendants(target,">BasePart#Torso")[1] or QueryDescendants(target,">BasePart#UpperTorso")[1]
		if (not targetpart) or (flingtable[targetpart]~=nil) then
			return false
		end
		if highlightflingtargets then
			local h=i("Highlight")
			insSet(h,"Name",rs())
			insSet(h,"Adornee",target)
			insSet(h,"OutlineColor",c3(1,0,0))
			insSet(h,"Parent",hlparent)
			flingtable[targetpart]=h
		else
			flingtable[targetpart]=false
		end
		return true
	end

	if ctrlclicktp then
		ctrlclicktp=KeyCode.LeftControl
		local tpoff=v3_010*3
		if clickfling then
			tinsert(cons,Connect(insGet(mouse,"Button1Down"),function()
				if insGet(mouse,"Target") then
					if IsKeyDown(uis,ctrlclicktp) then
						pos=cfGet(insGet(mouse,"Hit"),"Position")+tpoff
						cfr=cfl(pos,pos+camcfLV*v3_101)
						xzvel=v3_0
						Yvel=0
					else
						fling()
					end
				end
			end))
		else
			tinsert(cons,Connect(insGet(mouse,"Button1Down"),function()
				if insGet(mouse,"Target") and IsKeyDown(uis,ctrlclicktp) then
					pos=cfGet(insGet(mouse,"Hit"),"Position")+tpoff
					cfr=cfl(pos,pos+camcfLV*v3_101)
					xzvel=v3_0
					Yvel=0
				end
			end))
		end
	elseif clickfling then
		tinsert(cons,Connect(insGet(mouse,"Button1Down"),fling))
	end

	local hhOff=3
	local hhOff1=3.01
	local setHipHeight=function(n)
		hhOff=n+3
		hhOff1=n+3.01
	end

	local noYvelTime=1
	hooks.lastroot=pos
	local lastsine=sine
	--extra movement the script on top can add: extvel is a velocity in studs/s that slows down by extdrag per second (elytra boost),
	--pendingLaunch is a y velocity that also works when standing on the ground (mace wind burst)
	local extvel=v3_0
	local extdrag=2.5
	local pendingLaunch=nil
	local lostlog={} --hats that are not ours right now (only used to print why a hat was lost)
	lostlog.name=function(part)
		local ok,n=pcall(function()
			return insGet(insGet(part,"Parent"),"Name")
		end)
		return (ok and n) or "a hat"
	end
	local mainFunction=function()
		sine=osclock()
		local delta=sine-lastsine
		deltaTime=min(delta*10,1)
		lastsine=sine

		if shiftlock then
			if allowshiftlock then
				if mouseBehavior~=enumMLC then
					mouseBehavior=enumMLC
					insSet(uis,"MouseBehavior",mouseBehavior)
				end
				mouseCameraMove=true
			else
				shiftlock=false
			end
		elseif firstperson then
			if mouseBehavior~=enumMLC then
				mouseBehavior=enumMLC
				insSet(uis,"MouseBehavior",mouseBehavior)
			end
			mouseCameraMove=true
		elseif IsMouseButtonPressed(uis,enumMB2) then
			if mouseBehavior~=enumMLCP then
				mouseBehavior=enumMLCP
				insSet(uis,"MouseBehavior",mouseBehavior)
			end
			mouseCameraMove=true
		else
			if mouseBehavior~=enumMD then
				mouseBehavior=enumMD
				insSet(uis,"MouseBehavior",mouseBehavior)
			end
			mouseCameraMove=false
		end

		--the extra velocity moves you like walking does, extnow (only x and z) is added to the walking velocity the hats get below
		local extmoved=false
		local extnow=v3_0
		if extvel~=v3_0 then
			extmoved=true
			extnow=extvel*v3_101
			pos=pos+extvel*delta
			extvel=extvel*math.max(0,1-delta*extdrag)
			if vmagnitude(extvel)<2 then
				extvel=v3_0
			end
		end

		local raycastresult=Raycast(ws,pos,v3_010*(fpdh-v3Get(pos,"Y")),raycastparams)
		local onground=nil
		if raycastresult then
			onground=raycastresult.Distance<hhOff1
			if onground then
				Yvel=0
				pos=pos+v3_010*(v3Get(raycastresult.Position,"Y")+hhOff-v3Get(pos,"Y"))*min(delta*20,1)
				if pendingLaunch then
					Yvel=pendingLaunch
					onground=false
				elseif jumpingInput and (jumpPower>0) then
					Yvel=jumpPower
					onground=false
				end
			else
				Yvel=Yvel-gravity*delta
				raycastresult=v3Get(raycastresult.Position,"Y")
				if v3Get(pos,"Y")+Yvel*delta<raycastresult then
					Yvel=0
					pos=pos+v3_010*(raycastresult+hhOff-v3Get(pos,"Y"))
				end
			end
		else
			Yvel=0
			onground=false
		end
		pendingLaunch=nil
		if extmoved then
			Yvel=0 --no gravity while the extra velocity is pushing
		end

		if firstperson then
			if isWalking then
				if walkSpeed==0 then
					xzvel=v3_0
					if onground then
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsIdle()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+v3_010*Yvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else
						pos=pos+v3_010*Yvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				else
					xzvel=vnormalize(vnormalize(camcfLV*v3_101)*FWmovement+vnormalize(camcfRV*v3_101)*RTmovement)*walkSpeed
					if onground then
						pos=pos+xzvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsWalk()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+(xzvel+v3_010*Yvel)*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else 
						pos=pos+(xzvel+v3_010*Yvel)*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				end
			else
				xzvel=v3_0
				if onground then
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsIdle()
					noYvelTime=min(noYvelTime+delta*0.3,1)
					xzvel=xzvel*(1-noYvelTime)
				elseif Yvel>0 then
					pos=pos+v3_010*Yvel*delta
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsJump()
					noYvelTime=0
				else
					pos=pos+v3_010*Yvel*delta
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsFall()
					noYvelTime=0
				end
			end
		elseif shiftlock then	
			if isWalking then
				if walkSpeed==0 then
					xzvel=v3_0
					if onground then
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsIdle()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+v3_010*Yvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else
						pos=pos+v3_010*Yvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				else
					xzvel=vnormalize(vnormalize(camcfLV*v3_101)*FWmovement+vnormalize(camcfRV*v3_101)*RTmovement)*walkSpeed
					if onground then
						pos=pos+xzvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsWalk()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+(xzvel+v3_010*Yvel)*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else
						pos=pos+(xzvel+v3_010*Yvel)*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				end
			else
				xzvel=v3_0
				if onground then
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsIdle()
					noYvelTime=min(noYvelTime+delta*0.3,1)
					xzvel=xzvel*(1-noYvelTime)
				elseif Yvel>0 then
					pos=pos+v3_010*Yvel*delta
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsJump()
					noYvelTime=0
				else
					pos=pos+v3_010*Yvel*delta
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsFall()
					noYvelTime=0
				end
			end
		else
			if isWalking then
				if walkSpeed==0 then
					xzvel=v3_0
					if onground then
						cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsIdle()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+v3_010*Yvel*delta
						cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else
						pos=pos+v3_010*Yvel*delta
						cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				else
					xzvel=vnormalize(vnormalize(camcfLV*v3_101)*FWmovement+vnormalize(camcfRV*v3_101)*RTmovement)*walkSpeed
					if onground then
						pos=pos+xzvel*delta
						cfr=cfAdd(Lerp(cfGet(cfr,"Rotation"),cfl(v3_0,xzvel),deltaTime),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsWalk()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+(xzvel+(v3_010*Yvel))*delta
						cfr=cfAdd(Lerp(cfGet(cfr,"Rotation"),cfl(v3_0,xzvel),deltaTime),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else
						pos=pos+(xzvel+(v3_010*Yvel))*delta
						cfr=cfAdd(Lerp(cfGet(cfr,"Rotation"),cfl(v3_0,xzvel),deltaTime),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				end
			else
				xzvel=v3_0
				if onground then
					cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
					camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsIdle()
					noYvelTime=min(noYvelTime+delta*0.3,1)
					xzvel=xzvel*(1-noYvelTime)
				elseif Yvel>0 then
					pos=pos+v3_010*Yvel*delta
					cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
					camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsJump()
					noYvelTime=0
				else
					pos=pos+v3_010*Yvel*delta
					cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
					camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsFall()
					noYvelTime=0
				end
			end
		end

		local hookframe=hooks.frame
		if hookframe then
			hookframe()
		end
		refreshjointsI(rootpart)
		tclear(refreshedjoints)

		local sine15=sine*15
		local idlerv=v3(sin(sine15),sin(sine15+1.0471975511965976),sin(sine15+2.0943951023931953))
		local idleoff=idlerv*0.003910064697265625 --0.0156402587890625/4

		local claimpos=insGet(primarypart,"Position")
		--how fast the whole character moves, parts marked .fx (swords/circle that spin around the body) get this instead of their own velocity:
		--their own velocity is the speed of the spinning/flapping which is then multiplied by 10 for the network, that flings them off
		local rootvel=v3_0
		if delta>0 then
			rootvel=(pos-hooks.lastroot)/delta
			if vmagnitude(rootvel)>speedlimit then
				rootvel=vnormalize(rootvel)*speedlimit
			end
		end
		hooks.lastroot=pos
		local alivevel=v3(cos(sine*4)*4,0,sin(sine*4)*4) --4 studs/s sideways, the direction turns around once every 1.6 seconds
		for i,v in next,cframes do
			local part=i.p

			if part then
				if (insGet(part,"ReceiveAge")==0) and not GetJoints(part)[1] then
					local placeholder=i.v
					local vpos=cfGet(v,"Position")
					if novoid and (v3Get(vpos,"Y")<novoid) then
						v=cfAdd(v,v3_010*(novoid-v3Get(vpos,"Y")))
					end
					local lastpos=i.l
					local vel=(vpos-lastpos)/delta
					local mag=vmagnitude(vel)
					if mag<0.11730194091796875 then --0.0156402587890625*15/2
						if placeholder and i.b then
							insSet(placeholder,"Parent",nil)
							i.b=false
						end
						i.l=cfGet(v,"Position")
						v=cfAdd(v,idleoff)
					elseif mag>speedlimit then
						if placeholder then
							insSet(placeholder,"CFrame",v)
							if not i.b then
								insSet(placeholder,"Parent",ws)
								i.b=true
							end
						end
						vel=vnormalize(vel)*speedlimit
						local newpos=lastpos+vel*delta
						v=cfAdd(cfGet(v,"Rotation"),newpos)
						i.l=newpos
					else
						if placeholder and i.b then
							insSet(placeholder,"Parent",nil)
							i.b=false
						end
						i.l=cfGet(v,"Position")
					end
					if i.fx then
						vel=rootvel
					end
					local claimtime=i.c
					if claimtime then
						if (sine-claimtime)<retVelTime then
							local offsetToPrimaryPart=claimpos-cfGet(v,"Position")
							local a=625.5001+wsGravity*-2*v3Get(offsetToPrimaryPart,"Y")
							if a>0 then --part can reach primary part
								insSet(part,"AssemblyLinearVelocity",v3_net+offsetToPrimaryPart*v3_101/((25.01+sqrt(a))/wsGravity))
							else --part cant reach primary part so at least aim for closest point
								insSet(part,"AssemblyLinearVelocity",v3_net+offsetToPrimaryPart*v3_101/(30.010999900019996/wsGravity))
							end
						else
							local vel1=vel*noYvelTime+xzvel+extnow
							if vmagnitude(vel1)>25.01 then
								insSet(part,"AssemblyLinearVelocity",vnormalize(vel1)*v3_xzL+v3_net)
							else
								insSet(part,"AssemblyLinearVelocity",vel1*v3_xz+v3_net)
							end
						end
					else
						i.c=sine
						if lostlog[i] then
							lostlog[i]=nil
							print("Cats FE: got "..lostlog.name(part).." back")
						end
						insSet(part,"CanCollide",false) --collisions between hats (or with the map) push them out of place
						local vel1=vel*noYvelTime+xzvel+extnow
						if vmagnitude(vel1)>25.01 then
							insSet(part,"AssemblyLinearVelocity",vnormalize(vel1)*v3_xzL+v3_net)
						else
							insSet(part,"AssemblyLinearVelocity",vel1*v3_xz+v3_net)
						end
					end
					--the console log showed that only the arms and legs never got lost: their idle sway always gives them some sideways velocity.
					--hats that sit still on you (head, torso, hidden or held items while you stand) reported none and got taken over, so every hat
					--that is not being reclaimed gets a small circling sideways velocity when it has (almost) none of its own
					if not (claimtime and ((sine-claimtime)<retVelTime)) then
						local lv=insGet(part,"AssemblyLinearVelocity")
						if (v3Get(lv,"X")^2+v3Get(lv,"Z")^2)<16 then
							insSet(part,"AssemblyLinearVelocity",lv+alivevel)
						end
					end
					insSet(part,"CFrame",v)
					insSet(part,"AssemblyAngularVelocity",idlerv)
				else
					if i.c and not lostlog[i] then
						--only prints, changes nothing: tells which hat was lost and why
						lostlog[i]=true
						local why=(GetJoints(part)[1] and "something welded it") or ("someone else is simulating it (ReceiveAge "..tostring(insGet(part,"ReceiveAge"))..")")
						local nearest=nil
						local ppos=insGet(part,"Position")
						for _,rp in next,rootparts do
							local d=vmagnitude(insGet(rp,"Position")-ppos)
							if (not nearest) or (d<nearest) then
								nearest=d
							end
						end
						warn("Cats FE: lost "..lostlog.name(part)..": "..why..", nearest other player "..(nearest and (math.floor(nearest*10)/10).." studs" or "none")..", you are "..(math.floor(vmagnitude(pos-ppos)*10)/10).." studs away")
						local onlost=hooks.onLost
						if onlost then
							onlost()
						end
					end
					i.c=nil
					i.l=insGet(part,"Position")
					local placeholder=i.v
					if placeholder then
						insSet(placeholder,"CFrame",v)
						if not i.b then
							insSet(placeholder,"Parent",ws)
							i.b=true
						end
					end
				end
			else
				local placeholder=i.v
				if placeholder then
					insSet(placeholder,"CFrame",v)
					if not i.b then
						insSet(placeholder,"Parent",ws)
						i.b=true
					end
				end
			end
		end

		setsimrad()
	end

	sine=osclock()
	lastsine=sine
	tinsert(cons,Connect(heartbeat,mainFunction))
	mainFunction()

	local refreshjoints=function(v) --use this on the main part if u have parts that
		refreshjointsI(v) --are connected with each other but arent connected to rootpart
		tclear(refreshedjoints)
	end

	local legcfR=cf(1,-1,0)
	local legcfL=cf(-1,-1,0)
	local raydir=v3_010*-2
	local raycastlegs=function() --this returns 2 values: right leg raycast offset, left leg raycast offset
		local rY=Raycast(ws,cfGet(cfMul(cfr,legcfR),"Position"),raydir,raycastparams)
		local lY=Raycast(ws,cfGet(cfMul(cfr,legcfL),"Position"),raydir,raycastparams)
		if rY then
			if lY then
				return v3Get(rY.Position,"Y")-(v3Get(pos,"Y")-3),v3Get(lY.Position,"Y")-(v3Get(pos,"Y")-3)
			else
				return v3Get(rY.Position,"Y")-(v3Get(pos,"Y")-3),0
			end
		elseif lY then
			return 0,v3Get(lY.Position,"Y")-(v3Get(pos,"Y")-3)
		else
			return 0,0
		end
	end

	local velbycfrvec=function() --this returns 2 values: forward/backwards movement (from -1 to 1), right/left movement (from -1 to 1)
		local fw=cfGet(cfr,"LookVector")*xzvel/walkSpeed
		local rt=cfGet(cfr,"RightVector")*xzvel/walkSpeed
		return v3Get(fw,"X")+v3Get(fw,"Z"),v3Get(rt,"X")+v3Get(rt,"Z")
	end

	local lastvel=v3_0
	local velchg1=v3_0
	local velchgbycfrvec=function() --this returns 2 values: forward/backwards velocity change, right/left velocity change
		velchg1=velchg1+(lastvel-xzvel) --i recommend setting velchg1 to v3_0 when u start using this function or it will look worse
		lastvel=xzvel
		velchg1=velchg1-velchg1*(deltaTime/2)
		local fw=cfGet(cfr,"LookVector")*velchg1/32
		local rt=cfGet(cfr,"RightVector")*velchg1/32
		return v3Get(fw,"X")+v3Get(fw,"Z"),v3Get(rt,"X")+v3Get(rt,"Z")
	end

	local lastYvel=0
	local velYchg1=0
	local velYchg=function() --this returns Y axis velocity change
		velYchg1=clamp(velYchg1+(lastYvel-Yvel),-50,50) --i recommend setting velYchg1 to 0 when u start using this function or it will look worse
		lastYvel=Yvel
		velYchg1=velYchg1-velYchg1*(deltaTime/2)
		return velYchg1
	end

	local rotToMouse=function(alpha) --this rotates ur character towards your mouse hit position
		local pos1=pos*v3_010+cfGet(insGet(mouse,"Hit"),"Position")*v3_101
		if pos~=pos1 then --could make nan rotation
			cfr=Lerp(cfr,cfl(pos,pos1),alpha or deltaTime)
		end
	end

	local glitchJoint=function(joint,targetGlitchTime,delayFrom,delayTo,radiansFrom,radiansTo) 
		if sine>targetGlitchTime then --example usage: local glitchtime=0 addMode("x",{idle=function() glitchtime=glitchJoint(joint,glitchtime,0.2,0.4,-0.1,0.1) end})
			radiansFrom=radiansFrom*100
			radiansTo=radiansTo*100
			joint.C0=cfMul(joint.C0,angles(mrandom(radiansFrom,radiansTo)/100,mrandom(radiansFrom,radiansTo)/100,mrandom(radiansFrom,radiansTo)/100)) 
			return sine+mrandom(delayFrom*100,delayTo*100)/100
		end
		return targetGlitchTime
	end

	local setWalkSpeed=function(n)
		if type(n)~="number" then
			n=16
		end
		walkSpeed=n
	end
	local setJumpPower=function(n)
		if type(n)~="number" then
			n=50
		end
		jumpPower=n
	end
	local setGravity=function(n)
		if type(n)~="number" then
			n=196.2
		end
		gravity=n
	end
	local setCfr=function(v) --sets character cframe
		if typeof(v)=="CFrame" then
			local newpos=cfGet(v,"Position")
			camcf=cfAdd(camcf,newpos-pos)
			insSet(cam,"CFrame",camcf)
			cfr=v
			pos=newpos
			hooks.lastroot=pos
		elseif typeof(v)=="Vector3" then
			camcf=cfAdd(camcf,v-pos)
			insSet(cam,"CFrame",camcf)
			cfr=cfAdd(cfGet(cfr,"Rotation"),v)
			pos=v
			hooks.lastroot=pos
		end
	end
	local getVel=function() --returns character velocity
		return xzvel+v3_010*Yvel --important: use only in lerps or it might not work
	end
	local getCamCF=function() --returns camera cframe
		return camcf
	end
	local isFirstPerson=function() --returns true if user is in first person camera mode
		return firstperson
	end
	local getCfr=function() --returns the cframe of the character (yaw only), the position is where the root part is
		return cfr
	end
	local getYvel=function() --returns the y velocity (negative = falling)
		return Yvel
	end
	local launch=function(vy) --sets the y velocity, also works when standing on the ground (like a jump)
		Yvel=vy
		pendingLaunch=vy
	end
	local impulse=function(v,drag) --extra velocity in studs/s that slows down by drag per second, no gravity while it lasts
		extvel=v
		extdrag=drag or 2.5
	end
	local impulseActive=function() --true while the extra velocity of impulse() is still moving you
		return extvel~=v3_0
	end
	local groundDistance=function() --distance from the root part down to the ground (nil if there is none), and the position of the ground
		local res=Raycast(ws,pos,v3_010*(fpdh-v3Get(pos,"Y")),raycastparams)
		if res then
			return res.Distance,res.Position
		end
		return nil,nil
	end
	local mouseHit=function(maxdist) --where the mouse cursor points at (ignores players and things you cant collide with), second value is false if it points at the sky
		maxdist=maxdist or 1000
		local loc=GetMouseLocation(uis)
		local ray=cam:ViewportPointToRay(v2Get(loc,"X"),v2Get(loc,"Y"))
		local dir=ray.Direction*maxdist
		local res=Raycast(ws,ray.Origin,dir,raycastparams)
		if res then
			return res.Position,true
		end
		return ray.Origin+dir,false
	end

	return {
		cframes=cframes,
		joints=joints,
		fling=fling,
		refreshjoints=refreshjoints,
		raycastlegs=raycastlegs,
		velbycfrvec=velbycfrvec,
		velchgbycfrvec=velchgbycfrvec,
		velYchg=velYchg,
		addmode=addmode,
		getPart=getPart,
		getPartFromMesh=getPartFromMesh,
		getAccWeldFromMesh=getAccWeldFromMesh,
		getJoint=getJoint,
		getPartJoint=getPartJoint,
		rotToMouse=rotToMouse,
		glitchJoint=glitchJoint,
		setWalkSpeed=setWalkSpeed,
		setJumpPower=setJumpPower,
		setGravity=setGravity,
		setCfr=setCfr,
		getVel=getVel,
		getCamCF=getCamCF,
		isFirstPerson=isFirstPerson,
		setHipHeight=setHipHeight,
		getCfr=getCfr,
		getYvel=getYvel,
		launch=launch,
		impulse=impulse,
		impulseActive=impulseActive,
		groundDistance=groundDistance,
		mouseHit=mouseHit,
		setHooks=function(h)
			hooks.frame=h.frame
			hooks.noFling=h.noFling
			hooks.onLost=h.onLost
		end,
		resetmode=function() --goes back to the default animation (cancels the emote that is playing)
			if mode~="default" then
				local modeLeft=modes[mode].modeLeft
				if modeLeft then
					modeLeft()
				end
				mode="default"
				lerpsIdle=defaultmode.idle or emptyfunction
				lerpsWalk=defaultmode.walk or emptyfunction
				lerpsJump=defaultmode.jump or emptyfunction
				lerpsFall=defaultmode.fall or emptyfunction
			end
		end
	}
end

--=============================================================================
-- CATS FE
-- everything below the reanimate engine: cat hat ids, cat animations, music and the gui
--=============================================================================

local main=function()
	local genv=(getgenv and getgenv()) or _G
	local JUST_A_BASEPLATE=123974602339071 --the hat loader and the "-re" respawn command only work in this place
	--where Loader.lua and the Music folder live (raw.githubusercontent.com/<user>/<repo>/<branch>/), the songs are downloaded from <REPO>Music/<name>.mp3
	--if the repo is somewhere else set getgenv().CatsRepo = "https://raw.githubusercontent.com/<user>/<repo>/<branch>/" before loading this script
	local REPOS={}
	if genv.CatsRepo then
		tinsert(REPOS,(genv.CatsRepo:sub(-1)=="/") and genv.CatsRepo or (genv.CatsRepo.."/"))
	end
	tinsert(REPOS,"https://raw.githubusercontent.com/NoctaliaLua/CatsFE/main/")
	local FOLDER="CatsFE" --executor workspace folder the songs are saved in
	local RESPAWN_ON_STOP=true --pressing 0 to stop also respawns your real character (JustABaseplate only)
	local HIDE_DEPTH=19 --hidden hats sit this many studs below the root part (same as NoctaliaGlitcher)
	local GROUND_TO_ROOT=3 --studs between the ground and the root part

	local pi=math.pi
	local rad=math.rad
	local floor=math.floor
	local mmax=math.max
	local rgb=Color3.fromRGB

	----------------------------------------------------------------------------
	-- the cats. height is in studs, key is the key that turns you into it, song is the file in Music/ (without .mp3)
	-- dance = the cat has an M animation and its song only starts when M is pressed, every other cat plays its song as soon as it is picked
	-- ori = which of the 24 orientations the hat needs to stand upright facing forward (calibrate in game with ] and [, see below), lift = studs up/down
	----------------------------------------------------------------------------
	local CATS={
		{name="Main cat",key="Q",id="131526787092382",height=5.5,song="MainCat",ori=1,lift=0},
		{name="Maxwell",key="E",id="104266266514503",height=2,song="Maxwell",dance="maxwell",ori=1,lift=0},
		{name="Oiia",key="R",id="108373103080631",height=1.8,song="OIIA",dance="oiia",ori=1,lift=0},
		{name="Banana",key="T",id="16828241700",height=4.4,song="Banana",ori=1,lift=0},
		{name="Army",key="Y",id="78310798256215",height=2.5,song="Army",ori=1,lift=0},
		{name="Meimei",key="U",id="81948394859968",height=1.7,song="MeiMei",ori=1,lift=0},
		{name="Glungus",key="I",id="98270823827811",height=2,song="Glungus",ori=1,lift=0},
		{name="Dance",key="O",id="101245075751229",height=2.3,song="Dance",ori=1,lift=0},
		{name="Drool",key="P",id="113043218431131",height=5.1,song="Drool",ori=1,lift=0},
		{name="McDonalds",key="F",id="88614740888473",height=2.2,song="Mcdonalds",ori=1,lift=0}
	}
	local ALL_IDS={}
	local SONGS={} --file name -> {name=file name, asset=getcustomasset path}
	for _,cat in next,CATS do
		tinsert(ALL_IDS,cat.id)
		SONGS[cat.song]={name=cat.song}
	end

	----------------------------------------------------------------------------
	-- animation settings
	----------------------------------------------------------------------------
	--the axis a turn happens around, in the space of the player: "X" = right (tips forward/back), "Y" = up (turns left/right), "Z" = forward (tilts left/right)
	local WALK_AXIS="Y"
	local DANCE_AXIS="Y" --maxwell
	local SPIN_AXIS="X" --oiia
	local AIR_AXIS="X" --the small lean while jumping/falling
	local WALK_HOP=0.3 --studs the cat bounces up while walking
	local WALK_TURN=rad(20) --degrees it turns left and then right while walking
	local WALK_RATE=14 --hops per second * pi (higher = faster)
	local JUMP_TILT=rad(12) --lean in the air (0 = none)
	local DANCE_HOP=0.1 --maxwell: "kinda bounce but not really"
	local DANCE_TURN=rad(45) --maxwell: turns this far left and right
	local DANCE_RATE=5.5 --maxwell: radians per second, one left+right takes 2*pi/this seconds
	--oiia: goes up OIIA_RISE studs, then repeats: fast spin (7 spins/hops in 1.9s), 1s normal, slower spin (1.9s), 1s normal.
	--after that has run for another 13 seconds it wanders around inside a 2 stud square for 10s, then goes back to spinning until the song loops
	local OIIA_RISE=2
	local OIIA_HOP=0.5
	local OIIA_FAST_TIME=1.9
	local OIIA_FAST_CYCLES=7
	local OIIA_SLOW_TIME=1.9
	local OIIA_SLOW_CYCLES=3
	local OIIA_GAP=1
	local OIIA_CYCLE=OIIA_FAST_TIME+OIIA_GAP+OIIA_SLOW_TIME+OIIA_GAP --5.8
	local OIIA_WANDER_AT=19.3 --5.8 + 13 seconds, moved to the second a fast spin ends so nothing snaps
	local OIIA_WANDER_TIME=10
	local OIIA_WANDER_STEPS=10 --a new spot every second
	local OIIA_WANDER_STEP=OIIA_WANDER_TIME/OIIA_WANDER_STEPS
	local OIIA_WANDER_END=OIIA_WANDER_AT+OIIA_WANDER_TIME
	local OIIA_WANDER_HALF=1 --2 stud square

	----------------------------------------------------------------------------
	-- hat calibration. hat meshes have no fixed forward/up so the first placement of a cat can be turned wrong.
	-- in game: ] picks the next cat (and turns you into it), [ goes to the next of the 24 orientations, = / - move it up/down 0.1 studs.
	-- every press prints the numbers, put them in CATS (ori= and lift=)
	----------------------------------------------------------------------------
	--the 24 ways to turn something by multiples of 90 degrees, the first one is no turn at all
	local ORI24={}
	do
		local seen={}
		for ax=0,3 do
			for ay=0,3 do
				for az=0,3 do
					local m=angles(ax*pi/2,ay*pi/2,az*pi/2)
					local _,_,_,r00,r01,r02,r10,r11,r12,r20,r21,r22=m:GetComponents()
					local key=string.format("%d,%d,%d,%d,%d,%d,%d,%d,%d",floor(r00+0.5),floor(r01+0.5),floor(r02+0.5),floor(r10+0.5),floor(r11+0.5),floor(r12+0.5),floor(r20+0.5),floor(r21+0.5),floor(r22+0.5))
					if not seen[key] then
						seen[key]=true
						tinsert(ORI24,m)
					end
				end
			end
		end
	end

	----------------------------------------------------------------------------
	-- small helpers
	----------------------------------------------------------------------------
	local TweenService=game:GetService("TweenService")
	local SoundService=game:GetService("SoundService")
	local tween=function(obj,props,time,style,dir)
		local tw=TweenService:Create(obj,TweenInfo.new(time,style or e.EasingStyle.Quad,dir or e.EasingDirection.Out),props)
		tw:Play()
		return tw
	end
	local mk=function(class,props,parent)
		local o=i(class)
		for k,v in next,props do
			o[k]=v
		end
		o.Parent=parent
		return o
	end
	local parentGui=function(gui)
		local ok=pcall(function()
			gui.Parent=(gethui and gethui()) or FindFirstChildOfClass(game,"CoreGui")
		end)
		if (not ok) or (not gui.Parent) then
			gui.Parent=pg
		end
	end
	local guis={} --every gui this script made, they are destroyed on unload
	local newGui=function(order)
		local gui=mk("ScreenGui",{Name=rs(),ResetOnSpawn=false,IgnoreGuiInset=true,DisplayOrder=order,ZIndexBehavior=e.ZIndexBehavior.Sibling},nil)
		parentGui(gui)
		tinsert(guis,gui)
		return gui
	end
	local urlencode=function(s)
		return (s:gsub("[^%w%-_%.~]",function(ch)
			return string.format("%%%02X",string.byte(ch))
		end))
	end
	local lerpn=function(a,b,x) return a+(b-a)*x end
	local smooth=function(x)
		x=clamp(x,0,1)
		return x*x*(3-2*x)
	end
	local axisRot=function(axis,a)
		if axis=="X" then
			return angles(a,0,0)
		elseif axis=="Z" then
			return angles(0,0,a)
		end
		return angles(0,a,0)
	end

	--the unload function of the last time this script was executed
	if genv.CatsFEUnload then
		pcall(genv.CatsFEUnload)
	end

	local sendChat=function(message)
		local ok,err=pcall(function()
			local tcs=FindFirstChildOfClass(game,"TextChatService")
			if tcs and (tcs.ChatVersion==e.ChatVersion.TextChatService) then
				local channels=tcs:WaitForChild("TextChannels",5)
				local channel=channels and (channels:FindFirstChild("RBXGeneral") or channels:FindFirstChildWhichIsA("TextChannel"))
				channel:SendAsync(message)
			else
				FindFirstChildOfClass(game,"ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents",5).SayMessageRequest:FireServer(message,"All")
			end
		end)
		if not ok then
			warn("Cats FE: couldnt send chat message: "..tostring(err))
		end
	end

	local hatmeshes={} --asset id -> {m=meshid,t=textureid} or false if it couldnt be loaded
	local getMeshIds=function(id)
		local ok,meshid,textureid=pcall(function()
			local obj=game:GetObjects("rbxassetid://"..id)[1]
			local handle=obj:FindFirstChild("Handle",true)
			local m,t
			if handle:IsA("MeshPart") then
				m,t=handle.MeshId,handle.TextureID
			else
				local sm=handle:FindFirstChildOfClass("SpecialMesh")
				m,t=sm.MeshId,sm.TextureId
			end
			obj:Destroy()
			return m,t
		end)
		if not ok then
			return nil
		end
		local m=type(meshid)=="string" and meshid:match("%d+")
		if m then
			return m,(type(textureid)=="string" and textureid:match("%d+")) or ""
		end
		return nil
	end
	local fetchAll=function(ids,timeout)
		local pending=0
		for _,id in next,ids do
			if hatmeshes[id]==nil then
				hatmeshes[id]=false
				pending=pending+1
				tspawn(function()
					local m,t=getMeshIds(id)
					if m then
						hatmeshes[id]={m=m,t=t}
					end
					pending=pending-1
				end)
			end
		end
		local deadline=osclock()+timeout
		while (pending>0) and (osclock()<deadline) do
			twait(0.1)
		end
	end

	----------------------------------------------------------------------------
	-- console
	----------------------------------------------------------------------------
	local printConsole=function()
		print("Hello welcome to Cats fe, by noctalia")
		print(" ")
		warn("[--- How to start---]")
		print("Press 9 to load required hats (Just a baseplate only)")
		print("After loading hats, press 0 to reanimate, again to stop")
		print(" ")
		warn("[--- Cats ---]")
		for _,cat in next,CATS do
			print(cat.key.." - "..cat.name)
		end
		print(" ")
		print("M - Maxwell and Oiia only: starts their song and animation, again to stop")
		print(" ")
		print("Up Arrow - increase volume")
		print("Down Arrow - decrease volume")
		print(" ")
		print("] - calibration: next cat, [ - next orientation, = / - - up / down")
	end

	----------------------------------------------------------------------------
	-- loading screen
	----------------------------------------------------------------------------
	local showLoading=function(titleText,subText,seconds)
		local gui=newGui(2147483647)
		local overlay=mk("Frame",{Name=rs(),Size=u2(1,0,1,0),BackgroundColor3=c3(0,0,0),BackgroundTransparency=1,BorderSizePixel=0},gui)
		local common={BackgroundTransparency=1,TextTransparency=1,AnchorPoint=v2(0.5,0.5)}
		local title=mk("TextLabel",{Name=rs(),Position=u2(0.5,0,0.5,-30),Size=u2(0,900,0,120),Text=titleText,Font=e.Font.GothamBold,TextSize=100,TextColor3=c3(1,1,1)},overlay)
		local sub=mk("TextLabel",{Name=rs(),Position=u2(0.5,0,0.5,50),Size=u2(0,900,0,26),Text=subText,Font=e.Font.Gotham,TextSize=20,TextColor3=rgb(150,150,150)},overlay)
		local count=mk("TextLabel",{Name=rs(),Position=u2(0.5,0,0.5,84),Size=u2(0,300,0,26),Text=seconds.."s",Font=e.Font.Gotham,TextSize=20,TextColor3=rgb(150,150,150)},overlay)
		for _,l in next,{title,sub,count} do
			for k,v in next,common do
				l[k]=v
			end
		end
		tspawn(function()
			tween(overlay,{BackgroundTransparency=0.5},0.7)
			twait(0.35)
			for _,l in next,{title,sub,count} do
				tween(l,{TextTransparency=0},0.5)
			end
			for s=seconds,1,-1 do
				count.Text=s.."s"
				twait(1)
			end
			count.Text="0s"
			twait(0.25)
			tween(overlay,{BackgroundTransparency=1},0.7)
			for _,l in next,{title,sub,count} do
				tween(l,{TextTransparency=1},0.5)
			end
			twait(0.9)
			pcall(Destroy,gui)
		end)
	end

	----------------------------------------------------------------------------
	-- preload: everything the first reanimate needs, so it doesnt lag
	----------------------------------------------------------------------------
	local PRE={ready=false,pending=0}
	local job=function(f)
		PRE.pending=PRE.pending+1
		tspawn(function()
			local ok,err=pcall(f)
			if not ok then
				warn("Cats FE: preloading failed: "..tostring(err))
			end
			PRE.pending=PRE.pending-1
		end)
	end
	local canDownload=(writefile and getcustomasset and isfile and readfile and true) or false
	--a real mp3 starts with ID3 or an mp3 frame header (a github 404 page is plain text and getcustomasset says "unsupported file type" for it)
	local isMp3=function(d)
		return (type(d)=="string") and (#d>10000) and ((d:sub(1,3)=="ID3") or ((d:byte(1)==255) and (d:byte(2)>=224)))
	end
	local downloadSong=function(song)
		local path=FOLDER.."/Music/"..song.name..".mp3"
		local data=isfile(path) and readfile(path)
		if not isMp3(data) then
			data=nil
			local tried={}
			--the file on github can be named a bit different (upper/lower case, extension)
			local lower=song.name:lower()
			local title=lower:gsub("(%a)(%a*)",function(a,b) return a:upper()..b end)
			local names={song.name..".mp3",lower..".mp3",title..".mp3",song.name..".MP3"}
			for _,base in next,REPOS do
				for _,file in next,names do
					local url=base.."Music/"..urlencode(file)
					local ok,res=pcall(game.HttpGet,game,url)
					if ok and isMp3(res) then
						data=res
						break
					end
					tinsert(tried,url)
				end
				if data then
					break
				end
			end
			if not data then
				error("no mp3 found, tried:\n"..table.concat(tried,"\n"))
			end
			writefile(path,data)
		end
		song.asset=getcustomasset(path)
	end
	local startPreload=function()
		if canDownload then
			if makefolder and isfolder then
				if not isfolder(FOLDER) then makefolder(FOLDER) end
				if not isfolder(FOLDER.."/Music") then makefolder(FOLDER.."/Music") end
			end
			for _,song in next,SONGS do
				job(function()
					local ok,err=pcall(downloadSong,song)
					if not ok then
						song.failed=true
						warn("Cats FE: couldnt load the song "..song.name..": "..tostring(err))
					end
				end)
			end
		else
			warn("Cats FE: your executor cant write files / getcustomasset, there will be no music")
		end
		job(function()
			fetchAll(ALL_IDS,30) --mesh and texture ids of all the hats
		end)
		tspawn(function()
			twait(0.2)
			while PRE.pending>0 do
				twait(0.1)
			end
			PRE.ready=true
		end)
	end

	----------------------------------------------------------------------------
	-- music: one song at a time, always on loop
	----------------------------------------------------------------------------
	local music={volume=0.5,sound=nil,current=nil,token=0}
	music.play=function(file)
		music.current=file
		music.token=music.token+1
		local token=music.token
		local song=SONGS[file]
		if music.sound then
			pcall(function()
				music.sound:Stop()
			end)
		end
		if (not song) or (not canDownload) then
			return
		end
		tspawn(function()
			--the song can still be downloading
			local waited=0
			while (not song.asset) and (not song.failed) and (waited<90) and (music.token==token) do
				twait(0.2)
				waited=waited+0.2
			end
			if (music.token~=token) or (not song.asset) then
				return
			end
			local snd=music.sound
			if not snd then
				snd=mk("Sound",{Name=rs(),Volume=music.volume,Looped=true},SoundService)
				music.sound=snd
			end
			snd.SoundId=song.asset
			snd.TimePosition=0
			snd:Play()
		end)
	end
	music.stop=function()
		music.token=music.token+1
		music.current=nil
		if music.sound then
			pcall(function()
				music.sound:Stop()
			end)
		end
	end
	music.volumeStep=function(d)
		music.volume=clamp(floor((music.volume+d)*10+0.5)/10,0,1)
		if music.sound then
			music.sound.Volume=music.volume
		end
	end
	music.destroy=function()
		music.token=music.token+1
		music.current=nil
		if music.sound then
			pcall(Destroy,music.sound)
			music.sound=nil
		end
	end

	----------------------------------------------------------------------------
	-- loading the hats (chat commands of Just A Baseplate)
	----------------------------------------------------------------------------
	--types the message into the real chat bar and presses enter (the only way "/e" commands work with the new chat), plain chat if there is no chat bar
	local hatsBusy=false
	local typeChat=function(message)
		local ok=pcall(function()
			local tcs=FindFirstChildOfClass(game,"TextChatService")
			local config=tcs and tcs:FindFirstChild("ChatInputBarConfiguration")
			local box=config and config.TextBox
			if not box then
				local ec=FindFirstChildOfClass(game,"CoreGui"):FindFirstChild("ExperienceChat")
				box=ec and ec:FindFirstChild("TextBox",true)
			end
			assert(box,"no chat bar")
			--tries up to 4 times: if the message is still in the box after enter was pressed it was not sent
			for attempt=1,4 do
				box:CaptureFocus()
				twait(0.15)
				box.Text=""
				twait(0.15)
				--the chat suggests commands while you type ("/e" turned into "/cleare" at enter), so set the text again until it stays exactly like it should
				for fix=1,4 do
					box.Text=message
					twait(0.25)
					if box.Text==message then
						break
					end
				end
				twait(0.1)
				local pressed=pcall(function()
					local vim=game:GetService("VirtualInputManager")
					vim:SendKeyEvent(true,e.KeyCode.Return,false,game)
					twait(0.05)
					vim:SendKeyEvent(false,e.KeyCode.Return,false,game)
				end)
				if not pressed then
					if keypress and keyrelease then
						keypress(0x0D)
						twait(0.05)
						keyrelease(0x0D)
					elseif firesignal then
						firesignal(box.FocusLost,true)
					end
				end
				twait(0.25)
				if box.Text~=message then
					break
				end
			end
		end)
		if not ok then
			sendChat(message)
		end
	end
	local loadHats=function()
		if game.PlaceId~=JUST_A_BASEPLATE then
			warn("Cats FE: hats only load in Just A Baseplate")
			return
		end
		if c then
			warn("Cats FE: stop the reanimate first (press 0), then load the hats")
			return
		end
		if hatsBusy then
			return
		end
		hatsBusy=true
		print("Cats FE: loading hats...")
		showLoading("Wait!","The hats are loading, do not touch anything",10)
		tspawn(function()
			typeChat("/e -ch")
			twait(1)
			typeChat("/e -pd")
			twait(1)
			typeChat("/e -gh "..table.concat(ALL_IDS," "))
			twait(5)
			hatsBusy=false
		end)
	end

	local RT=nil --the state of the current run, nil while not reanimated
	local starting=false
	local stopAll=function()
		local was=(c~=nil) or (RT~=nil)
		local rt=RT
		RT=nil
		if rt and rt.cleanup then
			pcall(rt.cleanup)
		end
		stopreanimate()
		music.stop()
		if was and RESPAWN_ON_STOP then
			pcall(function()
				local ch=insGet(lp,"Character")
				local hum=ch and FindFirstChildOfClass(ch,"Humanoid")
				if hum then
					insSet(hum,"Health",0)
				end
			end)
			if game.PlaceId==JUST_A_BASEPLATE then
				tdelay(0.5,function()
					sendChat("-re")
				end)
			end
		end
	end

	----------------------------------------------------------------------------
	-- oiia: what the cat does at a second of the song (spin angle, extra height, sideways offset x and z)
	----------------------------------------------------------------------------
	local newWanderPoints=function()
		local pts={{0,0}}
		for _=1,OIIA_WANDER_STEPS-1 do
			tinsert(pts,{(mrandom()*2-1)*OIIA_WANDER_HALF,(mrandom()*2-1)*OIIA_WANDER_HALF})
		end
		tinsert(pts,{0,0}) --it ends where it started
		return pts
	end
	local oiiaAt=function(t,pts)
		if t>=OIIA_WANDER_AT and t<OIIA_WANDER_END then
			local w=(t-OIIA_WANDER_AT)/OIIA_WANDER_STEP
			local k=min(floor(w),OIIA_WANDER_STEPS-1)
			local f=smooth(w-k) --tweens from spot to spot
			local a,b=pts[k+1],pts[k+2]
			return 0,0,lerpn(a[1],b[1],f),lerpn(a[2],b[2],f)
		end
		local p
		if t<OIIA_WANDER_AT then
			p=t%OIIA_CYCLE
		else
			p=(t-OIIA_WANDER_END)%OIIA_CYCLE
		end
		local cycles,u
		if p<OIIA_FAST_TIME then
			cycles=OIIA_FAST_CYCLES
			u=p/OIIA_FAST_TIME
		elseif (p>=OIIA_FAST_TIME+OIIA_GAP) and (p<OIIA_FAST_TIME+OIIA_GAP+OIIA_SLOW_TIME) then
			cycles=OIIA_SLOW_CYCLES
			u=(p-OIIA_FAST_TIME-OIIA_GAP)/OIIA_SLOW_TIME
		else
			return 0,0,0,0
		end
		local cyc=cycles*u
		return 2*pi*cyc,OIIA_HOP*sin(pi*(cyc%1)),0,0
	end

	----------------------------------------------------------------------------
	-- reanimate
	----------------------------------------------------------------------------
	local startReanimate=function()
		if c or starting or RT then
			return
		end
		starting=true
		local fine,err=pcall(function()
			if not PRE.ready then
				print("Cats FE: still preloading, one moment...")
				local waited=0
				while (not PRE.ready) and (waited<40) do
					twait(0.1)
					waited=waited+0.1
				end
			end

			--no rig: nothing gets aligned to the r6 parts, every cat is a loose accessory that the script moves around
			local backup=aligns
			aligns={}
			local t=reanimate()
			aligns=backup
			if type(t)~="table" then
				warn("Cats FE: couldnt start")
				return
			end

			local cframes=t.cframes
			local getPartJoint=t.getPartJoint
			local addmode=t.addmode

			--the part of the engine that is the root part (the cats are placed relative to it)
			local rootP=nil
			for part in next,cframes do
				if (part.Name=="HumanoidRootPart") and not part.m then
					rootP=part
					break
				end
			end
			assert(rootP,"no root part")

			local S={ --everything that changes while you play
				cat=0,kind="idle",
				walkW=0,wph=0,air=0,
				dance=false,dW=0,dph=0,wpts=nil,
				rise=0,spin=0,bob=0,ox=0,oz=0,
				nextResolve=0
			}

			--the engine tells which animation the character would play, the cats only need to know that
			addmode("default",{
				idle=function() S.kind="idle" end,
				walk=function() S.kind="walk" end,
				jump=function() S.kind="jump" end,
				fall=function() S.kind="fall" end
			})

			----------------------------------------------------------------
			-- hats: find the cats that are worn and take over their joints
			----------------------------------------------------------------
			local items={} --cat index -> hat
			local findCat=function(idx,used)
				local info=hatmeshes[CATS[idx].id]
				if not info then
					return nil
				end
				--first the mesh and the texture have to match, then (if nothing did) only the mesh
				for pass=1,2 do
					for part in next,cframes do
						local p=part.p
						if p and part.m and (not used[part]) and sfind(part.m,info.m) and ((pass==2) or sfind(part.t,info.t)) and IsDescendantOf(p,ws) then
							local j=getPartJoint(part)
							if j and j.Part1 then
								used[part]=true
								part.fx=true --the engine gives these the velocity of the player instead of their own (the animations are fast, that would fling them)
								return {cat=idx,part=part,joint=j}
							end
						end
					end
				end
				return nil
			end
			local resolve=function()
				--a hat that fell off (or got taken over by someone else) stays in here: the engine keeps its place and the animation keeps going,
				--it snaps back as soon as the hat is ours again
				local used={}
				for _,h in next,items do
					used[h.part]=true
				end
				for idx=1,#CATS do
					if not items[idx] then
						items[idx]=findCat(idx,used)
					end
				end
			end
			resolve()
			do
				local count=0
				local lost={}
				for idx,cat in next,CATS do
					if items[idx] then
						count=count+1
					else
						tinsert(lost,cat.name..(hatmeshes[cat.id] and "" or " (mesh lookup failed)"))
					end
				end
				print("Cats FE: reanimated, found "..count.." of "..#CATS.." cats")
				if #lost>0 then
					warn("Cats FE: these cats are not worn (press 9 to load the hats first, a hat can also be missing): "..table.concat(lost,", "))
				end
			end

			--puts a hat at target, relative to the given part. rot turns the hat itself (calibration)
			local place=function(h,parent,target,rot)
				local j=h.joint
				j.Part1=parent
				j.C0=cf_0
				j.C1=rot and cfMul(target,rot) or target
			end
			local hideCF=cf(0,-HIDE_DEPTH,0)

			----------------------------------------------------------------
			-- picking a cat, the M animations
			----------------------------------------------------------------
			local selectCat=function(idx)
				if S.cat==idx then
					return
				end
				S.cat=idx
				S.dance=false
				local cat=CATS[idx]
				music.stop()
				if not cat.dance then
					music.play(cat.song) --these play their song right away
				end
			end
			local toggleDance=function()
				local cat=CATS[S.cat]
				if not (cat and cat.dance) then
					return
				end
				S.dance=not S.dance
				if S.dance then
					S.wpts=newWanderPoints()
					music.play(cat.song)
				else
					music.stop()
				end
			end

			----------------------------------------------------------------
			-- calibration keys
			----------------------------------------------------------------
			local calibrate=function(keyName)
				if keyName=="RightBracket" then
					selectCat((S.cat % #CATS)+1)
					local cat=CATS[S.cat]
					print("Cats FE: "..cat.name.." (ori="..cat.ori.." of 24, lift="..cat.lift..")  [ next orientation, = / - up / down, ] next cat")
					return
				end
				local cat=CATS[S.cat]
				if not cat then
					return
				end
				if keyName=="LeftBracket" then
					cat.ori=(cat.ori % 24)+1
				elseif keyName=="Equals" then
					cat.lift=floor((cat.lift+0.1)*10+0.5)/10
				else
					cat.lift=floor((cat.lift-0.1)*10+0.5)/10
				end
				print("Cats FE: "..cat.name.."   ->   ori="..cat.ori..", lift="..cat.lift)
			end

			----------------------------------------------------------------
			-- per frame: the cat animation and the hats
			----------------------------------------------------------------
			local lastT=sine
			local frame=function()
				local dt=min(sine-lastT,0.1)
				lastT=sine

				if sine>=S.nextResolve then
					S.nextResolve=sine+1
					resolve()
				end

				local cat=CATS[S.cat]
				local dancing=S.dance and cat and cat.dance
				S.dW=S.dW+((dancing and 1 or 0)-S.dW)*min(dt*8,1)
				local dW=S.dW

				--walking: hops up and down fast and turns left and right
				S.walkW=S.walkW+((S.kind=="walk" and 1 or 0)-S.walkW)*min(dt*14,1)
				if S.kind=="walk" then
					S.wph=S.wph+dt*WALK_RATE
				end
				local wk=S.walkW*(1-dW)
				local u=(S.wph/pi)%1
				local hop=(u<0.6) and sin(u/0.6*pi/2) or cos((u-0.6)/0.4*pi/2) --up in 60% of the time, down fast
				local y=WALK_HOP*hop*wk
				local walkAng=WALK_TURN*sin(S.wph/2)*wk

				--jumping and falling
				local airT=(S.kind=="jump" and 1) or (S.kind=="fall" and -1) or 0
				S.air=S.air+(airT-S.air)*min(dt*8,1)
				local airAng=JUMP_TILT*S.air*(1-dW)

				--maxwell: M
				S.dph=S.dph+dt*DANCE_RATE
				local danceAng=0
				if cat and cat.dance=="maxwell" then
					danceAng=DANCE_TURN*sin(S.dph)*dW
					y=y+DANCE_HOP*abs(cos(S.dph))*dW
				end

				--oiia: M. the moves follow the position of the song, so it starts over every time the song loops
				local snd=music.sound
				local oiia=dancing and (cat.dance=="oiia")
				if oiia and snd and snd.IsPlaying and (music.current==cat.song) and S.wpts then
					local a,b,ox,oz=oiiaAt(snd.TimePosition,S.wpts)
					S.spin=((a+pi)%(2*pi))-pi
					S.bob=b
					S.ox=ox
					S.oz=oz
				else
					local k=min(dt*10,1)
					S.spin=S.spin*(1-k)
					S.bob=S.bob*(1-k)
					S.ox=S.ox*(1-k)
					S.oz=S.oz*(1-k)
				end
				S.rise=S.rise+((oiia and OIIA_RISE or 0)-S.rise)*min(dt*6,1)
				y=y+S.rise+S.bob

				local rot=cfMul(cfMul(axisRot(WALK_AXIS,walkAng),axisRot(DANCE_AXIS,danceAng)),cfMul(axisRot(AIR_AXIS,airAng),axisRot(SPIN_AXIS,S.spin)))

				for idx,h in next,items do
					if idx==S.cat then
						local ct=CATS[idx]
						--the bottom of the cat is on the ground (the root part is 3 studs above it)
						local target=cfMul(cf(S.ox,-GROUND_TO_ROOT+ct.height/2+ct.lift+y,S.oz),rot)
						place(h,rootP,target,ORI24[ct.ori])
					else
						place(h,rootP,hideCF) --like NoctaliaGlitcher: under the root part, moving with you
					end
				end
			end

			----------------------------------------------------------------
			-- keys
			----------------------------------------------------------------
			local keyCat={}
			for idx,cat in next,CATS do
				keyCat[cat.key]=idx
			end
			tinsert(cons,Connect(insGet(uis,"InputBegan"),function(inp,processed)
				if insGet(gs,"MenuIsOpen") or GetFocusedTextBox(uis) then
					return
				end
				local name=insGet(inp,"KeyCode").Name
				if keyCat[name] then
					selectCat(keyCat[name])
				elseif name=="M" then
					toggleDance()
				elseif name=="Up" then music.volumeStep(0.1)
				elseif name=="Down" then music.volumeStep(-0.1)
				elseif (name=="RightBracket") or (name=="LeftBracket") or (name=="Equals") or (name=="Minus") then
					calibrate(name)
				end
			end))

			--Just A Baseplate has a "-net" chat command that helps the hats stay yours (found in game: "/e -net" makes them stay up longer).
			--it is sent once right after the joints break, and again whenever a hat gets lost (at most every 5 seconds)
			local netCd=0
			local sendNet=function()
				if (game.PlaceId~=JUST_A_BASEPLATE) or (osclock()<netCd) then
					return
				end
				netCd=osclock()+5
				tspawn(function()
					typeChat("/e -net")
				end)
			end
			t.setHooks({frame=frame,onLost=sendNet})
			tdelay(0.8,sendNet)

			RT={t=t,S=S}
			selectCat(1) --you start as the main cat
		end)
		starting=false
		if not fine then
			warn("Cats FE: "..tostring(err))
			stopAll()
		end
	end

	----------------------------------------------------------------------------
	-- start
	----------------------------------------------------------------------------
	local topcon=Connect(insGet(uis,"InputBegan"),function(inp)
		if insGet(gs,"MenuIsOpen") or GetFocusedTextBox(uis) then
			return
		end
		local name=insGet(inp,"KeyCode").Name
		if name=="Nine" then
			loadHats()
		elseif name=="Zero" then
			if starting then
				return
			end
			if c or RT then
				stopAll()
			else
				tspawn(startReanimate)
			end
		end
	end)

	genv.CatsFEUnload=function()
		pcall(Disconnect,topcon)
		pcall(stopAll)
		pcall(music.destroy)
		for _,gui in next,guis do
			pcall(Destroy,gui)
		end
		if genv.CatsFEUnload then
			genv.CatsFEUnload=nil
		end
	end

	showLoading("Noctalia","Open console by pressing F9 or typing /console in chat.",5)
	printConsole()
	startPreload()
end
main()
