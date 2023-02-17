/*
	Author: Chronophylos
	
	Description:
	Add an action to toggle the flag of a vehicle to all players on the server.
	Supports JIP.
	
	Parameter(s):
	
	Returns:
	Nothing
	
	Examples:
	[] call PAG_fnc_initFlagActions;
*/

PAG_fnc_isValidFlagBearer = {
	params ["_caller", "_target"];

	if (_target == _caller) exitWith {
		false
	};
	if (!alive _target) exitWith {
		false
	};
	if (isPlayer _target) exitWith {
		false
	};
	if (!(_target isKindOf 'AllVehicles')) exitWith {
		false
	};
	if (!(side _caller == side _target || count crew _target == 0)) exitWith {
		false
	};

	true
};

PAG_fnc_addRaiseFlagAction = {
	params ["_vehicle"];

	_actionID = _vehicle addAction
	[
		"Raise Flag",
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			if (!([_caller, _target] call PAG_fnc_isValidFlagBearer)) exitWith {};

			_target forceFlagtexture "\A3\Data_F\flags\flag_FIA_CO.paa";
		},
		nil,
		0.5,
		false,
		true,
		"",
		"getForcedFlagTexture _target == '' && (side _target == side _this || count crew _target == 0)", // _target, _this, _originalTarget
		10
	];
	_vehicle setUserActionText [_actionID, "Raise Flag", "<img image='\A3\ui_f\data\map\markers\handdrawn\flag_CA.paa' size='2' shadow='true' />"]
};

PAG_fnc_addLowerFlagAction = {
	params ["_vehicle"];

	_actionID = _vehicle addAction
	[
		"Lower Flag",
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			if (!([_caller, _target] call PAG_fnc_isValidFlagBearer)) exitWith {};

			_target forceFlagtexture "";
		},
		nil,
		0.5,
		false,
		true,
		"",
		"getForcedFlagTexture _target != '' && (side _target == side _this || count crew _target == 0)", // _target, _this, _originalTarget
		10
	];
	_vehicle setUserActionText [_actionID, "Lower Flag", "<img image='\A3\ui_f\data\map\groupicons\waypoint.paa' size='2' shadow='true' />"]
};

addMissionEventHandler ["EntityCreated", {
	params ["_entity"];

	// check if entity is eligble for flag actions
	if (!alive _entity) exitWith {};
	if (isPlayer _entity) exitWith {};
	if (!(_entity isKindOf 'AllVehicles')) exitWith {};

	// add flag toggle action
	[_entity] remoteExec ["PAG_fnc_addRaiseFlagAction"];
	[_entity] remoteExec ["PAG_fnc_addLowerFlagAction"];
}];