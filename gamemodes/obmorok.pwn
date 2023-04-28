#include <a_samp>

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

enum pInfo {
	PLAYER_KNOCKDOWN,
};

new PlayerInfo[MAX_PLAYERS][pInfo];
new knockDownTimer[MAX_PLAYERS];

public OnGameModeInit()
{
	SetGameModeText("Blank Script");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
 	if(PlayerInfo[playerid][PLAYER_KNOCKDOWN] == 1)
	{
        ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.1, 0, 1, 1, 1, 1000, 1);
	}
	return 1;
}
// таймер нока
forward OnPlayerKnockDown(playerid);
public OnPlayerKnockDown(playerid)
{
    SetPlayerHealth(playerid, 0);
    SendClientMessage(playerid, -1, "А таймер то работает!");
    KillTimer(knockDownTimer[playerid]);
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	ClearAnimations(playerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if(PlayerInfo[playerid][PLAYER_KNOCKDOWN] == 0)
	{
		SetPlayerHealth(playerid, 15);
		SpawnPlayer(playerid);
		SetPlayerPos(playerid, x, y, z);
        ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.1, 0, 1, 1, 1, 1000, 1);
		SendClientMessage(playerid, -1, "Вы в обмороке, захильтесь чтобы идти дальше, или через 25 секунд вы здохните нахуй!");
		PlayerInfo[playerid][PLAYER_KNOCKDOWN] = 1;
		knockDownTimer[playerid] = SetTimerEx("OnPlayerKnockDown", 25000, false, "i", playerid);
	}
	else
	{
		SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
		SetPlayerHealth(playerid, 10);
		PlayerInfo[playerid][PLAYER_KNOCKDOWN] = 0;
		SpawnPlayer(playerid);
		KillTimer(knockDownTimer[playerid]);
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/deagle", cmdtext, true, 10) == 0)
	{
		GivePlayerWeapon(playerid, 24, 100);
		return 1;
	}
	if (strcmp("/kastet", cmdtext, true, 10) == 0)
	{
		GivePlayerWeapon(playerid, 1, 1);
		return 1;
	}
	if (strcmp("/grenade", cmdtext, true, 10) == 0)
	{
		GivePlayerWeapon(playerid, WEAPON_GRENADE, 100);
		return 1;
	}
	if (strcmp("/kill", cmdtext, true, 10) == 0)
	{
		SetPlayerHealth(playerid, 0);
		return 1;
	}
	if (strcmp("/hitme", cmdtext, true, 10) == 0)
	{
		SetPlayerHealth(playerid, 2);
		return 1;
	}
	if (strcmp("/help", cmdtext, true, 10) == 0)
	{
		ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "Help", "/deagle - give player deagle\n/kill - kill yourself", "Close", "Close");
		return 1;
	}
	if (strcmp("/health", cmdtext, true, 10) == 0)
	{
		// при получении аптечки, или хила стераем все нок параметры
		PlayerInfo[playerid][PLAYER_KNOCKDOWN] = 0;
		KillTimer(knockDownTimer[playerid]);
		SetPlayerHealth(playerid, 100);
		ClearAnimations(playerid);
		return 1;
	}
	if (strcmp("/removeweapon", cmdtext, true, 10) == 0)
	{
		// при получении аптечки, или хила стераем все нок параметры
		new gunID = GetPlayerWeapon(playerid);
		if(gunID == 1)
		{
			SetPlayerArmedWeapon(playerid, 0);
		}
		else
		{
			SetPlayerAmmo(playerid, gunID, 0);
		}
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
