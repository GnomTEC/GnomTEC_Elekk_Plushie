-- **********************************************************************
-- GnomTEC Elekk Plushie
-- Version: 8.2.0.1
-- Author: Peter Jack
-- URL: http://www.gnomtec.de/
-- **********************************************************************
-- Copyright © 2019 by Peter Jack
--
-- Licensed under the EUPL, Version 1.1 only (the "Licence");
-- You may not use this work except in compliance with the Licence.
-- You may obtain a copy of the Licence at:
--
-- http://ec.europa.eu/idabc/eupl5
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the Licence is distributed on an "AS IS" basis,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the Licence for the specific language governing permissions and
-- limitations under the Licence.
-- **********************************************************************
-- load localization first.
local L = LibStub("AceLocale-3.0"):GetLocale("GnomTEC_Elekk_Plushie")

-- ----------------------------------------------------------------------
-- Addon Info Constants (local)
-- ----------------------------------------------------------------------
-- addonInfo for addon registration to GnomTEC API
local addonInfo = {
	["Name"] = "GnomTEC Elekk Plushie",
	["Description"] = L["L_DESCRIPTION"],	
	["Version"] = "8.2.0.1",
	["Date"] = "2019-06-26",
	["Author"] = "Peter Jack",
	["Email"] = "info@gnomtec.de",
	["Website"] = "http://www.gnomtec.de/",
	["Copyright"] = "© 2019 by Peter Jack",
	["License"] = "European Union Public Licence (EUPL v.1.1)",	
	["FrameworkRevision"] = 13
}

-- ----------------------------------------------------------------------
-- Addon Global Constants (local)
-- ----------------------------------------------------------------------
-- Class levels
local CLASS_BASE		= 0
local CLASS_CLASS		= 1
local CLASS_WIDGET		= 2
local CLASS_ADDON		= 3

-- Log levels
local LOG_FATAL 	= 0
local LOG_ERROR		= 1
local LOG_WARN		= 2
local LOG_INFO 		= 3
local LOG_DEBUG 	= 4

-- ----------------------------------------------------------------------
-- Addon Static Variables (local)
-- ----------------------------------------------------------------------
local addonDataObject =	{
	type = "data source",
	text = "0 warnings",
	value = "0",
	suffix = "warning(s)",
	label = "GnomTEC Elekk Plushie",
	icon = [[Interface\Icons\INV_tailoring_Elekkplushie]],
	OnClick = function(self, button)
		GnomTEC_Elekk_Plushie.SwitchMainWindow()
	end,
	OnTooltipShow = function(tooltip)
		GnomTEC_Elekk_Plushie.ShowAddonTooltip(tooltip)
	end,
}

-- default data for addon database
local defaultsDb = {
	char =
	{
		["General.Mouseover"] = true,
		["General.ShowMinimapIcon"] = true,		
	},
	profile = {
		["Tab1.Name"] = "",	
		["Tab1.Title"] = "",	
		["Tab1.Content"] = "",	
		["Tab2.Name"] = "",	
		["Tab2.Title"] = "",	
		["Tab2.Content"] = "",	
		["Tab3.Name"] = "",	
		["Tab3.Title"] = "",	
		["Tab3.Content"] = "",	
		["Tab4.Name"] = "",	
		["Tab4.Title"] = "",	
		["Tab4.Content"] = "",	
		["Tab5.Name"] = "",	
		["Tab5.Title"] = "",	
		["Tab5.Content"] = "",	
	},
}

