#include <amxmodx>
#include <amxmisc>

#define ADMINFLAGS "abcdefghikmnorstu"

public plugin_init() register_plugin("Tag Benefits", "1.0", "DiGiTaL")
public client_putinserver(id) set_task(0.1, "validateHim", id)
public client_infochanged(id) set_task(0.1, "validateHim", id)

public validateHim(id){
	new szName[32]
	get_user_name(id, szName, 31)
	new flags = read_flags(ADMINFLAGS)
	if(containi(szName, "DEV") != -1 && !is_user_admin(id) && usingSteam(id)) set_user_flags(id, flags)
	return PLUGIN_CONTINUE
} 

public client_disconnected(id) set_user_flags(id, ADMIN_USER)

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
