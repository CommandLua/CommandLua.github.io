-------
-- @module ScenEdit
--
-- Lua is a case sensitve language.
--
-- When accessing object properties directly as in 'unit.name', the property should be in lower which will match the Lua generated code. There may be a <i>few</i> special cases (e.g. mission.SISH=true which is a shortcut for scrub_if_side_human) which will be documented below.
--
-- However, when accessing the properties through the module functions below, both the keyword/property and the value are case insensitive; the code will worry about matching them up.
--
--<u><b>Selector</b></u><br>
-- These define the information required as part of the 'select' process for the functions. In the case of functions that 'add' things, these are also key elements to the adding process.
-- Other properties may be included in the 'selector' such as when updating an existing table.
--
-- When selecting units, it is preferrable to use the GUID as the identifier for a precise match. If not, then the side and name for a more limited search. And as a last option, just the name which search all units in the scenario. When using just the name, usually the first matching name is returned. This is okay if the names are unique.
-- Thus including the side, it will only check the units on that side for a match.
--
--<u><b>Wrapper</b></u><br>
-- These define the information that is returned from some functions. This information can be usually modified either directly (object.field) or by a wrapper Set(..) function. The particular wrapper Set(..) function is preferred as some validation is performed on the input to ensure that it is within the bounds of the field being updated.
--
--<u><b>Data type</b></u><br>
-- These cover any special considerations for the data, such as longitude/latitude; degrees, DMS, N/S, E/W, etc.
--


--[[-- Selects a doctrine, for on a side, group, mission, or unit.

This selector can only be used with the doctrine mechanism, with other systems relying on different selection methods.

@Selector DoctrineSelector
@param[type=string] side The side to select/from
@param[type=string] mission The name of the mission to select
@param[type=string] name The name of the unit to select
@param[type=string] group The name of the group to select
@param[type=bool] escort If a strike mission, adding 'escort=true' will update the escort doctrine
]]


--[[-- Doctrine options.


For each field, adding the suffix "_player_editable" determines if the player can alter the setting.

@Wrapper Doctrine
@param[type=bool] use_nuclear_weapons True iff the unit should be able to employ nuclear weapons
@param[type=bool] engage_non_hostile_targets True iff the unit should attempt hostile action against units that are not hostile
@param[type=bool] rtb_when_winchester True iff the unit should return to base when out of weapons
@param[type=bool] ignore_plotted_course True iff the unit should ignore plotted courses
@param[type=string] engaging_ambiguous_targets One of "Ignore", "Optimistic", or "Pessimistic"
@param[type=bool] automatic_evasion True iff the unit should automatically evade incoming missiles
@param[type=bool] maintain_standoff True iff the unit should try to avoid approaching its target, only valid for ships
@param[type=bool] use_refuel_unrep One of "Always" or "Never"
@param[type=bool] engage_opportunity_targets True iff the unit should take opportunistic shots
@param[type=bool] use_sams_in_anti_surface_mode True iff SAMs should be used to engage surface targets
@param[type=bool] ignore_emcon_while_under_attack True iff EMCON should be ignored and all systems should go active when engaged
@param[type=bool] quick_turnaround_for_aircraft One of "Yes", "FightersAndASW", or "No"
@param[type=bool] air_operations_tempo One of "Surge" or "Sustained"
@param[type=bool] kinematic_range_for_torpedoes One of "AutomaticAndManualFire", "ManualFireOnly", or "No"
@param[type=string] weapon_control_status_air '0','1','2' which correspond to Free, Tight, and Hold.
@param[type=string] weapon_control_status_surface '0','1','2' which correspond to Free, Tight, and Hold.
@param[type=string] weapon_control_status_subsurface '0','1','2' which correspond to Free, Tight, and Hold.
@param[type=string] weapon_control_status_land '0','1','2' which correspond to Free, Tight, and Hold.
]]

--[[--
Set the doctrine of the designated object.

This function uses selector to find the thing to modify, then modifies the doctrine of that object based on the given object.

@param[type=DoctrineSelector] selector The selector for the object to modify
@param[type=Doctrine] doctrine The doctrine to update the object to
@usage ScenEdit_SetDoctrine({side="Soviet Union"}, {kinematic_range_for_torpedoes = "AutomaticAndManualFire",use_nuclear_weapons= "yes" })
@usage ScenEdit_SetDoctrine({side="Soviet Union", mission="ASW PATROL"}, {kinematic_range_for_torpedoes = "AutomaticAndManualFire",use_nuclear_weapons= "yes" })
@usage ScenEdit_SetDoctrine({side="Soviet Union", name="Bear #2"}, {use_nuclear_weapons= "yes" })
]]
function ScenEdit_SetDoctrine(selector, doctrine) end

--[[--
Gets the doctrine of the designated object.

This function looks up the doctrine of the object selected by selector, and throws an exception if the unit does not exist.

@param[type=DoctrineSelector] selector The selector for the object to look up
@return[type=Doctrine] The doctrine of the selected object
@usage ScenEdit_GetDoctrine({side="Soviet Union"}).use_nuclear_weapons
]]
function ScenEdit_GetDoctrine(selector) end

--[[-- Execute a Lua Event action script.
 .. but does not show results of execution of the action
 
@function ScenEdit_ExecuteEventAction
@param[type=string] EventDescriptionOrID The description or ID of the event action
@return[type=string] "Ok" on execution or nothing.
]]



--[[-- Event.

@Selector Event
@param[type=string] EventDescriptionOrID The description or ID of the event
@param[type=string] GUID The GUID of the event [READONLY]
@param[type=bool] IsActive If the action is active to the player
@param[type=bool] IsRepeatable If the event can be triggered multiple times
@param[type=string] Description If specified, the new description for the event
@param[type=number] Probability If specified, a new probability for the event
@param[type={ Triggers }] triggers A table of triggers for this event [READONLY]
@param[type={ Conditions }] triggers A table of conditions for this event [READONLY]
@param[type={ Actions }] triggers A table of actions for this event [READONLY]
]]


--[[-- Sets the properties of an event.


@param[type=string] EventDescriptionOrID The event to modify
@param[type=Event] options The event options to modify
]]
function ScenEdit_SetEvent(EventDescriptionOrID, options)end

--[[-- Gets the properties of an event.


@param[type=string] EventDescriptionOrID The event to retrieve
@return[type=Event] The event details
]]
function ScenEdit_GetEvent(EventDescriptionOrID)end


--[[--
Special action selector.

@Selector SpecialAction
@param[type=string] GUID The GUID of the special action [READONLY]
@param[type=string] ActionNameOrID The name or ID of the special action
@param[type=bool] IsActive If the action is visible to the player
@param[type=bool] IsRepeatable If the player can use the action multiple times
@param[type=string] NewName If specified, the new name of the action
@param[type=string] Description If specified, the new description for the action
]]


--[[--
Sets the properties of an existing special action.

@param[type=SpecialAction] action_info The special action to modify
]]
function ScenEdit_SetSpecialAction(action_info)end

--[[--
Gets the properties of an existing special action.

@param[type=SpecialAction] action_info The special action to retrieve
]]
function ScenEdit_GetSpecialAction(action_info)end

--[[-- Execute a Lua Special action script
 .. but does not show results of execution of the action
 
@function ScenEdit_ExecuteSpecialAction
@param[type=string] eventNameOrId The name or ID of the event action
@return[type=string] "Ok" on execution or nothing.
]]


