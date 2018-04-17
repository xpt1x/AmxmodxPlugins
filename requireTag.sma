#include <amxmodx>
#include <amxmisc>

#define TAG "DEV"

new flags[32], bool: removedAccess

public plugin_init() register_plugin("Require TAG", "2.0", "DiGiTaL")
public client_putinserver(id) set_task(1.0, "validateUser", id)
public client_infochanged(id) set_task(0.1 , "validateUser", id)

public validateUser(id){
	new szName[32]; get_user_name(id, szName, 31)
	if(is_user_admin(id) && containi(szName, TAG) != -1) return PLUGIN_CONTINUE
	else if(is_user_admin(id) && !(containi(szName, TAG) != -1))
	{
		flags[id] = get_user_flags(id)
		remove_user_flags(id)
		removedAccess = true
	} 
	if(!is_user_admin(id) && removedAccess && containi(szName, TAG) != -1 ) set_user_flags(id, flags[id])
	return PLUGIN_CONTINUE
}
