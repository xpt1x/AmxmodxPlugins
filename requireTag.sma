#include <amxmodx>
#include <amxmisc>

new flags[32], TAG
new bool: removedAccess[33]

public plugin_init()
{
	register_plugin("Require TAG", "1.0", "DiGiTaL")
	TAG = register_cvar("ServerTag", "DEV")
}
public client_putinserver(id) validateUser(id)
public client_infochanged(id) set_task(1.5, "validateUser", id)

public validateUser(id){ 
	new szName[32], tagstr[20], namestr[32], szTag[24]
	get_user_name(id, szName, 31)
	get_pcvar_string(TAG, szTag, 23)
	strtok(szName, tagstr, 19, namestr, 31, ' ')
	if(is_user_admin(id))
	{
		if(equali(tagstr, szTag)) return PLUGIN_CONTINUE
		else
		{
			flags[id] = get_user_flags(id)
			remove_user_flags(id)
			removedAccess[id] = true
		}
	} 
	else if(!is_user_admin(id) && removedAccess[id] && equali(tagstr, szTag)) set_user_flags(id, flags[id])
	return PLUGIN_CONTINUE
}
