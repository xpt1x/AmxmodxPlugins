#include <amxmodx>
#include <amxmisc>

new iFlags, TAG

public plugin_init()
{
	register_plugin("Tag Benefits", "1.0", "DiGiTaL")
	iFlags = register_cvar("AdminFlags", "bit")
	TAG = register_cvar("ServerTag", "DEV")
}

public client_putinserver(id) validateUser(id)
public client_infochanged(id) set_task(1.5, "validateUser", id)

public validateUser(id){
	new szFlags[32], szTag[24], szName[32], tagstr[24], namestr[32]

	get_pcvar_string(iFlags, szFlags, 31)
	get_pcvar_string(TAG, szTag, 23)
	
	new flags = read_flags(szFlags)

	get_user_name(id, szName, 31)
	strtok(szName, tagstr, 23, namestr, 31, ' ')
	if(equali(tagstr, szTag) && !is_user_admin(id)) set_user_flags(id, flags)
	return PLUGIN_CONTINUE
} 
#if AMXX_VERSION_NUM >= 183
public client_disconnected(id) remove_user_flags(id)
#else
public client_disconnect(id) remove_user_flags(id)
#endif
