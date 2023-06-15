##########################################################
##					Mining Overhaul	v2					##
##					by AiedailEclipsed					##
##########################################################
# All code edits made will be noted in comments.		 #
# Unless otherwise denoted by a comment, all code		 #
# within is from the original Mining minigame script	 #
# by Maruno or has been edited by the individual		 #
# developer or user.									 #
##########################################################
# Spreadsheet with probability formulas:				 #
#	http://bit.ly/mining-overhaul-prob					 #
# Modification Release Thread:							 #
#	http://bit.ly/mining-overhaul						 #
##########################################################
##				THANK YOU AND PLEASE ENJOY!				##
##########################################################

class MiningGameScene
	BOARDWIDTH  = 13
	BOARDHEIGHT = 10
	ITEMS = [ # Item, probability, graphic x, graphic y, width, height, pattern
		[:DOMEFOSSIL,4, 0,3, 5,4,[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,0]],
		[:HELIXFOSSIL,4, 17,3, 4,4,[1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1]],
		[:ROOTFOSSIL,4, 10,7, 5,5,[0,1,1,0,0,1,1,0,0,0,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1]],
		[:SKULLFOSSIL,4, 20,7, 4,4,[1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0]],
		[:ARMORFOSSIL,4, 24,7, 5,4,[0,1,1,1,0,0,1,1,1,0,1,1,1,1,1,0,1,1,1,0]],
		[:CLAWFOSSIL,4, 9,12, 4,5,[0,0,1,1,0,1,1,1,1,1,1,0,1,1,1,0,1,1,0,0]],
		[:FIRESTONE,16, 20,11, 3,3,[1,1,1,1,1,1,1,1,1]],
		[:WATERSTONE,16, 23,11, 3,3,[1,1,1,1,1,1,1,1,0]],
		[:THUNDERSTONE,16, 26,11, 3,3,[0,1,1,1,1,1,1,1,0]],
		[:LEAFSTONE,8, 18,14, 3,4,[0,1,0,1,1,1,1,1,1,0,1,0]],
		[:LEAFSTONE,8, 21,14, 4,3,[0,1,1,0,1,1,1,1,0,1,1,0]],
		[:MOONSTONE,8, 25,14, 4,2,[0,1,1,1,1,1,1,0]],
		[:MOONSTONE,8, 27,16, 2,4,[1,0,1,1,1,1,0,1]],
		[:SUNSTONE,16, 21,17, 3,3,[0,1,0,1,1,1,1,1,1]],
		[:OVALSTONE,24, 24,17, 3,3,[1,1,1,1,1,1,1,1,1]],
		[:EVERSTONE,24, 21,20, 4,2,[1,1,1,1,1,1,1,1]],
		[:STARPIECE,20, 0,17, 3,3,[0,1,0,1,1,1,0,1,0]],
		[:REVIVE,20, 0,20, 3,3,[0,1,0,1,1,1,0,1,0]],
		[:MAXREVIVE,12, 0,23, 3,3,[1,1,1,1,1,1,1,1,1]],
		[:RAREBONE,10, 3,17, 6,3,[1,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,1]],
		[:RAREBONE,10, 3,20, 3,6,[1,1,1,0,1,0,0,1,0,0,1,0,0,1,0,1,1,1]],
		[:LIGHTCLAY,24, 6,20, 4,4,[1,0,1,0,1,1,1,0,1,1,1,1,0,1,0,1]],
		[:HARDSTONE,24, 6,24, 2,2,[1,1,1,1]],
		[:HEARTSCALE,56, 8,24, 2,2,[1,0,1,1]],
		[:IRONBALL,24, 9,17, 3,3,[1,1,1,1,1,1,1,1,1]],
		[:ODDKEYSTONE,12, 10,20, 4,4,[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]],
		[:HEATROCK,20, 12,17, 4,3,[1,0,1,0,1,1,1,1,1,1,1,1]],
		[:DAMPROCK,20, 14,20, 3,3,[1,1,1,1,1,1,1,0,1]],
		[:SMOOTHROCK,20, 17,18, 4,4,[0,0,1,0,1,1,1,0,0,1,1,1,0,1,0,0]],
		[:AMPLIFIELDROCK,12, 25,0, 4,3,[1,1,0,1,1,1,1,1,1,1,1,1]],
		[:ICYROCK,20, 17,22, 4,4,[0,1,1,0,1,1,1,1,1,1,1,1,1,0,0,1]],
		[:REDSHARD,56, 21,22, 3,3,[1,1,1,1,1,0,1,1,1]],
		[:GREENSHARD,56, 25,20, 4,3,[1,1,1,1,1,1,1,1,1,1,0,1]],
		[:YELLOWSHARD,56, 25,23, 4,3,[1,0,1,0,1,1,1,0,1,1,1,1]],
		[:BLUESHARD,56, 26,26, 3,3,[1,1,1,1,1,1,1,1,0]],
		[:INSECTPLATE,8, 0,26, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
		[:DREADPLATE,8, 4,26, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
		[:DRACOPLATE,8, 8,26, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
		[:ZAPPLATE,8, 12,26, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
		[:FISTPLATE,8, 16,26, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
		[:FLAMEPLATE,8, 20,26, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
		[:MEADOWPLATE,8, 0,29, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
		[:EARTHPLATE,8, 4,29, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
		[:ICICLEPLATE,8, 8,29, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
		[:TOXICPLATE,8, 12,29, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
		[:MINDPLATE,8, 16,29, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
		[:STONEPLATE,8, 20,29, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
		[:SKYPLATE,8, 0,32, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
		[:SPOOKYPLATE,8, 4,32, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
		[:IRONPLATE,8, 8,32, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
		[:SPLASHPLATE,8, 12,32, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
		[:PIXIEPLATE,8, 16,32, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
		##				START MO CODE					##
		#	All new items added to mining possibilities  #
		#	with their assorted meta data.				 #
		[:NUGGET,20, 16,0, 2,2,[1,1,1,1]],
		[:BIGNUGGET,12, 12,0, 3,3,[1,1,1,1,1,1,1,1,1]],
		[:COMETSHARD,12, 14,23, 3,3,[0,1,0,1,1,1,0,1,0]],
		[:DAWNSTONE,16, 0,0, 3,3,[1,1,1,1,1,1,1,1,1]],
		[:DUSKSTONE,16, 3,0, 3,3,[1,1,1,1,1,1,1,1,1]],
		[:SHINYSTONE,16, 6,0, 3,3,[1,1,1,1,1,1,1,1,1]],
		[:ICESTONE,16, 9,0, 3,3,[1,1,1,1,1,1,1,1,1]],
		[:COVERFOSSIL,4, 0,35, 4,4,[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]],
		[:PLUMEFOSSIL,4, 5,35, 3,3,[1,1,1,1,1,1,1,1,1]],
		[:JAWFOSSIL,4, 12,35, 4,4,[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]],
		[:SAILFOSSIL,4, 8,35, 4,4,[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]]
		## 				END MO CODE 					##
	] 
  
	def pbStartScene
		@sprites={}
		@viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
		@viewport.z=99999
		addBackgroundPlane(@sprites,"bg","Mining/miningbg",@viewport)
		@sprites["itemlayer"]=BitmapSprite.new(Graphics.width,Graphics.height,@viewport)
		##				START MO CODE					##
		#	Changed item picture to custom version		 #
		#	in mods folder.								 #
		@itembitmap=AnimatedBitmap.new(_INTL("Data/Mods/mo-items"))
		## 				END MO CODE 					##
		@ironbitmap=AnimatedBitmap.new(_INTL("Graphics/Pictures/Mining/irons"))
		@items=[]
		@itemswon=[]
		@iron=[]
		pbDistributeItems
		pbDistributeIron
			for i in 0...BOARDHEIGHT
			for j in 0...BOARDWIDTH
			@sprites["tile#{j+i*BOARDWIDTH}"]=MiningGameTile.new(32*j,64+32*i)
		end
		end
	@sprites["crack"]=MiningGameCounter.new(0,4)
	@sprites["cursor"]=MiningGameCursor.new(58,0) # central position, pick
	@sprites["tool"]=IconSprite.new(434,254,@viewport)
	@sprites["tool"].setBitmap(sprintf("Graphics/Pictures/Mining/toolicons"))
	@sprites["tool"].src_rect.set(0,0,68,100)
	update
	pbFadeInAndShow(@sprites)
	end

	def pbNoDuplicateItems(newitem)
		return true if newitem==:HEARTSCALE   # Allow multiple Heart Scales
		##				START MO CODE					##
		#	Added Cover, Plume, Sail, & Jaw fossils		 #
		#	to list.									 #
		fossils=[:DOMEFOSSIL,:HELIXFOSSIL,:OLDAMBER,
				:ROOTFOSSIL,:SKULLFOSSIL,:ARMORFOSSIL,
				:CLAWFOSSIL,:COVERFOSSIL,:PLUMEFOSSIL,
				:SAILFOSSIL,:JAWFOSSIL]
		#	Added Pixie Plate to plate list.			 #
		plates=[:INSECTPLATE,:DREADPLATE,:DRACOPLATE,:ZAPPLATE,
			:FISTPLATE,:FLAMEPLATE,:MEADOWPLATE,:EARTHPLATE,:ICICLEPLATE,
			:TOXICPLATE,:MINDPLATE,:STONEPLATE,:SKYPLATE,:SPOOKYPLATE,
			:IRONPLATE,:SPLASHPLATE,:PIXIEPLATE]
		#	Created Rare Miscellaneous category			 #
		#	delimiter.									 #
		raremisc=[:MAXREVIVE,:AMPLIFIELDROCK,:BIGNUGGET,
			:COMETSHARD,:ODDKEYSTONE]
		#	Created Evo Stone category delimiter.		 #
		evostones=[:FIRESTONE,:WATERSTONE,:THUNDERSTONE,
			:LEAFSTONE,:MOONSTONE,:SUNSTONE,:DAWNSTONE,
			:DUSKSTONE,:SHINYSTONE,:ICESTONE]
		for i in @items
			preitem=ITEMS[i[0]][0]
			return false if preitem==newitem   # No duplicate items
			return false if fossils.include?(preitem) && fossils.include?(newitem)
			return false if plates.include?(preitem) && plates.include?(newitem)
		#	Implemented the delimiters created above.	 #
			return false if raremisc.include?(preitem) && raremisc.include?(newitem)
			return false if evostones.include?(preitem) && evostones.include?(newitem)
		## 				END MO CODE 					##
		end
		return true
	end
end
