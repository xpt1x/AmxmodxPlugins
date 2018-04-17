#include <amxmodx>
#include <amxmisc>

#define TAG "DEV"

public plugin_init() register_plugin("Require TAG", "1.0", "DiGiTaL")
public client_putinserver(id) set_task(1.0, "validateUser", id)
public client_infochanged(id) set_task(0.1 , "validateUser", id)

public validateUser(id){
	new szName[32]; get_user_name(id, szName, 31)
	if(is_user_admin(id) && containi(szName, TAG) != -1) return PLUGIN_CONTINUE
	else if(is_user_admin(id) && usingSteam(id) && !(containi(szName, TAG) != -1)) remove_user_flags(id)
	return PLUGIN_CONTINUE
}

stock usingSteam(id)
{
	static dp_pointer;
	if(dp_pointer || (dp_pointer = get_cvar_pointer("dp_r_id_provider")))
	{
		server_cmd("dp_clientinfo %d", id); server_exec();
		return (get_pcvar_num(dp_pointer) == 2) ? true : false;
	}
	return false;
}