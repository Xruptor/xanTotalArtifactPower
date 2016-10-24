
local xanTotalArtifactPower = CreateFrame("frame","xanTotalArtifactPowerFrame",UIParent)
xanTotalArtifactPower:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)

local debugf = tekDebug and tekDebug:GetFrame("xanTotalArtifactPower")
local function Debug(...)
    if debugf then debugf:AddMessage(string.join(", ", tostringall(...))) end
end

local multiplier = {100, 400, 725, 1075, 1450, 1850, 2275, 2725, 3250, 3875, 4625, 5500, 6500, 13340, 22170, 33450, 47850, 66470, 90470, 121070, 160590, 211470, 276270, 358770, 464050, 602700, 785480, 1026350, 1341870, 1759430, 2305430, 3023630, 3970290, 5216130}

local function GetArtifactPower()
	local total = 0
	if HasArtifactEquipped() then
		powerAvailable = select(5, C_ArtifactUI.GetEquippedArtifactInfo())
		ranksPurchased = select(6, C_ArtifactUI.GetEquippedArtifactInfo())
		total = powerAvailable + multiplier[ranksPurchased]
		DEFAULT_CHAT_FRAME:AddMessage("|cFF99CC33xanTotalArtifactPower|r")
		DEFAULT_CHAT_FRAME:AddMessage("|cffff7d0aRanks Purchased:|r "..tostring(ranksPurchased).."  |cff3587ff(does not include relics)|r")
		DEFAULT_CHAT_FRAME:AddMessage("|cffff7d0aPower Available:|r "..tostring(powerAvailable))
		DEFAULT_CHAT_FRAME:AddMessage("|cffff7d0aPower Spent On Ranks:|r "..tostring(multiplier[ranksPurchased]))
		DEFAULT_CHAT_FRAME:AddMessage("|cffff7d0aTotal Power On Relic:|r "..tostring(total))
	else
		DEFAULT_CHAT_FRAME:AddMessage("|cFF99CC33xanTotalArtifactPower:|r No artifact equipped")
	end
end

function xanTotalArtifactPower:PLAYER_LOGIN()

	SLASH_XANTOTALARTIFACTPOWER1 = "/xtap"
	SlashCmdList["XANTOTALARTIFACTPOWER"] = function(msg)
		GetArtifactPower()
	end
	
	local ver = GetAddOnMetadata("xanTotalArtifactPower","Version") or '1.0'
	DEFAULT_CHAT_FRAME:AddMessage(string.format("|cFF99CC33%s|r [v|cFFDF2B2B%s|r] Loaded /xtap", "xanTotalArtifactPower", ver or "1.0"))
end

if IsLoggedIn() then xanTotalArtifactPower:PLAYER_LOGIN() else xanTotalArtifactPower:RegisterEvent("PLAYER_LOGIN") end