-- Main options menue with general addon information
local optionsArray = {
	{
		name = L["L_OPTIONS_GENERAL"],
		type = "group",
		args = {
			elekkplushieOptionMouseover = {
				type = "toggle",
				name = L["L_OPTIONS_GENERAL_MOUSEOVER"],
				desc = "",
				set = function(info,val) GnomTEC_Elekk_Plushie.SetOption("General.Mouseover",val) end,
				get = function(info) return GnomTEC_Elekk_Plushie.GetOption("General.Mouseover") end,
				width = 'full',
				order = 1
			},
			elekkplushieOptionShowMinimapIcon = {
				type = "toggle",
				name = L["L_OPTIONS_GENERAL_SHOWMINIMAPICON"],
				desc = "",
				set = function(info,val) GnomTEC_Elekk_Plushie.SetOption("General.ShowMinimapIcon", val) end,
				get = function(info) return GnomTEC_Elekk_Plushie.GetOption("General.ShowMinimapIcon") end,
				width = 'full',
				order = 2
			},
		}
	},
	{
		name = L["L_OPTIONS_TAB1"],
		type = 'group',
		args = {
			elekkplushieTab1Name = {
				type = "input",
				name = L["L_OPTIONS_TAB1_NAME"],
				desc = "",
				set = function(info,val) GnomTEC_Elekk_Plushie.SetOption("Tab1.Name", val) end,
				get = function(info) return GnomTEC_Elekk_Plushie.GetOption("Tab1.Name") end,
				multiline = false,
				width = 'full',
				order = 1
			},
			elekkplushieTab1Title = {
				type = "input",
				name = L["L_OPTIONS_TAB1_TITLE"],
				desc = "",
				set = function(info,val) GnomTEC_Elekk_Plushie.SetOption("Tab1.Title", val) end,
				get = function(info) return GnomTEC_Elekk_Plushie.GetOption("Tab1.Title") end,
				multiline = false,
				width = 'full',
				order = 2
			},
			elekkplushieTab1Content = {
				type = "input",
				name = L["L_OPTIONS_TAB1_CONTENT"],
				desc = "",
				set = function(info,val) GnomTEC_Elekk_Plushie.SetOption("Tab1.Content", val) end,
				get = function(info) return GnomTEC_Elekk_Plushie.GetOption("Tab1.Content") end,
				multiline = 20,
				width = 'full',
				order = 3
			}
		},
	},
	{
		name = L["L_OPTIONS_TAB2"],
		type = 'group',
		args = {
			elekkplushieTab2Name = {
				type = "input",
				name = L["L_OPTIONS_TAB2_NAME"],
				desc = "",
				set = function(info,val) GnomTEC_Elekk_Plushie.SetOption("Tab2.Name", val) end,
				get = function(info) return GnomTEC_Elekk_Plushie.GetOption("Tab2.Name") end,
				multiline = false,
				width = 'full',
				order = 1
			},
			elekkplushieTab2Title = {
				type = "input",
				name = L["L_OPTIONS_TAB2_TITLE"],
				desc = "",
				set = function(info,val) GnomTEC_Elekk_Plushie.SetOption("Tab2.Title", val) end,
				get = function(info) return GnomTEC_Elekk_Plushie.GetOption("Tab2.Title") end,
				multiline = false,
				width = 'full',
				order = 2
			},
			elekkplushieTab2Content = {
				type = "input",
				name = L["L_OPTIONS_TAB2_CONTENT"],
				desc = "",
				set = function(info,val) GnomTEC_Elekk_Plushie.SetOption("Tab2.Content", val) end,
				get = function(info) return GnomTEC_Elekk_Plushie.GetOption("Tab2.Content") end,
				multiline = 20,
				width = 'full',
				order = 3
			}
		},
	},
	{
		name = L["L_OPTIONS_TAB3"],
		type = 'group',
		args = {
			elekkplushieTab3Name = {
				type = "input",
				name = L["L_OPTIONS_TAB3_NAME"],
				desc = "",
				set = function(info,val) GnomTEC_Elekk_Plushie.SetOption("Tab3.Name", val) end,
				get = function(info) return GnomTEC_Elekk_Plushie.GetOption("Tab3.Name") end,
				multiline = false,
				width = 'full',
				order = 1
			},
			elekkplushieTab3Title = {
				type = "input",
				name = L["L_OPTIONS_TAB3_TITLE"],
				desc = "",
				set = function(info,val) GnomTEC_Elekk_Plushie.SetOption("Tab3.Title", val) end,
				get = function(info) return GnomTEC_Elekk_Plushie.GetOption("Tab3.Title") end,
				multiline = false,
				width = 'full',
				order = 2
			},
			elekkplushieTab3Content = {
				type = "input",
				name = L["L_OPTIONS_TAB3_CONTENT"],
				desc = "",
				set = function(info,val) GnomTEC_Elekk_Plushie.SetOption("Tab3.Content", val) end,
				get = function(info) return GnomTEC_Elekk_Plushie.GetOption("Tab3.Content") end,
				multiline = 20,
				width = 'full',
				order = 3
			}
		},
	},
	{
		name = L["L_OPTIONS_TAB4"],
		type = 'group',
		args = {
			elekkplushieTab4Name = {
				type = "input",
				name = L["L_OPTIONS_TAB4_NAME"],
				desc = "",
				set = function(info,val) GnomTEC_Elekk_Plushie.SetOption("Tab4.Name", val) end,
				get = function(info) return GnomTEC_Elekk_Plushie.GetOption("Tab4.Name") end,
				multiline = false,
				width = 'full',
				order = 1
			},
			elekkplushieTab4Title = {
				type = "input",
				name = L["L_OPTIONS_TAB4_TITLE"],
				desc = "",
				set = function(info,val) GnomTEC_Elekk_Plushie.SetOption("Tab4.Title", val) end,
				get = function(info) return GnomTEC_Elekk_Plushie.GetOption("Tab4.Title") end,
				multiline = false,
				width = 'full',
				order = 2
			},
			elekkplushieTab4Content = {
				type = "input",
				name = L["L_OPTIONS_TAB4_CONTENT"],
				desc = "",
				set = function(info,val) GnomTEC_Elekk_Plushie.SetOption("Tab4.Content", val) end,
				get = function(info) return GnomTEC_Elekk_Plushie.GetOption("Tab4.Content") end,
				multiline = 20,
				width = 'full',
				order = 3
			}
		},
	},
	{
		name = L["L_OPTIONS_TAB5"],
		type = 'group',
		args = {
			elekkplushieTab5Name = {
				type = "input",
				name = L["L_OPTIONS_TAB5_NAME"],
				desc = "",
				set = function(info,val) GnomTEC_Elekk_Plushie.SetOption("Tab5.Name", val) end,
				get = function(info) return GnomTEC_Elekk_Plushie.GetOption("Tab5.Name") end,
				multiline = false,
				width = 'full',
				order = 1
			},
			elekkplushieTab5Title = {
				type = "input",
				name = L["L_OPTIONS_TAB5_TITLE"],
				desc = "",
				set = function(info,val) GnomTEC_Elekk_Plushie.SetOption("Tab5.Title", val) end,
				get = function(info) return GnomTEC_Elekk_Plushie.GetOption("Tab5.Title") end,
				multiline = false,
				width = 'full',
				order = 2
			},
			elekkplushieTab5Content = {
				type = "input",
				name = L["L_OPTIONS_TAB5_CONTENT"],
				desc = "",
				set = function(info,val) GnomTEC_Elekk_Plushie.SetOption("Tab5.Content", val) end,
				get = function(info) return GnomTEC_Elekk_Plushie.GetOption("Tab5.Content") end,
				multiline = 20,
				width = 'full',
				order = 3
			}
		},
	},
}
-- ----------------------------------------------------------------------
-- Addon Startup Initialization
-- ----------------------------------------------------------------------


