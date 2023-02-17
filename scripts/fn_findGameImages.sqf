// [ configFile >> "CfgMarkers" ] call LARs_fnc_findGameImages
// [ configFile ] call LARs_fnc_findGameImages

LARs_fnc_findGameImages = {
	if !(canSuspend) exitWith {
		_this spawn LARs_fnc_findGameImages
	};

	disableSerialization;
	private [ "_color", "_total", "_totalIndex", "_stxt", "_display" ];
	params[ [ "_cfg", configFile ] ];

	_fnc_createProgress = {
		createDialog "RscDisplayNotFreezeBig";
		waitUntil {
			_display = findDisplay 100002;
			!isNull _display
		};

		{
			_ctrl = _display displayCtrl _x;
			_ctrl ctrlSetPosition [ 0, 0, 0, 0 ];
			_ctrl ctrlCommit 0;
		}forEach [ 101, 1080, 1081, 1082, 1083 ];

		_stxt = _display ctrlCreate [ "RscStructuredText", 1000 ];
		_stxt ctrlSetPosition [ 0, -0.1, 1, 0.1 ];
		_stxt ctrlCommit 0;
	};

	_fnc_working = {
		params[ "_count", "_msg" ];
		_msg params[ "_prefix", "_suffix" ];

		_msg = format[ "<t color='%1'>%2</t>", _color, _prefix ];

		for "_i" from 0 to (_count % 30) do {
			_msg = format[ "%1.", _msg ];
		};

		_msg = format[ "%1<br/>%2/%3 %4<br/>", _msg, _totalIndex, _total, _suffix ];
		_stxt ctrlSetStructuredText parseText _msg;
	};

	_fnc_isTexture = {
		params[ "_value" ];

		if (toLower( _value select [ 0, 6 ] ) isEqualTo "str_a3") then {
			_value = localize _value;
		};
		if (_value isEqualTo "") exitWith {};

		_value = toLower _value;
		{
			_tmp = _value splitString _x;
			{
				_part = _x;
				{
					if (_part select [ (( count _part ) -4 ), 4 ] isEqualTo _x) then {
						_nul = LARs_configTextures pushBackUnique _part;
					};
				}forEach[ ".paa", ".jpg", ".tga", ".bmp", ".png" ];
			}forEach _tmp;
		}forEach[ "'", " ", ", " ];
	};

	_fnc_getProperties = {
		params[ "_cfg" ];

		_properties = configProperties[ _cfg, "isText _x || isArray _x", false ];

		{
			[ _forEachIndex, [ "Searching config", "root classes" ] ] call _fnc_working;

			switch (true) do {
				case (isText _x) : {
					(getText _x) call _fnc_isTexture;
				};
				case (isArray _x) : {
					{
						if (_x isEqualType "") then {
							_x call _fnc_isTexture;
						};
					}forEach getArray _x;
				};
			};
		}forEach _properties;
	};

	_fnc_getClasses = {
		params[ "_cfg", [ "_root", true ] ];

		_classes = ("true" configClasses _cfg);
		if (_root) then {
			_total = count _classes;
		};

		{
			if (_root) then {
				_r = linearConversion[ 0, _total, _forEachIndex, 1, 0 ];
				_g = linearConversion[ 0, _total, _forEachIndex, 0, 1 ];
				_color = [ _r, _g, 0, 1 ] call BIS_fnc_colorRGBAtoHTML;
				_totalIndex = _forEachIndex;
			};

			_x call _fnc_getProperties;
			[ _x, false ] call _fnc_getClasses;
		}forEach _classes;
	};

	call _fnc_createProgress;

	if ( isNil "LARs_lastConfig" || {
		LARs_lastConfig != _cfg
	} ) then {
		LARs_lastConfig = _cfg;
		LARs_configTextures = [];
		_cfg call _fnc_getClasses;
	};

	if (count LARs_configTextures > 0) then {
		_ctrlGrp = _display ctrlCreate [ "RscControlsGroup", 1001 ];
		_ctrlGrp ctrlSetPosition [ 0, 0, 1, 1 ];
		_ctrlGrp ctrlCommit 0;

		_total = count LARs_configTextures;

		_picHeight = 0.15;
		{
			_r = linearConversion[ 0, _total, _forEachIndex, 1, 0 ];
			_g = linearConversion[ 0, _total, _forEachIndex, 0, 1 ];
			_color = [ _r, _g, 0, 1 ] call BIS_fnc_colorRGBAtoHTML;
			_totalIndex = _forEachIndex;
			[ _forEachIndex, [ "Please wait filling UI", "images found" ] ] call _fnc_working;

			_picGrp = _display ctrlCreate [ "RscControlsGroup", 1010 + _forEachIndex, _ctrlGrp ];
			_picGrp ctrlSetPosition [ 0, _picHeight * _forEachIndex, 1, _picHeight ];
			_picGrp ctrlCommit 0;

			_pic = _display ctrlCreate [ "RscPicture", 3010 + _forEachIndex, _picGrp ];
			_pic ctrlSetPosition [ 0, 0, _picHeight, _picHeight ];
			_pic ctrlSetText _x;
			_pic ctrlCommit 0;

			_btn = _display ctrlCreate [ "RscButton", 5010 + _forEachIndex, _picGrp ];
			_btn ctrlSetPosition [ _picHeight, 0, 1-_picHeight, _picHeight ];
			_btn ctrlSetText _x;
			_btn buttonSetAction format[ "hint 'copied to clipboard';
			copyToClipboard str %1", str _x ];
			_btn ctrlCommit 0;
		}forEach LARs_configTextures;
	};

	_stxt ctrlSetStructuredText parseText "Finished";
	sleep 3;
	_stxt ctrlSetStructuredText parseText "Please select a file path to copy to clipboard";
};