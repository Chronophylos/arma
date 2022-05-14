[west, ["MonkeSquadleader", 1, -1]] call BIS_fnc_addRespawninventory;
[west, ["MonkeKommander", 1, -1]] call BIS_fnc_addRespawninventory;
{
    [west, _x] call BIS_fnc_addRespawninventory;
} forEach ["MonkeRifleman1", "MonkeRifleman3", "MonkeMachinegunner"];
[west, ["MonkeMedic", 2, -1]] call BIS_fnc_addRespawninventory;