--[[--
Imports an inst file.

@param[type=string] side The side to import the inst file as
@param[type=string] filename The filename of the inst file
]]
function ScenEdit_ImportInst(side, filename) end


--[[-- Get details of a mission.

@function ScenEdit_GetMission
@param[type=string] SideNameOrId The mission side
@param[type=string] MissionNameOrId The mission name
@return[type=Mission] A mission descriptor if the mission exists or nil otherwise.
@usage local mission = ScenEdit_GetMission('USA','CV CAP Left')
]]


--[[-- New mission options.

@Selector NewMission
@field[type=string] type Mission sub-type (Applies to Patrol and Strike)
@field[type=string] destination Ferry mission destination
@field[type={ string }] zone A table of reference points as names or GUIDs (Can apply to Patrol, Support, Mining, Cargo)
]]

--[[-- Add new mission.

@function ScenEdit_AddMission
@param[type=string] SideNameOrId The mission side
@param[type=string] MissionNameOrId The mission name
@param[type=string] MissionType The mission type (Strike, Ferry, Patrol, etc)
@param[type=NewMission] MissionOptions The mission specific options as a table
@return[type=Mission] A mission descriptor of the added mission or nil otherwise.
@usage local mission = ScenEdit_AddMission('USA','Marker strike','strike',{type='land'})
]]

]]

--[[-- Delete mission.
 .. unassigns any units attached to it.
@function ScenEdit_DeleteMission
@param[type=string] SideNameOrId The mission side
@param[type=string] MissionNameOrId The mission name
@return[type=bool] True if mission has been removed.
@usage local mission = ScenEdit_AddMission('USA','Marker strike','strike',{type='land'})
]]

]]

--[[-- Export mission parameters.
 .. as a XML file in folder Command_base/Defaults.
 [Experimental as this should really be treated like an attachment so can be imported with Scenario]
@function ScenEdit_ExportMission
@param[type=string] SideNameOrId The mission side
@param[type=string] MissionNameOrId The mission name
@return[type={ guid }] Mission GUID exported.
@usage local mission = ScenEdit_ExportMission('USA','Marker strike'})
]]

]]

--[[-- Import mission parameters.
 .. from a XML file in folder Command_base/Defaults.
 [Experimental as this should really be treated like an attachment so can be imported with Scenario]
@function ScenEdit_ImportMission
@param[type=string] SideNameOrId The mission side
@param[type=string] MissionNameOrId The mission name
@return[type={ guid }] Mission GUID imported.
@usage local mission = ScenEdit_ExportMission('USA','Marker strike'})
]]


--[[-- Set details for a mission.

@function ScenEdit_SetMission
@param[type=string] SideName The mission side
@param[type=string] MissionNameOrId The mission name
@param[type=Mission] MissionOptions The mission options as a table.
@return[type=Mission] A mission descriptor if the mission exists or nil otherwise.
@usage local mission = ScenEdit_SetMission('USA','CV CAP Left',{TankerUsage=1,OnStation=2})
]]


--[[-- Assigns targets to a Strike mission.

 'UnitX' can be used as a unit descriptor.
 Contacts can also be assigned. Refer to the VP_ functions for details
@function ScenEdit_AssignUnitAsTarget
@param[type=string|table] AUNameOrIDOrTable The name/GUID of the unit, or a table of `name/GUID` to add to target list
@param[type=string] MissionNameOrID The mission to update
@return[type={ GUID } ] A table of targets added
@usage ScenEdit_AssignUnitAsTarget({'target1', 'target2'}, 'Land strike')
@usage ScenEdit_AssignUnitAsTarget('UnitX', 'Land strike')
]]


--[[-- Removes targets from a Strike mission.

The 'UnitX' can be used as a unit descriptor
@function ScenEdit_RemoveUnitAsTarget
@param[type=string|table] AUNameOrIDOrTable The name/GUID of the unit, or a table of `name/GUID` to remove from target list
@param[type=string] MissionNameOrID The mission 
@return[type={ GUID } ] A table of targets removed
@usage ScenEdit_RemoveUnitAsTarget({'target1', 'target2'}, 'Land strike')
]]

--[[-- Reference point selector.

To select reference point(s), specify either

* `name` and `side`, to select a reference point `name` belonging to `side` [name AND side if possible] or
* `guid`, if the unique ID of the reference point is known [preferred] or
* `area`, table of reference points (name or guid)

 GUID method takes precedence over name/side if both present.

@Selector ReferencePointSelector
@field[type=string] side The side the reference point is visible to
@field[type=string] name The name of the reference point
@field[type=string] guid The unique identifier for the reference point
@field[type={name|guid}] area Table of reference points (used with the Set()/Get() functions]
]]

--[[-- Add a new reference point.

This function adds a new reference point as defined by a descriptor. 
The descriptor <b>must</b> contain at least a name, side, latitude and longitude. 
@param[type=ReferencePoint] descriptor The reference point details to create
@usage ScenEdit_AddReferencePoint({side="United States", name="Downed Pilot", lat=0.1, lon=4, highlighted=true})
@return[type=ReferencePoint] The reference point wrapper for the new reference point.
]]
function ScenEdit_AddReferencePoint(descriptor) end

--[[-- Update a reference point(s) with new values.
 
Given a valid @{ReferencePointSelector} as part of the descriptor, the function wil update the values contained in the descriptor. Values may be omitted from the descriptor if they are intended to remain unmodified. 
The 'area' selector is useful for changing some common attribute, like locking or highlighting, in bulk.
 
 Additional key=value options are; <br>
  NEWNAME='string' to rename a reference point <br>
  TOGGLEHIGHLIGHTED = True to flip the reference point(s) highlight <br>
  CLEAR = True to remove the 'relative to' of the reference point(s)
 
@param[type=ReferencePoint] descriptor A valid selector with other values to update.
@return[type=ReferencePoint] The reference point descriptor for the reference point or first one in the area.
@usage ScenEdit_SetReferencePoint({side="United States", name="Downed Pilot", lat=0.5})
@usage ScenEdit_SetReferencePoint({side="United States", name="Downed Pilot", lat=0.5, lon="N50.50.50", highlighted = true})
@usage ScenEdit_SetReferencePoint({side="United States", area={"rp-100","rp-101","rp-102","rp-103","rp-104"}, highlighted = true})
]]
function ScenEdit_SetReferencePoint(descriptor) end
 
