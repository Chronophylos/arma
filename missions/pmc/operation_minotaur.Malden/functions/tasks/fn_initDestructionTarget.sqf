params [
    ["_object", objNull, [objNull]],
    ["_task", "", [""]],
    ["_allTasks", [], [[""]]],
    ["_parentTask", "", [""]]
];

_object setVariable ["task", _task, false];
_object setVariable ["allTasks", _allTasks, false];
_object setVariable ["parentTask", _parentTask, false];

_object addEventHandler ["Killed", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];
    
    private _task = _unit getVariable "task";
    private _allTasks = _unit getVariable "allTasks";
    private _parentTask = _unit getVariable "parentTask";
    
    [_task, "SUCCEEDED"] call BIS_fnc_tasksetState;
    [_parentTask, _allTasks] call PAG_fnc_cascadeTaskCompletion;
}];