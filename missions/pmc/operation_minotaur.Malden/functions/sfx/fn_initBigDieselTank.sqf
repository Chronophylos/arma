params ["_object"];

_object addEventHandler ["Killed", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];
    
    if (_useEffects) then {
        position _unit call PAG_fnc_createOilfireSFX;
    };
}];