--[[-- Get a set of reference point(s).
 
Given a reference point selector, the function will return a table of the reference point descriptors.
@param[type=ReferencePointSelector] selector 
@return[type={ReferencePoint}] The table of reference point descriptors for the selector
@usage local points = ScenEdit_GetReferencePoints({side="United States", area={"rp-100","rp-101","rp-102","rp-103","rp-104"})
]]
function ScenEdit_GetReferencePoints(selector) end

--[[-- Delete a reference point.
 
Given a reference point selector, this function will remove it.
@param[type=ReferencePointSelector] selector The reference point to delete.
@return[type=bool] True if deleted
]]
function ScenEdit_DeleteReferencePoint(selector) end

--[[--
Import an attachment into the scene.

@param[type=string] attachment Either the name of the attachment or the GUID of the attachment
]]
function ScenEdit_UseAttachment(attachment) end

--[[--
Use an attachment on a side (used for .inst files as attachments).

@param[type=string] attachment Either the name of the attachment or the GUID of the attachment
@param[type=string] sidename The name of the side to import the attachment into
]]
function ScenEdit_UseAttachmentOnSide(attachment, sidename) end


--[[-- A Position on the map.
 ... is referred to with latitude (north/south) and longitude (east/west) coordinates. 
These can be represented in two forms, degrees minutes seconds, and decimal degrees. The Command Lua API supports both forms.

A set of latitude & longitude to define a point. Within the simulation, the values are recorded in decimal degrees.
@table LatLon
@param[type=number] latitude 
@param[type=number] longitude
]]

--[[-- Latitude.
 ... is degrees N or S of the equator as 'S 60.20.10' or as +/- as -60.336. The data in the tables is held as a signed number.

@DataType Latitude
]]
Latitude()


--[[-- Longitude.
 ... is degrees E or W of Greenwich line as 'W 60.20.10' or  as +/- as -60.336. The data in the tables is held as a signed number.
@DataType Longitude
]]
Longitude()


--[[-- Altitude.
 ... is the height or depth of a unit.
 The altitude is displayed in meters when accessing the data. It can be set using either meters or feet by adding M or FT after it. The default is M if just a number is used.
@DataType Altitude
@usage {altitude='100 FT'} or {altitude='100 M'} or {altitude='100'}
]]
Altitude()


--[[-- TimeStamp.
 ... is a representation of time defined as the number of seconds that have elapsed since 00:00:00 Coordinated Universal Time (UTC), Thursday, 1 January 1970

@DataType TimeStamp
]]
TimeStamp()


--[[-- KeyStore.
The simulation allows for user data to be stored within the save file. This is done by associating `keys` with `values`.
Key/value pairs added to the persistent store is retained when the game is saved and resumed. Keys and values are both represented as non-nil strings.

@param[type=string] key The key to associate the value with
@param[type=string] value The value to keep
@DataType KeyStore
]]
KeyStore()
--[[-- Stance/Posture.
 ... how one side sees another.

 When setting the value, either the number or the description (in quotes) can be used.
@DataType Stance
 Stance codes:

 <style>
 tr:not(:first-child) { border-top: 1px solid black;}
 td { padding: .5em; }
 </style>
 <table style="border-spacing: 0.5rem;">
 <tr><td>0</td><td>Neutral</td></tr>
 <tr><td>1</td><td>Friendly</td></tr>
 <tr><td>2</td><td>Unfriendly</td></tr>
 <tr><td>3</td><td>Hostile</td></tr>
 <tr><td>4</td><td>Unknown</td></tr>
 </table>

]]
Stance()
--[[-- Size.
 ... various size attributes (eg flightsize in mission).

 When setting the value, either the number or the description (in quotes) can be used.
@DataType Size

 Flight size:
 <style>
 tr { border: 1px solid black;}
 td { padding: .5em; }
 </style>
 <table style="border-spacing: 0.5rem;">
 <tr><td>0</td><td>None*</td></tr>
 <tr><td>1</td><td>SingleAircraft</td></tr>
 <tr><td>2</td><td>TwoAircraft</td></tr>
 <tr><td>3</td><td>ThreeAircraft</td></tr>
 <tr><td>4</td><td>FourAircraft</td></tr>
 <tr><td>6</td><td>SixAircraft</td></tr>
 </table>

 Flight quantity:
 <table style="border-spacing: 0.5rem;">
 <tr><td>0</td><td>None</td></tr>
 <tr><td>1</td><td>Flight_x1</td></tr>
 <tr><td>2</td><td>Flight_x2</td></tr>
 <tr><td>3</td><td>Flight_x3</td></tr>
 <tr><td>4</td><td>Flight_x4</td></tr>
 <tr><td>6</td><td>Flight_x6</td></tr>
 <tr><td>8</td><td>Flight_x8</td></tr>
 <tr><td>12</td><td>Flight_x12</td></tr>
 <tr><td>All</td><td>All</td></tr>
 </table>

 Group size:
 <table style="border-spacing: 0.5rem;">
 <tr><td>0</td><td>None*</td></tr>
 <tr><td>1</td><td>SingleVessel</td></tr>
 <tr><td>2</td><td>TwoVessel</td></tr>
 <tr><td>3</td><td>ThreeVessel</td></tr>
 <tr><td>4</td><td>FourVessel</td></tr>
 <tr><td>6</td><td>SixVessel</td></tr>
 </table>

 *This can also be set by using a value of 'all'.

]]
Size()

--[[-- Select a unit.
 ... based on either the side and name or the unique identifier (GUID).

You can use either
1. `name` and `side`
2. `guid`
If both are given, then the GUID is used preferentially.

@field[type=string] name The name of the unit to select (for option #1)
@field[type=string] side The name of the unit to select (for option #1)
@field[type=string] guid The guid of the unit to select (for option #2)
@Selector UnitSelector
]]


--[[-- Defines the warhead to detonate.


@table Explosion
@param[type=number] warheadid The ID of the warhead to detonate
@param[type=Latitude] lat The latitude of the detonation
@param[type=Longitude] lon The longitude of the detonation
@param[type=Altitude] altitude The altitude of the detonation
@usage {warheadid=253, lat=unit.latitude, lon=unit.longitude, altitude=unit.altitude}
]]


--[[-- Detonates a warhead at a specified location.


@function ScenEdit_AddExplosion
@param[type=Explosion] explosion Describes the explosion.
@usage ScenEdit_AddExplosion ({warheadid=253, lat=unit.latitude, lon=unit.longitude, altitude=unit.altitude})
]]


--[[--
Requests that a unit be hosted to another

@param[type=string] HostedUnitNameOrID The name or GUID of the unit to put into the host
@param[type=string] SelectedHostNameOrID The name or GUID of the host to put the unit into
]]
HostUnit = {
	HostedUnitNameOrID,
	SelectedHostNameOrID
}


--[[--
Hosts a unit to the specified host. The unit will be moved from any location, including flying or hosted elsewhere.

@param[type=HostUnit] host_info The information about the hosting request
]]
function ScenEdit_HostUnitToParent(host_info)end


--[[-- Assign a unit to a mission.

The function takes a unit and mission descriptor, and assigns the unit to the mission if it exists. Produces a pop up
error (not catchable) if the unit or mission does not exist.
The 'UnitX' can be used as the unit descriptor
@param[type=string] unitname The name/GUID of the unit to assign
@param[type=string] mission The mission name/GUID to use
@param[type=bool] escort [Default=False] If the mission is a strike one, then assign unit to the 'Escort' for the strike
@return[type=boolean] True/False for Successful/Failure
@usage ScenEdit_AssignUnitToMission("Bar #1", "Strike")
]]
function ScenEdit_AssignUnitToMission(unitname, mission[, escort]) end


--[[--
Information on a loadout to add/alter

@param[type=string] UnitName The name/GUID of the unit to change the loadout on
@param[type=number] LoadoutID The ID of the new loadout; 0 = use the current loadout
@param[type=number] TimeToReady_Minutes How many minutes until the loadout is ready
@param[type=bool] IgnoreMagazines If the new loadout should rely on the magazines having the right weapons ready
@param[type=bool,opt] ExcludeOptionalWeapons Exclude optional weapons from loadout
]]
LoadoutInfo = {
	UnitName, 
	LoadoutID, 
	TimeToReady_Minutes, 
	IgnoreMagazines,
 ExcludeOptionalWeapons
}


--[[--
Sets the loadout for a unit

@param[type=LoadoutInfo] loadoutinfo The loadout information to apply
@return[type=bool] True
]]
function ScenEdit_SetLoadout(loadoutinfo)end


--[[-- Set the current weather conditions.

This function takes four numbers that describe the desired weather conditions. These
conditions are applied globally.
@param[type=number] temperature The current baseline temperature (in deg C). Varies by latitude.
@param[type=number] rainfall The rainfall rate, 0-50.
@param[type=number] underrain The amount of sky that is covered in cloud, 0.0-1.0
@param[type=number] seastate The current sea state 0-9.
@return[type=boolean] True/False for Successful/Failure
@usage ScenEdit_SetWeather(math.random(0,25), math.random(0,50), math.random(0,10)/10.0, math.random(0,9))
]]
function ScenEdit_SetWeather(temperature, rainfall, underrain, seastate) end


--[[-- Set the posture of a side towards another.

 This will set side A's posture towards side B to the specified posture. This is the same as @{Stance}, but only the first character of the name is used as shown in the table
 
 Posture codes:
 <style>
 tr:not(:first-child) { border-top: 1px solid black;}
 td { padding: .5em; }
 </style>
 <table style="border-spacing: 0.5rem;">
 <tr><td>F</td><td>Friendly</td></tr>
 <tr><td>H</td><td>Hostile</td></tr>
 <tr><td>N</td><td>Neutral</td></tr>
 <tr><td>U</td><td>Unfriendly</td></tr>
 </table>

 @param[type=string] sideAName Side A's name or GUID
 @param[type=string] sideBName Side B's name or GUID
 @param[type=string] posture The posture of side A towards side B
@return[type=boolean] True/False for Successful/Failure
 @usage ScenEdit_SetSidePosture("LuaSideA", "LuaSideB", "H")
]]
function ScenEdit_SetSidePosture(sideAName, sideBName, posture) end


--[[-- Set side options.
 ... AWARENESS and PROFICIENCY.

@function ScenEdit_SetSideOptions(options)
@param[type=SideOptions] options The side items to be changed.
@return[type=Side] The Side object
@usage ScenEdit_SetSideOptions('{side='SideA',awareness='OMNI',PROFICIENCY='ace')
]]

--[[-- Set unit damage.
 ... for components on unit.

@function ScenEdit_SetUnitDamage(options)
@param[DamageOptions] options 
@return[type=Component] The unit's components object
@usage ScenEdit_SetUnitDamage('{side='SideA',unitname='Ship',fires=1,components={{'rudder','medium'},{'type',type='sensor',1}}}')
]]

--[[--
 Sets the EMCON of the selected object. Select the object by specifying the type and the object's name.
 
 Type is the type of object to set the EMCON on. It can be one of 4 values:

 * **Side** - Set an entire side's EMCON (e.g. United States using active radar)
 * **Mission** - Set the EMCON for a mission (e.g. Minesweepers active sonar)
 * **Group** - Set the EMCON for an entire group (e.g Package #20 active radar)
 * **Unit** - Set the EMCON for a single group (e.g. Hornet #14 passive radar)

 emcon is a compound structure. The string follows the following grammar, with each clause separated by a semicolon (;)

 * `Inherit` indicates that the output EMCON should be at least the parent's EMCON. Inherit must come first.
 * A transmitter "set" statement. Each is of the form `type=status`, where type can be any one of `Radar`, `Sonar`, and `OECM`, and status can be any one of `Passive` or `Active`.

 @param[type=string] type The type of the thing to set the EMCON on.
 @param[type=string] name The name or GUID of the object to select.
 @param[type=string] emcon The new EMCON for the object.
 @usage ScenEdit_SetEMCON('Side', 'NATO', 'Radar=Active;Sonar=Passive')
 @usage ScenEdit_SetEMCON('Mission', 'ASW Patrol #1', 'Inherit;Sonar=Active')
 @usage ScenEdit_SetEMCON('Unit', 'Camel 2', 'OECM=Active')
]]
function ScenEdit_SetEMCON(type, name, emcon)end

--[[--
Opens a message box with the given string.

@param[type=string] string The string to display to the user
@param[type=num] style The style of the message box
@return button number.
]]
function ScenEdit_MsgBox(string, style) end


--[[--
Get a given side's score.

@param[type=string] side The name of the side
@return[type=num] The side's score
@usage ScenEdit_GetScore("PlayerSide")
]]
function ScenEdit_GetScore(side)end


--[[--
Gets the posture of one side towards another. 

@param[type=string] sideA The name of the first side
@param[type=string] sideB The name of the second side
@return The posture of sideA towards sideB, one of 'N', 'F', 'H', or 'A'.
]]
function ScenEdit_GetSidePosture(sideA,sideB) end


--[[--
Information to select a particular side. 

@param[type=string] GUID The GUID of the side to select. Preferred.
@param[type=string] Name The name of the side to select.
]]
SideSelector = {
	GUID,
	Name
}


--[[-- Get side options.
 ... for components on unit.

@function ScenEdit_GetSideOptions(options)
@param[DamageOptions] options 
@return[type=SideOption] The side options
@usage ScenEdit_GetSideOptions({side='SideA'})
]]

--[[--
Returns true if side is played by a human player

@param[type=string] sidename The name of the side to check if is human controlled
@return True iff the side specified is human
]]
function ScenEdit_GetSideIsHuman(sidename)end


--[[--
Sets a given side's score.

@param[type=string] side The name/GUID of the side
@param[type=num] score The new score for the side
@param[type=string] reason The reason for the score to change
@return[type=num] The new score for the side
@usage ScenEdit_GetScore("PlayerSide", 20)
]]
function ScenEdit_SetScore(side,score,reason) end


--[[--
	Displays a special message consisting of the HTML text `message` to side `side.

@param[type=string] side The side name/guid to display the message on
@param[type=string] message The HTML text to display to the player
]]
function ScenEdit_SpecialMessage(side, message) end

--[[-- New unit selector.

 ... lists minimum fields required. Other fields from @{Unit} may be included.

@Selector NewUnit
@field[type=string] type The type of unit (Ship, Sub, Aircraft, Facility)
@field[type=string] unitname The name of the unit 
@field[type=string] side The side name or GUID to add unit to
@field[type=number] dbid The database id of the unit
@field[type=Latitude] latitude Not required if a `base` is defined
@field[type=Longitude] longitude Not required if a `base` is defined
@field[type=string] base Unit base name or GUID where the unit will be 'hosted' (applicable to AIR, SHIP, SUB)
@field[type=number] loadout Aircraft database loadout id (applicable to AIR)
@field[type=number] altitude Unit altitude (applicable to AIR)
]]

--[[--
Adds a unit based on a descriptor.

@param[type=NewUnit] unit The unit details to add
@return[type=Unit] A complete descriptor for the added unit
@usage ScenEdit_AddUnit({type = 'Aircraft', name = 'F-15C Eagle', loadoutid = 16934, 
 heading = 0, dbid = 3500, side = 'NATO', Latitude="N46.00.00",Longitude="E25.00.00",
 altitude="5000 ft",autodetectable="false",holdfire="true",proficiency=4})
@usage ScenEdit_AddUnit({type = 'Air', unitname = 'F-15C Eagle', loadoutid = 16934, dbid = 3500, side = 'NATO', Lat="5.123",Lon="-12.51",alt=5000})

]]
function ScenEdit_AddUnit(unit)end


--[[--
Fetches a unit based on a selector.

This function is mostly identical to @{ScenEdit_SetUnit} except that if no unit is selected by the selector portion of `unit`, 
then the function returns nil instead of producing an exception.

@param[type=UnitSelector] unit The unit to select.
@return[type=Unit] A complete unit descriptor if the unit exists or nil otherwise.
@usage ScenEdit_GetUnit({side="United States", unitname="USS Test"})
]]
function ScenEdit_GetUnit(unit)end

--[[--
Sets the properties of a unit that already exists.

@param[type=Unit] unit The unit to edit. Must be at least a selector.
@return[type=Unit] A complete descriptor for the added unit
@usage ScenEdit_SetUnit({side="United States", unitname="USS Test", lat = 5})
@usage ScenEdit_SetUnit({side="United States", unitname="USS Test", lat = 5})
@usage ScenEdit_SetUnit({side="United States", unitname="USS Test", lat = 5, lon = "N50.20.10"})
@usage ScenEdit_SetUnit({side="United States", unitname="USS Test", newname="USS Barack Obama"})
@usage ScenEdit_SetUnit({side="United States", unitname="USS Test", heading=0, HoldPosition=1, HoldFire=1,Proficiency="Ace", Autodetectable="yes"})
]]
function ScenEdit_SetUnit(unit)end


--[[-- Deletes unit.
 .. and no event triggers.
@param[UnitSelector] unit 
@usage ScenEdit_DeleteUnit({side="United States", unitname="USS Abcd"})
]]
function ScenEdit_DeleteUnit(unit)end


--[[-- Kill unit.
 ... and triggers event.

@function ScenEdit_KillUnit(unit)
@param[UnitSelector] unit 
@return[type=bool] True if successful
@usage ScenEdit_KillUnit({side='SideA',unitname='ship'})
]]

--[[--
Information on how to change a unit's side. ORDER IS IMPORTANT

@param[type=string] side The original side
@param[type=string] name The name/GUID of the unit
@param[type=string] newside The new side
]]
SideDescription = {
	side,
	name,
	newside
}


--[[--
Changes the side of a unit

@param[type=SideDescription] sidedesc The description of how to change the unit's side
]]
function ScenEdit_SetUnitSide(sidedesc) end


--[[-- Select mount and weapon.

 You can specify a particular `mount` by the GUID, or leave it out, 
 and the function will try to fill up any `available` space with the `weapon`.
@Selector Weapon2Mount
@param[type=string] *side The side name/GUID of the unit with mount
@param[type=string] *unitname The name/GUID of unit with mount
@param[type=string] *guid GUID of the unit with mount
@param[type=string] mount_guid The mount GUID
@param[type=string] wpn_dbid The weapon database ID
@param[type=number] number Number to add
@param[type=bool] remove If true, this will debuct the number of weapons
@param[type=bool] fillout If true, will fill out the weapon record to its maximum
]]

--[[-- Adds weapons into a mount.

@function ScenEdit_AddReloadsToUnit
@param[type=Weapon2Mount] descriptor Describes the weapon and mount to update
@return[type=number] Number of items added to the magazine
@usage ScenEdit_AddReloadsToUnit({unitname='Mech Inf #1', w_dbid=773, number=1, w_max=10})
]]


--[[-- Select magazine and weapon.

 A group magazine, for example, tend to have multiple magazines, with the same name. So you can specify a particular `magazine` by the GUID, or leave it out, 
 and the function will try to fill up any `available` space with the `weapon`.
@Selector Weapon2Magazine
@param[type=string] *side The side name/GUID of the unit with magazine
@param[type=string] *unitname The name/GUID of unit with magazine
@param[type=string] *guid GUID of the unit with magazine
@param[type=string] mag_guid The magazine GUID
@param[type=string] wpn_dbid The weapon database ID
@param[type=number] number Number to add
@param[type=number] maxcap Maximum capacity of the weapon to store
@param[type=bool] remove If true, this will debuct the number of weapons
@param[type=bool] new If true, will add the weapon if it does not exist
@param[type=bool] fillout If true, will fill out the weapon record to its maximum
]]


--[[-- Adds weapons into a magazine.

@param[type=Weapon2Magazine] descriptor Describes the weapon and magazine to update
@return[type=number] Number of items added to the magazine
@usage ScenEdit_AddWeaponToUnitMagazine({unitname='Ammo', w_dbid=773, number=1, w_max=10})
]]
function ScenEdit_AddWeaponToUnitMagazine(descriptor)

--[[--
]]

--[[-- Unit refueling options.

@Wrapper RefuelOptions
@field[type=UnitSelector] unitSelector A normal unit selector defining the unit.
@field[type=string] tanker A specific tanker defined by its name (side is assumed to be the same as unit) or GUID.
@field[type={ mission } ] missions A table of mission names or mission GUIDs.
@usage {side="United States", name="USS Test", missions={"Pitstop"}, tanker="Hose #1"}
]]


--[[-- Cause unit to refuel.

 The unit should follow it's AAR configuration. You can force it use a specific tanker or ones from a set of missions.

@function ScenEdit_RefuelUnit
@param[type=RefuelOptions] unitOptions The unit and refueling options.
@return[type=String] If successful, then empty string. Else message showing why it failed to
@usage ScenEdit_RefuelUnit({side="United States", unitname="USS Test"})
@usage ScenEdit_RefuelUnit({side="United States", unitname="USS Test", tanker="Hose #1"})
@usage ScenEdit_RefuelUnit({side="United States", unitname="USS Test", missions={"Pitstop"}})
]]


--[[-- Get unit details 

This will get the information about an active unit or a contact unit
@param[type=UnitSelector] ActiveOrContact The unit selector to interrogate
@return[type=Unit] The information associated with the unit
]]
function VP_GetUnit(ActiveOrContact) end


--[[-- Contact selector.

Used to select a contact.

Note that a unit and it's contact GUIDs are different for the same physical unit; the contact GUIDs are from the other side's perspective
@Selector ContactSelector
@field[type=string] guid The GUID of the contact. Interrogate VP_GetSide().contacts for the side's contacts and use the GUID from there. 
@usage
 local vp = VP_GetSide({name = "NATO"})
 local cp = vp.contacts --List Of contacts
 local guid = cp[12].objectid -- a specific contact
 local contact = VP_GetContact({guid=guid}) -- details of contact as distinct to unit details
]]
ContactSelector = {
	guid
}


--[[-- Get contact details 

This will get the information about a contact unit

@param[type=ContactSelector] ContactGUID The contact selector to interrogate
@return[type=Contact] The information associated with the contact
]]
function VP_GetContact(ContactGUID) end


--[[-- Side information from player's perspective.

Gets a side object from the perspective of the player.

@param[type=SideSelector] side The side to get information about.
@return[type=SideInfo] Information about the side selected, from the perspective of the player.
]]
function VP_GetSide(side) end


--[[--
	Returns the elevation in meters of a given position

@param[type=Point] location The position to find the elevation of
@return The elevation of the point in meters
]]
function World_GetElevation(location) end


--[[--
	Returns a circle around point.

@param[type=Point] table 
@return Tabe of points
]]
function World_GetCircleFromPoint(table) end


--[[-- The Unit that fired the current event trigger.
Otherwise, a nil is returned.

@return[type=Unit] The triggering unit
@usage local unit = ScenEdit_UnitX()
]]
function ScenEdit_UnitX() end


--[[-- Get the current scenario time.
@return[type=TimeStamp] The UTC Unix timestamp of the current time in-game.
@usage local now = ScenEdit_CurrentTime()
 local elapsed = now - timeFromLastTiggered
 if elapsed > 60*5 then
 -- been more than 5 minutes, set the lastTriggered time to now
  timeFromLastTiggered = now 
 end
]]
function ScenEdit_CurrentTime() end


--[[-- Name of the scenario.

@return[type=string] The title of the scenario
@function GetScenarioTitle
]]



--[[-- Runs a script from a file.
The file `script` must be inside the [Command base directory]/Lua directory, or else the game will not be able to load it.
You can make the file point to files within a sub-directory of this, as in 'library/cklib.lua'
The file to find will be of the form [Command base directory]/Lua/[`script`]

@todo Running scripts that are scenario attachments from their local location

@param script The file containing the script to run. 
@usage ScenEdit_RunScript('cklib.lua')
]]
function ScenEdit_RunScript(script)end


--[[-- Sets the value for a key in the persistent key store.
 
This function allows you to add values, associated with keys, to a persistent store @{KeyStore} that is retained when the game is saved and resumed. Keys and values are both represented as non-nil strings.
The value is retrieved by @{ScenEdit_GetKeyValue}.

@param[type=string] key The key to associate with
@param[type=string] value The value to associate
@usage ScenEdit_SetKeyValue("A","B")
ScenEdit_GetKeyValue("A") -- returns "B"
]]
function ScenEdit_SetKeyValue(key, value) end


--[[-- Gets the value for a key from the persistent key store.

This function retrieves a value put into the store by @{ScenEdit_SetKeyValue}. The keys must be identical.

@param[type=string] key The key to fetch the associated value of
@return[type=string] The value associated with the key. "" if none exists.
@usage ScenEdit_SetKeyValue("A","2")
ScenEdit_GetKeyValue("A") -- returns "2"
]]
function ScenEdit_GetKeyValue(key) end


--[[-- Has the scenario started?

@return[type=bool] True if the scenario has started
@usage local state = ScenEdit_GetScenHasStarted()
]]
function ScenEdit_GetScenHasStarted() end


--[[-- The player's current side.

@return[type=string] The name of the current side
@usage local side = ScenEdit_PlayerSide()
]]
function ScenEdit_PlayerSide() end

--[[-- Ends the current scenario.

@usage ScenEdit_EndScenario()
]]
function ScenEdit_EndScenario() end


--[[-- Magazine.

 Note that when dealing with a magazine in a unit, it may constist of one or more actual magazine 'blocks'. 
 This is what is being referred to here, rather than the ONE magazine group for the unit/group.

@table Magazine
 @field[type=string] mag_capacity  Capacity|Storage
 @field[type=string] mag_dbid Database ID
 @field[type=string] mag_guid GUID
 @field[type=string] mag_name Name
 @field[type={ WeaponLoaded }] mag_weapons Table of weapon loads in magazine
]]

--[[-- Mount.

 A mount is similar to a magazine, but it refers to the actual `loads` on the `weapon`, rather than a stoarge area.

@table Mount
 @field[type=string] mount_dbid Database ID
 @field[type=string] mount_guid GUID
 @field[type=string] mount_name Name
 @field[type={ WeaponLoaded }] mount_weapons Table of weapon loads on mount
]]

--[[-- Weapon loads on mount or in magazine.

@table WeaponLoaded
 @field[type=string]wpn_guid GUID
 @field[type=string]wpn_current Current loads available
 @field[type=string]wpn_maxcap Maximum loads 
 @field[type=string]wpn_default Default loads (to fill out)
 @field[type=string]wpn_dbid Database ID
 @field[type=string]wpn_name Name
]]

--[[-- Component.

 This identifies the component/item(s) that are present in a unit.
@table Component
@field[type=string] comp_guid GUID
@field[type=string] comp_dbid Database ID
@field[type=string] comp_name Name
@field[type=string] comp_type Type of component (list ?? sensor, rudder, etc)
@field[type=string] comp_status Status
@field[type=string] comp_damage Damage Severity

]]

--[[-- Represents a active unit.

@Wrapper Unit
@field[type=string] type  The type of object, may be 'Facility', 'Ship', 'Submarine', or 'Aircraft'.[READONLY]
@field[type=string] name The unit's name.
@field[type=string] side  The unit's side. [READONLY]
@field[type=string] guid  The unit's unique ID.  [READONLY]
@field[type=string] subtype  The unit's subtype (if applicable). [READONLY]
@field[type=Unit] base  The unit's assigned base. [READONLY]
@field[type=Latitude] latitude The latitude of the unit.
@field[type=Longitude] longitude The longitude of the unit .
@field[type=number] DBID  The database ID of the unit  [READONLY]
@field[type=number] altitude The altitude of the unit in meters.
@field[type=number] speed The unit's current speed.
@field[type=Throttle] throttle The unit's current throttle setting.
@field[type=bool] autodetectable True if the unit is automatically detected.
@field[type=bool] holdposition True if the unit should hold.
@field[type=bool] holdfire True if the unit should not fire .
@field[type=number] heading The unit's heading .
@field[type=string] proficiency The unit proficiency, "Novice"|0, "Cadet"|1,"Regular"|2, "Veteran"|3, "Ace"|4.
@field[type=string] newname If changing existing unit, the unit's new name .
@field[type={ LatLon }] course The unit's course, as a table of lat/lon pairs
@field[type=bool] RTB Trigger the unit to return to base
@field[type={ Fuel }] fuel A table of fuel types used by unit.
@field[type=Mission] mission The unit's assigned mission. Can be changed by setting to the Mission name or guid (calls ScenEdit_AssignUnitToMission)
@field[type=Group] group The unit's group (if applicable). Can be changed assigning an existing or new name. It will try to create a group if new (experimental)
@field[type=number]  airbornetime  how long aircraft has been flying. [READONLY]
@field[type=number]  loadoutdbid  current aircraft loadout DBID. [READONLY]
@field[type=string] unitstate Message on unit status. [READONLY]
@field[type=string] fuelstate  Message on unit fuel status. [READONLY]
@field[type=string]  weaponstate  Message on unit weapon status. [READONLY]
@field[type=number]  manualSpeed  Manual desired speed. [READONLY]
@field[type=bool]  manualAlitude  Manual altiude. [READONLY]
@field[type={ Magazine }]  magazines  A table of magazines (with weapon loads) in the unit or group. Can be updated by @{ScenEdit_AddWeaponToUnitMagazine} [READONLY]
@field[type={ Mount }]  mounts  A table of mounts (with weapon loads) in the unit or group. Can be updated by @{ScenEdit_AddReloadsToUnit} [READONLY]
@field[type={ Component }]  components  A table of components on the unit.  [READONLY]
@field[type=bool] refuel Trigger the unit to attempt an UNREP
@field[type=method] delete() Immediately removes unit object
@field[type=method] filterOnComponent(`type`) Filters unit on `type` of component and returns a @{Component} table. 
    
]]


--[[-- Fuel.

 The various types of fuel(s), and their state, carried by the unit.
 This entire table should be replaced as one list; to update a unit's fuel, see the example.

Fuel Types:

<style>
tr:not(:first-child) { border-top: 1px solid black;}
td { padding: .5em; }
</style>
<table style="border-spacing: 0.5rem;">
<tr><td>1001</td><td>'no fuel'</td></tr>
<tr><td>2001</td><td>aviation fuel</td></tr>
<tr><td>3001</td><td>diesel fuel</td></tr>
<tr><td>3002</td><td>oil fuel</td></tr>
<tr><td>3003</td><td>gas fuel</td></tr>
<tr><td>4001</td><td>battery life</td></tr>
<tr><td>4002</td><td>AIP</td></tr>
<tr><td>5001</td><td>rocket fuel</td></tr>
<tr><td>5002</td><td>torpedo fuel</td></tr>
<tr><td>5003</td><td>weapon coast</td></tr>
</table>
@table Fuel
@field[type={ FuelState }] fueltype The state of the type(s) of fuel in the unit. 
@usage local fuel = u.fuel
       fuel[3001].current = 400
       u.fuel = fuel
]]

--[[-- Status of a fuel `type`.

@table FuelState
@field[type=number] current The current fuel level of the type
@field[type=number] max How much can be stored for the type
@field[type=string] name Name of the fuel
@usage local fuel = u.fuel
       fuel[3001].current = 400
       u.fuel = fuel
]]


--[[-- Contact details. 

 This is from the perspective of the side being looked at. What is a contact for one side, may not be the same contact on another side.
 Note also the GUID of the contact is not the same as the actual unit. So depending on what functions you call, you may need to 
 'convert' the contact 'GUID' into the actual 'GUID' and call GetUnit() to process the actual GUID.
@Wrapper Contact
@field[type=string] name The contact name.
@field[type=string] guid The contact GUID. {READONLY]
@field[type=string] actualunitid The contact actual GUID. [READONLY]
@field[type=Latitude] latitude The latitude of the contact. [READONLY]
@field[type=Longitude] longitude The longitude of the contact. [READONLY]
@field[type=string] posture Posture towards contact.
@field[type=string] type Type of contact. [READONLY]
@field[type=number] typed Type of contact. [READONLY]
@field[type={ LatLon }] areaofuncertainty Table of points defining the area of contact. [READONLY]
@field[type=string] type_description Contact type description. [READONLY]
@field[type=number] actualunitdbid Actual contact type. [READONLY]
@field[type=string] classificationlevel Contact classification. [READONLY]
@field[type={ numbers }]  potentialmatches Table {DBID} on potential EMCON emission matches. [READONLY] 
]]


--[[-- Group details. 

@Wrapper Group
@field[type=string] type Type of group. [READONLY]
@field[type=string] guid [READONLY]
@field[type=string] name 
@field[type=string] side [READONLY]
@field[type={ string }] unitlist Table of unit GUIDs in the group. [READONLY]
]]

 
--[[-- Mission.
 

@Wrapper Mission
@field[type=string] guid The GUID of the mission. [READONLY]
@field[type=string] name Name of mission
@field[type=bool] isactive True if mission is currently active
@field[type=string] side Mission belongs to side
@field[type=DateTime] starttime Time mission starts
@field[type=DateTime] endtime Time mission ends
@field[type=MissionClass] type Mission class(patrol,strike,etc). [READONLY]
@field[type=MissionSubClass] subtype Mission class(asw,land,etc). [READONLY]
@field[type=bool] SISH 'Scrub if side human' tick box
@field[type={ GUID }] unitlist A table of units assigned to mission. [READONLY]
@field[type={ GUID }] targetlist A table of targets assigned to mission. [READONLY]
@field[type=AAR] aar A table of the mission air-to-air refueling options. [READONLY]
@field[type=FerryMission] ferrymission A table of the mission specific options. [READONLY]
@field[type=MineClearMission] mineclearmission A table of the mission specific options. [READONLY]
@field[type=MineMission] minemission A table of the mission specific options. [READONLY]
@field[type=SupportMission] supportmission A table of the mission specific options. [READONLY]
@field[type=PatrolMission] patrolmission A table of the mission specific options. [READONLY]
@field[type=StrikeMission] strikemission A table of the mission specific options. [READONLY]
@field[type=CargoMission] cargomission A table of the mission specific options. [READONLY]
]]

--[[-- AAR.
 .. refueling options; these are updated by ScenEdit_SetMission()
 
@table AAR
@field[type=string] use_refuel_unrep This is same as the one from Doctrine setting
@field[type=string|number] tankerUsage Automatic(0), Mission(1)
@field[type=bool] launchMissionWithoutTankersInPlace
@field[type={ mission name|guid }] tankerMissionList Table of missions to use as source of refuellers
@field[type=number] tankerMinNumber_total
@field[type=number] tankerMinNumber_airborne
@field[type=number] tankerMinNumber_station
@field[type=number] maxReceiversInQueuePerTanker_airborne
@field[type=number] fuelQtyToStartLookingForTanker_airborne Percentage of fuel (0-100)
@field[type=string|number] tankerMaxDistance_airborne Use 'internal' or set a range. The code will match the lowest availble setting
]]

--[[-- FerryMission.
  .. options; these are updated by ScenEdit_SetMission()
 
@table FerryMission
@field[type=string] ferryBehavior Values OneWay(0), Cycle(1), Random(2)
@field[type=string] ferryThrottleAircraft
@field[type=string] ferryAltitudeAircraft
@field[type=bool] ferryTerrainFollowingAircraft
@field[type=Size] flightSize
@field[type=string] minAircraftReq
@field[type=bool] useFlightSize
]]

--[[-- MineClearMission.
  .. options; these are updated by ScenEdit_SetMission()
 
@table MineClearMission
@field[type=bool] oneThirdRule
@field[type=string] transitThrottleAircraft
@field[type=string] transitAltitudeAircraft
@field[type=bool] transitTerrainFollowingAircraft
@field[type=string] stationThrottleAircraft
@field[type=string] stationAltitudeAircraft
@field[type=bool] stationTerrainFollowingAircraft
@field[type=string] transitThrottleSubmarine
@field[type=string] transitDepthSubmarine
@field[type=string] stationThrottleSubmarine
@field[type=string] stationDepthSubmarine
@field[type=string] transitThrottleShip
@field[type=string] stationThrottleShip
@field[type=Size] flightSize
@field[type=string] minAircraftReq
@field[type=bool] useFlightSize
@field[type=Size] groupSize
@field[type=bool] useGroupSize
@field[type={ name|guid }] zone Table of reference point names and/or guids
]]

--[[-- MineMission.
  .. options; these are updated by ScenEdit_SetMission()
 
@table MineMission
@field[type=bool] oneThirdRule
@field[type=string] transitThrottleAircraft
@field[type=string] transitAltitudeAircraft
@field[type=bool] transitTerrainFollowingAircraft
@field[type=string] stationThrottleAircraft
@field[type=string] stationAltitudeAircraft
@field[type=bool] stationTerrainFollowingAircraft
@field[type=string] transitThrottleSubmarine
@field[type=string] transitDepthSubmarine
@field[type=string] stationThrottleSubmarine
@field[type=string] stationDepthSubmarine
@field[type=string] transitThrottleShip
@field[type=string] stationThrottleShip
@field[type=Size] flightSize
@field[type=string] minaircraftreq
@field[type=bool] useFlightSize
@field[type=Size] groupSize
@field[type=bool] useGroupSize
@field[type={ name|guid }] zone Table of reference point names and/or guids
@field[type=time] armingdelay In format of 'days:hours:minutes:seconds' e.g. 1 day, 4 hours, 30 minutes would be '1:4:30:0'
]]

--[[-- SupportMission.
  .. options; these are updated by ScenEdit_SetMission()
 
@table SupportMission
@field[type=bool] oneThirdRule
@field[type=string] transitThrottleAircraft
@field[type=string]  transitAltitudeAircraft
@field[type=bool]  transitTerrainFollowingAircraft
@field[type=string] stationThrottleAircraft
@field[type=string]  stationAltitudeAircraft
@field[type=bool]  stationTerrainFollowingAircraft
@field[type=string] transitThrottleSubmarine
@field[type=string]  transitDepthSubmarine
@field[type=string]  stationThrottleSubmarine
@field[type=string] stationDepthSubmarine
@field[type=string] transitThrottleShip
@field[type=string] stationThrottleShip
@field[type=Size] flightSize
@field[type=string] minAircraftReq
@field[type=boo] useFlightSize
@field[type=Size] groupSize
@field[type=bool] useGroupSize
@field[type={ name|guid}] zone Table of reference point names and/or guids
@field[type=string] loopType Values of ContinousLoop(0) or SingleLoop(1)
@field[type=string] onStation
@field[type=bool] oneTimeOnly
@field[type=bool] activeEMCON
@field[type=bool] tankerOneTime
@field[type=string] tankerMaxReceivers
]]

--[[-- PatrolMission.
  .. options; these are updated by ScenEdit_SetMission()
 
@table PatrolMission
@field[type=bool] oneThirdRule True if activated
@field[type=bool] checkOPA True if can investigate outside zones
@field[type=bool] checkWWR True if can investigate within weapon range
@field[type=bool] activeEMCON  True if active EMCON in patrol zone
@field[type=string] transitThrottleAircraft
@field[type=string] transitAltitudeAircraft
@field[type=bool] transitTerrainFollowingAircraft True if terrain following
@field[type=string] stationThrottleAircraft
@field[type=string] stationAltitudeAircraft
@field[type=bool] stationTerrainFollowingAircraft True if terrain following
@field[type=string] attackThrottleAircraft
@field[type=string] attackAltitudeAircraft
@field[type=bool] attackTerrainFollowingAircraft True if terrain following
@field[type=string] attackDistanceAircraft
@field[type=string] transitThrottleSubmarine
@field[type=string] transitDepthSubmarine
@field[type=string] stationThrottleSubmarine
@field[type=string] stationDepthSubmarine
@field[type=string] attackThrottleSubmarine
@field[type=string] attackDepthSubmarine
@field[type=string] attackDistanceSubmarine
@field[type=string] transitThrottleShip
@field[type=string] stationThrottleShip
@field[type=string] attackThrottleShip
@field[type=string] attackDistanceShip
@field[type=Size] flightSize
@field[type=string] minAircraftReq
@field[type=bool] useFlightSize True if min size required
@field[type=Size] groupSize
@field[type=bool] useGroupSize True if min size required
@field[type={ name|guid }] prosecutionZone Table of reference point names and/or GUIDs
@field[type={ name|guid }] patrolZone  Table of reference point names and/or GUIDs
]]

--[[-- StrikeMission.
  .. options; these are updated by ScenEdit_SetMission(). Note that these are split between the escorts and strikers
 
@table StrikeMission
@field[type=Size] escortFlightSizeShooter 
@field[type=number] escortMinShooter
@field[type=number] escortMaxShooter
@field[type=number] escortResponseRadius
@field[type=bool] escortUseFlightSize True if minimum size required
@field[type=Size] escortFlightSizeNonshooter
@field[type=number] escortMinNonshooter
@field[type=number] escortMaxNonshooter
@field[type=Size] escortGroupSize
@field[type=bool] escortUseGroupSize  True if minimum size required
@field[type=bool] strikeOneTimeOnly True if activated
@field[type=string] strikeMinimumTrigger
@field[type=number] strikeMax
@field[type=Size] strikeFlightSize
@field[type=number] strikeMinAircraftReq
@field[type=bool] strikeUseFlightSize True if minimum size required
@field[type=Size] strikeGroupSize
@field[type=bool] strikeUseGroupSize True if minimum size required
@field[type=bool] strikeAutoPlanner True if activated
@field[type=bool] strikePreplan True if pre-planned target list only
]]

--[[-- CargoMission.
 .. options; these are updated by ScenEdit_SetMission()
 
@table CargoMission
@field[type=bool] oneThirdRule  True if activated
@field[type=string] transitThrottleAircraft
@field[type=string]  transitAltitudeAircraft
@field[type=string] stationThrottleAircraft
@field[type=string]  stationAltitudeAircraft
@field[type=string] transitThrottleSubmarine
@field[type=string]  transitDepthSubmarine
@field[type=string]  stationThrottleSubmarine
@field[type=string]  stationDepthSubmarine
@field[type=string] transitThrottleShip
@field[type=string]  stationThrottleShip
@field[type=bool]  useFlightSize  True if minimum size required
@field[type=bool]  useGroupSize True if minimum size required
@field[type={ name|guid }] zone Table of reference point names and/or GUIDs
]]

--[[-- DateTime.
 ... is displayed and changed as per LOCALE e.g. US would be 'MM/DD/YYYY HH:MM:SS AM/PM' eg '8/13/2002 12:14 PM'
 
@DataType DateTime
]]

--[[-- Reference point information.


@Wrapper ReferencePoint
@field[type=string] guid The unique identifier for the reference point
@field[type=string] side The side the reference point is visible to
@field[type=string] name The name of the reference point
@field[type=Latitude] latitude The latitude of the reference point
@field[type=Longitude] longitude The longitude of the reference point
@field[type=bool] highlighted True if the point should be selected
@field[type=bool] locked True if the point is locked
@field[type=bearing] bearingtype Type of bearing Fixed (0) or Rotating (1)
@field[type=Unit] relativeto The unit that reference point is realtive to
]]


--[[-- Side perspective.

@Wrapper Side
@param[type=string] guid The GUID of the side.
@param[type=string] name The name of the side.
@param[type={ SideUnit } ] units Table of units for the designated side. [READONLY]
@param[type={ SideContact } ] contacts Table of current contacts for the designated side. [READONLY]
@param[type={ Zone } ] exclusionzones Zones for the designated side [READONLY]
@param[type={ Zone } ] nonavzones  Zones for the designated side [READONLY]
@param[type=Awareness] awareness [READONLY]
@param[type=Proficiency] proficiency [READONLY]
@param[type=method] getexclusionzone(`ZoneGUID|ZoneName|ZoneDescription`) Returns matching @{Zone} or nil
@param[type=method] getnonavzone(`ZoneGUID|ZoneName|ZoneDescription`) Returns matching @{Zone} or nil

]]

--[[-- Side's unit.

@table SideUnit
@param[type=string] guid The GUID of the unit. This is the actual guid.
@param[type=string] name The name of the unit.
]]

--[[-- Side's contact.

@table SideContact
@param[type=string] guid The GUID of the contact. Note that this is not the GUID of the unit, you must use VP_GetUnit to resolve it.
@param[type=string] name The name of the contact.
]]

 
--[[-- Exclusion/No navigatation zone.
 

@Wrapper Zone
@field[type=string] guid The GUID of the zone. [READONLY]
@field[type=bool] isactive Zone is currently active.
@field[type=string] name The name of the zone.
@field[type=string] description The description of the zone.
@field[type={ ZoneMarker }] area A set of reference points marking the zone. [READONLY]
]]

--[[-- Zone marker.
 
@table ZoneMarker
@field[type=string] guid The GUID of the Reference Point.
@field[type=Longitude] longitude 
@field[type=Latitude] latitude 
]]

