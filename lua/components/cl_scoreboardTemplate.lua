local component = {}
component.dependencies = {"scoreboard", "theme"}
component.title = "Scoreboard - Sandbox"

function component:ScoreboardStats()
	if engine.ActiveGamemode() == "terrortown" then
		return self.StatsFromDerived
	end
end

function component:StatsFromDerived(ply)
	local stats = {
		{
			stat = "Karma",
			important = true,
			func = function() return ply():IsValid() and math.Round(ply():GetBaseKarma()) or 0 end,
			limit = function() return 1000 end
		},
		{
			stat = "Score",
			important = true,
			func = function() return ply():IsValid() and ply():Frags() or 0 end
		},
		{
			stat = "Deaths",
			important = true,
			func = function() return ply():IsValid() and ply():Deaths() or 0 end
		},
		{
			stat = "Ping",
			important = true,
			func = function() return ply():IsValid() and ply():Ping() or 0 end
		},
	}

	// Insert only unique stat if it's available
	if galactic and galactic.pdManager then
		table.insert(stats, 
		{
			stat = "Playtime",
			important = true,
			func = function()
				if not ply():IsValid() then return "None" end
				self.PlayTime = os.time() - ply():Info().lastJoin + ply():Info().playTime
				return string.NiceTime(self.PlayTime)
			end
		})
	/*elseif ulx then
		table.insert(stats, 
		{
			stat = "Playtime",
			important = true,
			func = function()
				local pl = ply()
				print(pl, pl:GetNWInt( "TotalUTime", -1 ))
				if not pl:IsValid() then return "None" end
				self.PlayTime = math.floor((pl:GetUTime() + CurTime() - pl:GetUTimeStart()))
				return string.NiceTime(self.PlayTime)
			end
		})*/
	end

	/*table.insert(stats, 
	{
		trivial = true,
		paint = function(self, pnl, w, h)
			pnl:SetHeight(w)
			pnl:SetHeight(galactic.theme.rem * 12)
			draw.NoTexture()

			local points = {}
			local maxPoints = 36
			for i = 1, maxPoints do
				local scale = .6 + math.cos(RealTime() + i / maxPoints * 2 * math.pi) * .2 + .2 * (i % 2)
				table.insert(points, { x = math.cos(i / maxPoints * math.pi * 2) * w / 2 * scale + w / 2, y = math.sin(i / maxPoints * math.pi * 2) * w / 2 * scale + w / 2})
			end
			surface.SetDrawColor( 255, 0, 0, 255 )
			surface.DrawPoly(points)
		end
	})*/

	return stats
end

galactic:Register(component)
