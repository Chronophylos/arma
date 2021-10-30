params [
    ["_parentTask", "", [""]],
    ["_childTasks", [], [[""]]],
    ["_delay", 5, 0]
];

private _tasksdone = _childTasks findif {
    !(_x call BIS_fnc_taskCompleted)
} == -1;

if (_tasksdone) then {
    [_parentTask, _delay] spawn {
        params ["_parentTask", "_delay"];
        
        sleep _delay;
        [_parentTask, "SUCCEEDED"] call BIS_fnc_tasksetState;
    };
};