-- ----------------------------------------------------------------------
-- Helper Functions (local)
-- ----------------------------------------------------------------------
-- function which returns also nil for empty strings
local function emptynil( x ) return x ~= "" and x or nil end

-- function to cleanup control sequences
local function cleanpipe( x )
	x = x or ""
	
	-- Filter TRP2 {} color codes
	x = string.gsub( x, "{%x%x%x%x%x%x}", "" )
	
	-- Filter coloring
	x = string.gsub( x, "|c%x%x%x%x%x%x%x%x", "" )
	x = string.gsub( x, "|r", "" )
	
	-- Filter links
	x = string.gsub( x, "|H.-|h", "" )
	x = string.gsub( x, "|h", "" )
	
	-- Filter textures
	x = string.gsub( x, "|T.-|t", "" )

	-- Filter battle.net friend's name
	x = string.gsub( x, "|K.-|k", "" )
	x = string.gsub( x, "|k", "" )

	-- Filter newline
	x = string.gsub( x, "|n", "" )
	
	-- at last filter any left escape
	x = string.gsub( x, "|", "/" )	
	
	return strtrim(x)
end

-- ----------------------------------------------------------------------
-- Addon Class
-- ----------------------------------------------------------------------

local function GnomTECElekkPlushie()
	-- call base class
	local self, protected = GnomTECAddon("GnomTEC_Elekk_Plushie", addonInfo, defaultsDb, optionsArray)
	
	-- when we got nil from base class there is a major issue and we will stop here.
	-- GnomTEC framework will inform the user by itself about the issue.
	if (nil == self) then
		return self
	end

	-- options get/set functions table
	local options = {
		["General.Mouseover"] = {
			get = function() return self.db.char["General.Mouseover"] end,
			set = function(val) self.db.char["General.Mouseover"] = val end,
		},
		["General.ShowMinimapIcon"]  = {
			get = function() return self.db.char["General.ShowMinimapIcon"] end,
			set = function(val) self.db.char["General.ShowMinimapIcon"] = val end,
		},	
		["Tab1.Name"]  = {
			get = function() return self.db.profile["Tab1.Name"] end,
			set = function(val) self.db.profile["Tab1.Name"] = val end,
		},		
		["Tab1.Title"]  = {
			get = function() return self.db.profile["Tab1.Title"] end,
			set = function(val) self.db.profile["Tab1.Title"] = val end,
		},		
		["Tab1.Content"]  = {
			get = function() return self.db.profile["Tab1.Content"] end,
			set = function(val) self.db.profile["Tab1.Content"] = val end,
		},		
		["Tab2.Name"]  = {
			get = function() return self.db.profile["Tab2.Name"] end,
			set = function(val) self.db.profile["Tab2.Name"] = val end,
		},		
		["Tab2.Title"]  = {
			get = function() return self.db.profile["Tab2.Title"] end,
			set = function(val) self.db.profile["Tab2.Title"] = val end,
		},		
		["Tab2.Content"]  = {
			get = function() return self.db.profile["Tab2.Content"] end,
			set = function(val) self.db.profile["Tab2.Content"] = val end,
		},		
		["Tab3.Name"]  = {
			get = function() return self.db.profile["Tab3.Name"] end,
			set = function(val) self.db.profile["Tab3.Name"] = val end,
		},		
		["Tab3.Title"]  = {
			get = function() return self.db.profile["Tab3.Title"] end,
			set = function(val) self.db.profile["Tab3.Title"] = val end,
		},		
		["Tab3.Content"]  = {
			get = function() return self.db.profile["Tab3.Content"] end,
			set = function(val) self.db.profile["Tab3.Content"] = val end,
		},		
		["Tab4.Name"]  = {
			get = function() return self.db.profile["Tab4.Name"] end,
			set = function(val) self.db.profile["Tab4.Name"] = val end,
		},		
		["Tab4.Title"]  = {
			get = function() return self.db.profile["Tab4.Title"] end,
			set = function(val) self.db.profile["Tab4.Title"] = val end,
		},		
		["Tab4.Content"]  = {
			get = function() return self.db.profile["Tab4.Content"] end,
			set = function(val) self.db.profile["Tab4.Content"] = val end,
		},		
		["Tab5.Name"]  = {
			get = function() return self.db.profile["Tab5.Name"] end,
			set = function(val) self.db.profile["Tab5.Name"] = val end,
		},		
		["Tab5.Title"]  = {
			get = function() return self.db.profile["Tab5.Title"] end,
			set = function(val) self.db.profile["Tab5.Title"] = val end,
		},		
		["Tab5.Content"]  = {
			get = function() return self.db.profile["Tab5.Content"] end,
			set = function(val) self.db.profile["Tab5.Content"] = val end,
		},		
	}
	
	-- public fields go in the instance table
	-- self.field = value

	-- protected fields go in the protected table
	-- protected.field = value
	
	-- private fields are implemented using locals
	-- they are faster than table access, and are truly private, so the code that uses your class can't get them
	-- local field
	local mainWindowWidgets = nil

	-- private methods
	-- local function f()

	function OnPLAYER_TARGET_CHANGED()
		local player, realm = UnitName("target")
		realm = string.gsub(realm or GetRealmName(), "%s+", "")

	end

	function OnUPDATE_MOUSEOVER_UNIT()
		local player, realm = UnitName("mouseover")
		realm = string.gsub(realm or GetRealmName(), "%s+", "")
	
	end

	-- protected methods
	-- function protected.f()
	function protected.OnInitialize()
	 	-- Code that you want to run when the addon is first loaded goes here.
	end

	function protected.OnEnable()
  	  -- Called when the addon is enabled
				
		addonDataObject = self.NewDataObject("", addonDataObject)
		
		if (options["General.ShowMinimapIcon"].get()) then
			self.ShowMinimapIcon(addonDataObject)
		end
		
		self.RegisterEvent("UPDATE_MOUSEOVER_UNIT", OnUPDATE_MOUSEOVER_UNIT)
		self.RegisterEvent("PLAYER_TARGET_CHANGED", OnPLAYER_TARGET_CHANGED)
		
		
		self.LogMessage(LOG_INFO, L["L_ENABLED"])
		
		

	end

	function protected.OnDisable()
		-- Called when the addon is disabled
		self.UnregisterAllEvents(OnUPDATE_MOUSEOVER_UNIT)
		self.UnregisterAllEvents(OnPLAYER_TARGET_CHANGED)
	end
	
	-- public methods
	-- function self.f()
	function self.SwitchMainWindow(show)
		if (not mainWindowWidgets) then
			mainWindowWidgets = {}
			mainWindowWidgets.mainWindow = GnomTECWidgetContainerWindow({title="GnomTEC Elekk Plushie", portrait=[[Interface\ICONS\INV_tailoring_Elekkplushie]], name="Main", db=self.db})
			mainWindowWidgets.mainWindowLayout = mainWindowWidgets.mainWindow
			
			mainWindowWidgets.mainWindowLayoutTab1 = GnomTECWidgetContainerLayoutVertical({parent=mainWindowWidgets.mainWindowLayout, label="Tab1"})
			mainWindowWidgets.mainWindowLayoutTab1LayoutH = GnomTECWidgetContainerLayoutHorizontal({parent=mainWindowWidgets.mainWindowLayoutTab1, height="0%"})
			mainWindowWidgets.mainWindowLayoutTab1LayoutHTopSpacer = GnomTECWidgetSpacer({parent=mainWindowWidgets.mainWindowLayoutTab1LayoutH, minHeight=34, minWidth=50})
			mainWindowWidgets.mainWindowLayoutTab1LayoutHTitle = GnomTECWidgetText({parent=mainWindowWidgets.mainWindowLayoutTab1LayoutH, text="Title1"})
			mainWindowWidgets.mainWindowLayoutTab1LayoutHContent = GnomTECWidgetEditBox({parent=mainWindowWidgets.mainWindowLayoutTab1, text="Content1", multiLine=true})

			mainWindowWidgets.mainWindowLayoutTab2 = GnomTECWidgetContainerLayoutVertical({parent=mainWindowWidgets.mainWindowLayout, label="Tab2"})
			mainWindowWidgets.mainWindowLayoutTab2LayoutH = GnomTECWidgetContainerLayoutHorizontal({parent=mainWindowWidgets.mainWindowLayoutTab2, height="0%"})
			mainWindowWidgets.mainWindowLayoutTab2LayoutHTopSpacer = GnomTECWidgetSpacer({parent=mainWindowWidgets.mainWindowLayoutTab2LayoutH, minHeight=34, minWidth=50})
			mainWindowWidgets.mainWindowLayoutTab2LayoutHTitle = GnomTECWidgetText({parent=mainWindowWidgets.mainWindowLayoutTab2LayoutH, text="Title2"})
			mainWindowWidgets.mainWindowLayoutTab2LayoutHContent = GnomTECWidgetEditBox({parent=mainWindowWidgets.mainWindowLayoutTab2, text="Content2", multiLine=true})

			mainWindowWidgets.mainWindowLayoutTab3 = GnomTECWidgetContainerLayoutVertical({parent=mainWindowWidgets.mainWindowLayout, label="Tab3"})
			mainWindowWidgets.mainWindowLayoutTab3LayoutH = GnomTECWidgetContainerLayoutHorizontal({parent=mainWindowWidgets.mainWindowLayoutTab3, height="0%"})
			mainWindowWidgets.mainWindowLayoutTab3LayoutHTopSpacer = GnomTECWidgetSpacer({parent=mainWindowWidgets.mainWindowLayoutTab3LayoutH, minHeight=34, minWidth=50})
			mainWindowWidgets.mainWindowLayoutTab3LayoutHTitle = GnomTECWidgetText({parent=mainWindowWidgets.mainWindowLayoutTab3LayoutH, text="Title3"})
			mainWindowWidgets.mainWindowLayoutTab3LayoutHContent = GnomTECWidgetEditBox({parent=mainWindowWidgets.mainWindowLayoutTab3, text="Content3", multiLine=true})

			mainWindowWidgets.mainWindowLayoutTab4 = GnomTECWidgetContainerLayoutVertical({parent=mainWindowWidgets.mainWindowLayout, label="Tab4"})
			mainWindowWidgets.mainWindowLayoutTab4LayoutH = GnomTECWidgetContainerLayoutHorizontal({parent=mainWindowWidgets.mainWindowLayoutTab4, height="0%"})
			mainWindowWidgets.mainWindowLayoutTab4LayoutHTopSpacer = GnomTECWidgetSpacer({parent=mainWindowWidgets.mainWindowLayoutTab4LayoutH, minHeight=34, minWidth=50})
			mainWindowWidgets.mainWindowLayoutTab4LayoutHTitle = GnomTECWidgetText({parent=mainWindowWidgets.mainWindowLayoutTab4LayoutH, text="Title4"})
			mainWindowWidgets.mainWindowLayoutTab4LayoutHContent = GnomTECWidgetEditBox({parent=mainWindowWidgets.mainWindowLayoutTab4, text="Content4", multiLine=true})

			mainWindowWidgets.mainWindowLayoutTab5 = GnomTECWidgetContainerLayoutVertical({parent=mainWindowWidgets.mainWindowLayout, label="Tab5"})
			mainWindowWidgets.mainWindowLayoutTab5LayoutH = GnomTECWidgetContainerLayoutHorizontal({parent=mainWindowWidgets.mainWindowLayoutTab5, height="0%"})
			mainWindowWidgets.mainWindowLayoutTab5LayoutHTopSpacer = GnomTECWidgetSpacer({parent=mainWindowWidgets.mainWindowLayoutTab5LayoutH, minHeight=34, minWidth=50})
			mainWindowWidgets.mainWindowLayoutTab5LayoutHTitle = GnomTECWidgetText({parent=mainWindowWidgets.mainWindowLayoutTab5LayoutH, text="Title5"})
			mainWindowWidgets.mainWindowLayoutTab5LayoutHContent = GnomTECWidgetEditBox({parent=mainWindowWidgets.mainWindowLayoutTab5, text="Content5", multiLine=true})

			self.ShowElekkPlushieData()
		end
		
		if (nil == show) then
			if mainWindowWidgets.mainWindow.IsShown() then
				mainWindowWidgets.mainWindow.Hide()
			else
				mainWindowWidgets.mainWindow.Show()
			end
		else
			if show then
				mainWindowWidgets.mainWindow.Show()
			else
				mainWindowWidgets.mainWindow.Hide()
			end
		end
	end
	
	function self.ShowElekkPlushieData(realm, player)
		self.SwitchMainWindow(true)
		local p, r = UnitName("player")
		r = string.gsub(r or GetRealmName(), "%s+", "")
		if ((r == realm) and (p == player)) or ((not realm) or (not player)) then 
			-- show own elekk plushie data
			mainWindowWidgets.mainWindowLayoutTab1.SetLabel(self.GetOption("Tab1.Name") or "")
			mainWindowWidgets.mainWindowLayoutTab1LayoutHTitle.SetText(self.GetOption("Tab1.Title") or "")
			mainWindowWidgets.mainWindowLayoutTab1LayoutHContent.SetText(self.GetOption("Tab1.Content") or "")

			mainWindowWidgets.mainWindowLayoutTab2.SetLabel(self.GetOption("Tab2.Name") or "")
			mainWindowWidgets.mainWindowLayoutTab2LayoutHTitle.SetText(self.GetOption("Tab2.Title") or "")
			mainWindowWidgets.mainWindowLayoutTab2LayoutHContent.SetText(self.GetOption("Tab2.Content") or "")

			mainWindowWidgets.mainWindowLayoutTab3.SetLabel(self.GetOption("Tab3.Name") or "")
			mainWindowWidgets.mainWindowLayoutTab3LayoutHTitle.SetText(self.GetOption("Tab3.Title") or "")
			mainWindowWidgets.mainWindowLayoutTab3LayoutHContent.SetText(self.GetOption("Tab3.Content") or "")

			mainWindowWidgets.mainWindowLayoutTab4.SetLabel(self.GetOption("Tab4.Name") or "")
			mainWindowWidgets.mainWindowLayoutTab4LayoutHTitle.SetText(self.GetOption("Tab4.Title") or "")
			mainWindowWidgets.mainWindowLayoutTab4LayoutHContent.SetText(self.GetOption("Tab4.Content") or "")

			mainWindowWidgets.mainWindowLayoutTab5.SetLabel(self.GetOption("Tab5.Name") or "")
			mainWindowWidgets.mainWindowLayoutTab5LayoutHTitle.SetText(self.GetOption("Tab5.Title") or "")
			mainWindowWidgets.mainWindowLayoutTab5LayoutHContent.SetText(self.GetOption("Tab5.Content") or "")
			
		else
			-- show elekk plushie data from other player
		end
	end
		
	function	self.ShowAddonTooltip(tooltip)
		tooltip:AddLine("GnomTEC Elekk Plushie Informationen",1.0,1.0,1.0)
		tooltip:AddLine(" ")
		tooltip:AddLine("Keine Informationen",1.0,1.0,1.0)
	end

	function	self.GetOption(option)
		if (options[option]) then
			return options[option].get()
		else
			self.LogMessage(LOG_WARN, "Someone tried to get an unknown option (%s)", option or "")
			return nil
		end
	end	

	function	self.SetOption(option, value)
		if (options[option]) then
			options[option].set(value)
		else
			self.LogMessage(LOG_WARN, "Someone tried to set an unknown option (%s)", option or "")
		end
	end	

	
	-- constructor
	do
		self.LogMessage(LOG_INFO, L["L_WELCOME"])
	end
	
	-- return the instance table
	return self
end

-- ----------------------------------------------------------------------
-- Addon Instantiation
-- ----------------------------------------------------------------------

GnomTEC_Elekk_Plushie = GnomTECElekkPlushie()
