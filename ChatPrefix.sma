#include <amxmodx>

#define OWNER(%0) (get_user_flags(%0) & ADMIN_RCON)
#define HEADMIN(%0) (get_user_flags(%0) & ADMIN_IMMUNITY)
#define ADMIN(%0) (get_user_flags(%0) & ADMIN_BAN)
#define VIP(%0) (get_user_flags(%0) & ADMIN_RESERVATION)

#define ALIVE(%0) is_user_alive(%0)
new Msg

public plugin_init()
{
	register_plugin("Simple Chat Prefixes", "1.0", "DiGiTaL")
	register_clcmd("say", "handleSay")
	register_clcmd("say_team", "handleTeamSay")

	Msg = get_user_msgid("SayText")
	register_message(Msg, "firstMsg")
}

public firstMsg(id) return PLUGIN_HANDLED
public handleSay(id) checkMsg(id, false)
public handleTeamSay(id) checkMsg(id, true)

stock checkMsg(id, bool:teamSay)
{
	if(OWNER(id)) ALIVE(id) ? setMsg(id, "OWNER", true, teamSay) : setMsg(id, "OWNER", false, teamSay)
	else if(HEADMIN(id)) ALIVE(id) ? setMsg(id, "HEAD ADMIN", true, teamSay) : setMsg(id, "HEAD ADMIN", false, teamSay)
	else if(ADMIN(id)) ALIVE(id) ? setMsg(id, "ADMIN", true, teamSay) : setMsg(id, "ADMIN", false, teamSay)
	else if(VIP(id)) ALIVE(id) ? setMsg(id, "VIP", true, teamSay) : setMsg(id, "VIP", false, teamSay)
}

stock setMsg(index, type[], bool:is_alive, bool:is_teamSay)
{
	new nMsg[192],szArg[192], szName[32], szTeam[32], players[32], num
	get_user_name(index, szName, charsmax(szName))
	get_user_team(index, szTeam, charsmax(szTeam))

	read_args(szArg, charsmax(szArg))
	remove_quotes(szArg)

	if (!szArg[0] || szArg[0] == '/') return PLUGIN_HANDLED_MAIN

	if(is_alive)
	{
		if(is_teamSay)
		{
			formatex(nMsg, charsmax(nMsg), "^1(%s) [^4%s^1] ^3%s ^1: ^4%s", szTeam, type, szName, szArg)
			get_players(players, num, "ae", szTeam)
			for(new i;i < num; i++) client_print_color(players[i], 0, nMsg)
		}
		else
		{
			formatex(nMsg, charsmax(nMsg), "^1[^4%s^1] ^3%s ^1: ^4%s", type, szName, szArg)
			client_print_color(0, 0, nMsg)
		}
	} 
	else
	{
		if(is_teamSay)
		{
			formatex(nMsg, charsmax(nMsg), "^1*DEAD* (%s) [^4%s^1] ^3%s ^1: ^4%s", szTeam, type, szName, szArg)
			get_players(players, num, "be", szTeam)
			for(new i;i < num; i++) client_print_color(players[i], 0, nMsg)
		}
		else 
		{
			formatex(nMsg, charsmax(nMsg), "^1*DEAD* [^4%s^1] ^3%s ^1: ^4%s", type, szName, szArg)
			get_players(players, num, "b")
			for(new i;i < num; i++) client_print_color(players[i], 0, nMsg)
		}
	} 
	return PLUGIN_HANDLED
}