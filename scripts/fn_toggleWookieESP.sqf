// Visually show lines to where all players and units are while on foot.
if (isnil ("WookieESP")) then {
	WookieESP = 0;
};
if (WookieESP == 0) then {
	WookieESP = 1;
	cutText [format["Esp On"], "PLAIN DOWN"];
	hint "Esp On";
} else {
	WookieESP = 0;
	cutText [format["Esp Off"], "PLAIN DOWN"];
	hint "Esp Off";
};
if (WookieESP == 1) then {
	onEachFrame {
		_nigs = nearestobjects [player, ["CAManBase"], 1400];
		{
			if ((side _x != side player) && (getPlayerUID _x != "") && ((player distance _x) < 1400)) then {
				drawIcon3D ["", [1, 0, 0, 0.7], GetPosATL _x, 0.1, 0.1, 45, (format ["%2 : %1m", round(player distance _x), name _x]), 1, 0.03, "default"]
			} else {
				if ((getPlayerUID _x != "") && ((player distance _x) < 1000)) then {
					drawIcon3D ["", [0, 1, 0.5, 0.4], GetPosATL _x, 0.1, 0.1, 45, (format ["%2 : %1m", round(player distance _x), name _x]), 1, 0.03, "default"]
				};
			};
		} forEach playableUnits;

		_noobs = nearestobjects [player, ["CAManBase"], 100];

		{
			if (((alive _x)) && ((player distance _x) < 100)) then {
				if ((side _x != side player) && ((player distance _x) < 100)) then {
					if (player distance _x < 10 && _x iskindof "CAManBase" && side _x != civilian) then {
						drawLine3D [[getPosATL player select 0, getPosATL player select 1, getPosATL player select 2], _x, [1, 0, 0, (abs((((player distance _x)) - 100)/100))]]
					};
				} else {
					drawLine3D [[getPosATL player select 0, getPosATL player select 1, getPosATL player select 2], _x, [0, 1, 0, (abs((((player distance _x)) - 100)/100))]]
				};
			};
		} forEach playableUnits;
	};
} else {
	onEachFrame {
		nil
	};
};