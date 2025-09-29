# skill

```bash

# 目录
$SPBROOT\share\local\pcb\skill

# 入口
allegro.ilinit

# load
load("pads_z.il")
load("set_grid.il")

```

# pads_z.il

```js

axlCmdRegister("layernumvisible" 'layernumvisible ?cmdType "general")
procedure( layernumvisible( @rest num)
_LCSetNumLayVis( num)
);end-procedure
;###########################################################
;#                 number layer visible                    #
;###########################################################
defun( _LCSetNumLayVis ( lnum, @optional msg)
prog( ( class, i, n, layer)
  n = 0
  ln = nil
foreach( enum, lnum
           num = atoi( enum)
if( num then
if( num <= axlGetParam( "paramLayerGroup:ETCH") -> nChildren && num > 0 then
                   class = nthelem( num axlGetParam( "paramLayerGroup:ETCH") -> groupMembers)
                   i = makeVector( 11 nil)
                   i[0] = axlGetParam( "paramLayerGroup:ANTI ETCH") -> visible != nil
                   i[1] = axlGetParam( "paramLayerGroup:BOUNDARY") -> visible != nil
                   i[2] = axlGetParam( "paramLayerGroup:ROUTE KEEPOUT") -> visible != nil
                   i[3] = axlGetParam( "paramLayerGroup:VIA KEEPOUT") -> visible != nil
                   i[5] = axlIsVisibleLayer( "ROUTE KEEPIN/ALL")
                   i[6] = axlIsVisibleLayer( "ROUTE KEEPOUT/ALL")
                   i[7] = axlIsVisibleLayer( "DRC ERROR CLASS/ALL")
                   i[8] = axlIsVisibleLayer( "VIA KEEPOUT/ALL")
                   i[9] = axlIsVisibleLayer( "ANTI ETCH/ALL")
                   i[10] = axlIsVisibleLayer( "BOUNDARY/ALL")
if( n == 0 then
axlVisibleDesign( nil)
else
axlVisibleSet( layer)
);end-if
axlVisibleLayer( "BOARD GEOMETRY/OUTLINE", t)
axlVisibleLayer( "BOARD GEOMETRY/DESIGN_OUTLINE" t)
axlVisibleLayer( "BOARD GEOMETRY/CUTOUT" t)
axlVisibleLayer( strcat( "ANTI ETCH/", class), i[0])
axlVisibleLayer( strcat( "BOUNDARY/", class), i[1])
axlVisibleLayer( strcat( "ROUTE KEEPOUT/", class), i[2])
axlVisibleLayer( strcat( "VIA KEEPOUT/", class), i[3])
axlVisibleLayer( "ROUTE KEEPIN/ALL", i[5])
axlVisibleLayer( "ROUTE KEEPOUT/ALL", i[6])
axlVisibleLayer( "DRC ERROR CLASS/ALL", i[7])
axlVisibleLayer( "VIA KEEPOUT/ALL", i[8])
axlVisibleLayer( "ANTI ETCH/ALL", i[9])
axlVisibleLayer( "BOUNDARY/ALL", i[10])
axlVisibleLayer( strcat( "PIN/", class), t)
axlVisibleLayer( strcat( "VIA CLASS/", class), t)
axlVisibleLayer( strcat( "DRC ERROR CLASS/", class), t)
axlVisibleLayer( strcat( "ETCH/", class), t)
if( class == "TOP" || class == "BOTTOM" then
axlVisibleLayer( strcat( "PACKAGE GEOMETRY/SILKSCREEN_", class), t)
);end-if
                   n++
                   ln = append1( ln num)
else
if( num == 0 then
if( n == 0 then
axlVisibleDesign( nil)
axlVisibleLayer( "BOARD GEOMETRY/OUTLINE" t)
axlVisibleLayer( "BOARD GEOMETRY/DESIGN_OUTLINE" t)
axlVisibleLayer( "BOARD GEOMETRY/CUTOUT" t)
                           class = nil
                           n++
                           ln = append1( ln num)
);end-if
else
axlMsgPut( "E- The %d etch layer is not exist.", num)
);end-if
);end-if
else axlMsgPut( "E- %L is not number.", enum)
);end-if
if( n != 0 then layer = axlVisibleGet())
);end-foreach
if( n == 1 && class then axlSetActiveLayer( strcat( "ETCH/", class)))
if( n != 0 && ! msg then
axlVisibleUpdate( t)
      msg = ""
foreach( n ln
sprintf(layer "%d", n)
if( msg == "" then msg = layer else msg = strcat( msg, " ", layer))
);end-foreach
axlMsgPut( "The %s etch layer display.", msg)
);end-if
);end-prog
);end-defun
;###########################################################
;#                 customize shortcut key  only 32 layer   #
;###########################################################
prog( ( n, s, key)
  n = 0
while( n < 32
sprintf(key "z%d", n)
sprintf(s "layernumvisible %d", n)
axlSetAlias( key, s)
         n++
);end-while
);end-prog

```

# set_grid.il

```js

axlCmdRegister("g", 'setGrid, ?cmdType "general")

defun(setGrid (s)
	let((o_grid)
		o_grid = axlDBGridGet("TOP")
		o_grid->name = 'all
		s = atof(s)
		o_grid->xGrids = s
		o_grid->yGrids = s
		axlDBGridSet(o_grid)
	)
)

```

# set_design_units.il


```js

axlCmdRegister("umm", 'setDesignMM, ?cmdType "general")
axlCmdRegister("um", 'setDesignM, ?cmdType "general")

defun(setDesignMM ()
	p = axlGetParam("paramDesign")
  printf("current design units: %s\n"  p->units)
  axlDBChangeDesignUnits("millimeters" 4)
)

defun(setDesignM ()
	p = axlGetParam("paramDesign")
  printf("current design units: %s\n" p->units)
  axlDBChangeDesignUnits("mils" 3)
)

```