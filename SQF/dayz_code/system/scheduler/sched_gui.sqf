#include "scheduler.hpp"

sched_gui_init = { [false] };

sched_gui = {
	HIDE_FSM_VARS
	private [ "_array", "_initDone", "_ui"];

	_initDone = _this select 0;

	if ((!_initDone and !isNil 'Dayz_loginCompleted') and {(Dayz_loginCompleted)}) then {
		if !(DZE_UI == 0) then {
			_ui = call {
				if (DZE_UI == 1) exitWith {"playerStatusGUI"};
				if (DZE_UI == 2) exitWith {"playerStatusGUI_epoch"};
				"playerStatusGUI_legacy";
			};
			3 cutRsc [_ui,"PLAIN",0];
		} else {
			[] spawn {uiSleep 2; systemChat (localize "STR_UI_STATUS_ICONS_TOOLTIP");};
			//This can be removed after friendlies system is removed from player_updateGUI
			uiNamespace setVariable ["DAYZ_GUI_display",displayNull];
		};		
       _initDone = true;
	};
	//else {
	//	diag_log [ diag_Ticktime, __FILE__, "waiting", _initDone,Dayz_loginCompleted];
	//};
	if (_initDone) then {
		_array = player call world_surfaceNoise;
		dayz_surfaceNoise = _array select 1;
		dayz_surfaceType = _array select 0;
		call player_checkStealth;
		call player_updateGui;
	};

	// move this elsewhere, it deals with the menu
	if (!isNull cursorTarget and {!dayz_heartBeat} and {DZE_HeartBeat}) then {
		if (alive cursorTarget) then {
			cursorTarget spawn dayz_lowHumanity;
		};
	};

	[_initDone]
};
