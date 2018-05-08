#include <amxmodx>
#include <amxmisc>

#define OWNER(%0) (get_user_flags(%0) & ADMIN_RCON)
#define ADMIN(%0) (get_user_flags(%0) & ADMIN_BAN)
#define VIP(%0) (get_user_flags(%0) & ADMIN_RESERVATION)
#define HIDE_SLASH

public plugin_init()
{
	register_plugin("Lite Chat Prefixes", "1.1", "DiGiTaL")
	register_cvar("litechatpre", "Running", FCVAR_SERVER| FCVAR_SPONLY) 
	register_clcmd("say", "handleSay")
	register_clcmd("say_team", "handleTeamSay")
}

public handleSay(id) return checkMsg(id, false)
public handleTeamSay(id) return checkMsg(id, true)

public checkMsg(id, bool:teamSay)
{
	new type
	static tags[][] = { "", "^1[^4OWNER^1]", "^1[^4ADMIN^1]", "^1[^4VIP^1]" } /* Prefix are here */
	if(OWNER(id)) type = 1
	else if(ADMIN(id)) type = 2
	else if(VIP(id)) type = 3
	else return PLUGIN_CONTINUE
	setMsg(id, tags[type], bool:is_user_alive(id), teamSay)
	return PLUGIN_HANDLED_MAIN
}

stock setMsg(index, type[], bool:is_alive, bool:is_teamSay)
{
	new nMsg[192],szArg[192], szName[32], szTeam[32], players[32], num
	get_user_name(index, szName, charsmax(szName))
	get_user_team(index, szTeam, charsmax(szTeam))

	read_args(szArg, charsmax(szArg))
	remove_quotes(szArg)
	#if defined HIDE_SLASH
	if (!szArg[0] || szArg[0] == '/') return;
	#endif

	if(is_alive)
	{
		if(is_teamSay) {
			formatex(nMsg, charsmax(nMsg), "^1(%s) %s ^3%s ^1: ^4%s", szTeam, type, szName, szArg)
			get_players(players, num, "ae", szTeam)
			for(new i;i < num; i++) client_print_color(players[i], 0, nMsg)
		}
		else {
			formatex(nMsg, charsmax(nMsg), "%s ^3%s ^1: ^4%s", type, szName, szArg)
			client_print_color(0, 0, nMsg)
		}
	} 
	else
	{
		if(is_teamSay) {
			formatex(nMsg, charsmax(nMsg), "^1*DEAD* (%s) %s ^3%s ^1: ^4%s", szTeam, type, szName, szArg)
			get_players(players, num, "be", szTeam)
			for(new i;i < num; i++) client_print_color(players[i], 0, nMsg)
		}
		else {
			formatex(nMsg, charsmax(nMsg), "^1*DEAD* %s ^3%s ^1: ^4%s", type, szName, szArg)
			get_players(players, num, "b")
			for(new i;i < num; i++) client_print_color(players[i], 0, nMsg)
		}
	} 
}
