#include <a_samp>

main()
{
	print("\n----------------------------------");
	print(" Test Rozvoz Gamemode");
	print("----------------------------------\n");
}

new jobpickup;
new razvozCar[MAX_PLAYERS];
new Float:jobPositions[][3] = {
	{2020.9727,1892.7699,15.4794},
	{1954.0618,1896.1923,15.1680},
	{1954.0618,1896.1923,15.1680},
	{1938.8568,2087.1062,15.3612},
	{1736.6891,2268.3286,15.5227},
	{1784.5712,2266.7219,15.4338},
	{1820.6218,2256.8105,14.9287},
	{1926.1616,2328.8398,15.1427},
	{1833.2567,2524.4290,15.3194},
	{1738.6337,1762.4810,14.9822},
	{1421.6487,1686.3689,15.0133},
	{1432.3333,1709.9346,14.9390}
};
new razvozTimer[MAX_PLAYERS];
new razvozTimerCount[MAX_PLAYERS];

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("Test Rozvoz");
	AddPlayerClass(0,1995.0492,1328.3088,26.0691,353.8474,0,0,0,0,0,0);
	jobpickup = CreatePickup(1279, 2, 2003.2836, 1338.7914, 26.1432, -1);
	Create3DTextLabel("{00c3ff}Работа развозчика", 0xff4800AA, 2003.2836, 1338.7914, 26.1432, 50, 0, 1);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1995.0492,1328.3088,26.0691);
	SetPlayerFacingAngle(playerid, 353.8474);
	SetPlayerCameraPos(playerid, 1995.0492,1328.3088,26.0691);
	SetPlayerCameraLookAt(playerid, 1995.0492,1328.3088,26.0691);
	return 1;
}

public OnPlayerConnect(playerid)
{
	SetPVarInt(playerid, "Rozvoz", 0);
	SetPVarInt(playerid, "RozvozAchived", 0);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
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
	if (strcmp("/car", cmdtext, true, 10) == 0)
	{
	    new Float:x, Float:y, Float:z;
	    GetPlayerPos(playerid, x, y, z);
		new vehid = CreateVehicle(411, x, y, z, 144, 144, 0, 0);
		PutPlayerInVehicle(playerid, vehid, 0);
		SendClientMessage(playerid, 0xFFFFFFFF, "Vehicle spawned!");
		return 1;
	}
    if (!strcmp("/repair", cmdtext))
    {
        if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0xFFFFFFFF, "You are not in a vehicle!");
        RepairVehicle(GetPlayerVehicleID(playerid));
        SendClientMessage(playerid, 0xFFFFFFFF, "Your vehicle has been repaired!");
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
	if(GetPVarInt(playerid, "Rozvoz") == 1 && vehicleid == razvozCar[playerid])
	{
		razvozTimerCount[playerid] = 60;
    	razvozTimer[playerid] = SetTimerEx("RazvozTimer", 1000, true, "i", playerid);
	}
	return 1;
}

forward RazvozTimer(playerid);
public RazvozTimer(playerid)
{
    new string[11];
    format(string, sizeof(string), "~y~TIME:%i", razvozTimerCount[playerid]);
    GameTextForPlayer(playerid, string, 1000, 3);
    razvozTimerCount[playerid]--;
	if(razvozTimerCount[playerid] <= 0)
	{
	    SetPVarInt(playerid, "Rozvoz", 0);
     	SetPVarInt(playerid, "RozvozAchived", 0);
		DestroyVehicle(razvozCar[playerid]);
		DisablePlayerCheckpoint(playerid);
		SendClientMessage(playerid, 0xFFFFFFFF, "Работа закончена!");
		KillTimer(razvozTimer[playerid]);
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) // Player entered a vehicle as a driver
    {
        new vehicleid = GetPlayerVehicleID(playerid);
		if(GetPVarInt(playerid, "Rozvoz") == 1 && vehicleid == razvozCar[playerid])
		{
			razvozTimerCount[playerid] = 60;
			KillTimer(razvozTimer[playerid]);
		}
    }
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
    if(GetPVarInt(playerid, "Rozvoz") == 1 && GetPVarInt(playerid, "RozvozAchived") == 0)
    {
        GivePlayerMoney(playerid, 5000);
        DisablePlayerCheckpoint(playerid);
        SetPlayerCheckpoint(playerid, 1995.9943, 1335.2272, 25.7775, 3.0);
        SetPVarInt(playerid, "RozvozAchived", 1);
		return 1;
    }
    if(GetPVarInt(playerid, "Rozvoz") == 1 && GetPVarInt(playerid, "RozvozAchived") == 1)
    {
        DisablePlayerCheckpoint(playerid);
        GenerateCheckPoint(playerid);
        SetPVarInt(playerid, "RozvozAchived", 0);
        return 1;
    }
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

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pickupid == jobpickup)
	{
		if(GetPVarInt(playerid, "Rozvoz") == 0)
		{
			ShowPlayerDialog(playerid, 1, DIALOG_STYLE_MSGBOX, "Развозчик - Работа", "Вы хотите устроиться на работу развозчиком?", "Да", "Нет");
		}
		else
		{
		    ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "Развозчик - Работа", "Вы хотите уволится с работы развозчика?", "Да", "Нет");
		}
	}
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

public OnPlayerUpdate(playerid)
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
	switch(dialogid)
	{
		case 1:
		{
		    if(response)
			{
			    SetPVarInt(playerid, "Rozvoz", 1);
			    SetPVarInt(playerid, "RozvozAchived", 0);
   				new vehid = CreateVehicle(609, 1995.9943,1335.2272, 25.7775, 357.7458, 166, 166, 0, -1);
   				razvozCar[playerid] = vehid;
   				PutPlayerInVehicle(playerid, vehid, 0);
   				GenerateCheckPoint(playerid);
   				SendClientMessage(playerid, 0xFFFFFFFF, "Работа начата!");
			}
			else
			{
                SetPVarInt(playerid, "Rozvoz", 0);
			}
		}
		case 2:
		{
		    if(response)
			{
			    SetPVarInt(playerid, "Rozvoz", 0);
		     	SetPVarInt(playerid, "RozvozAchived", 0);
   				DestroyVehicle(razvozCar[playerid]);
   				DisablePlayerCheckpoint(playerid);
   				KillTimer(razvozTimer[playerid]);
   				SendClientMessage(playerid, 0xFFFFFFFF, "Работа закончена!");
			}
			else
			{
				SetPVarInt(playerid, "Rozvoz", 1);
			}
		}
	}
	return 1;
}

stock GenerateCheckPoint(playerid)
{
	new index = random(sizeof(jobPositions));
    SetPlayerCheckpoint(playerid, jobPositions[index][0], jobPositions[index][1], jobPositions[index][2], 3.0);
    SetPVarInt(playerid, "RozvozAchived", 0);
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
