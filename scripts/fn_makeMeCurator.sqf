// requires CBA
// Copy all code below (without this comment!) into Debug Console and execute locally (press "Local Exec").

missionNamespace setVariable ["dedmen", player, true];

[0, {
	if (!isNil "DedmensCur") then {
		call compile format [
			"[-1, {
				if (player == dedmen) then {
					dedmen sideChat ""deleting Curator"";
				}
			}] call CBA_fnc_globalExecute;
			"
		];

		deleteVehicle DedmensCur;

		missionNamespace setVariable ["DedmensCur", nil, true];
	};

	if (isNil "DedmensCur") then {
		call compile format [
			"[-1, {
				if (player == dedmen) then {
					dedmen sideChat ""creating Curator"";
				}
			}] call CBA_fnc_globalExecute;
			"
		];

		if (isNil "DedmensCur_group") then {
			DedmensCur_group = createGroup sideLogic;
		};
		DedmensCur = DedmensCur_group createUnit ["ModuleCurator_F", [0, 90, 90], [], 0.5, "NONE"];
		DedmensCur setVariable ["showNotification", false];

		publicVariable "DedmensCur";
		publicVariable "DedmensCur_group";

		unassignCurator DedmensCur;

		_cfg = (configFile >> "CfgPatches");
		_newAddons = [];
		for "_i" from 0 to((count _cfg) - 1) do {
			_name = configName(_cfg select _i);
			_newAddons pushBack _name;
		};
		if (count _newAddons > 0) then {
			DedmensCur addCuratorAddons _newAddons
		};

		DedmensCur setCuratorCoef ["Place", 0];
		DedmensCur setCuratorCoef ["Delete", 0];
	};

	unassignCurator DedmensCur;

	sleep 0.4;

	dedmen assignCurator DedmensCur;

	call compile format[
		"[-1, {
			if (player == dedmen) then {
				dedmen sideChat ""you are Curator"";
			}
		}] call CBA_fnc_globalExecute;
		"
	];
}] call CBA_fnc_globalExecute;