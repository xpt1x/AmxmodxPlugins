#include <amxmodx>
#include <amxmisc>

#define TAG "DEV"

new flags[32], bool: removedAccess[33]

public plugin_init() register_plugin("Require TAG", "1.0", "DiGiTaL")
public client_putinserver(id) validateUser(id)
public client_infochanged(id) validateUser(id)

public validateUser(id){
	new szName[32]; get_user_name(id, szName, 31)
	if(is_user_admin(id)){
		if(containi(szName, TAG) != -1) return PLUGIN_CONTINUE
		else if(!(containi(szName, TAG) != -1))
		{
			flags[id] = get_user_flags(id)
			remove_user_flags(id)
			removedAccess[id] = true
		}
	} 
	else if(!is_user_admin(id) && removedAccess[id] && containi(szName, TAG) != -1 ) set_user_flags(id, flags[id])
	return PLUGIN_CONTINUE
}
