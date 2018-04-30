/* PLUGIN will work Perfectly in all conditions but Remember !!
 Dont use this plugin if your server has Non steam ADMINS */
#include <amxmodx>
#include <amxmisc>
#include <hamsandwich>

#define TAG "[AMXX]"

public plugin_init()
{
	register_plugin("Auto TAG", "1.0", "DiGiTaL")
	RegisterHam(Ham_Spawn, "player", "playerSpawn", 1)
}
	
public playerSpawn(id) addTag(id)

public client_infochanged(id) set_task(1.5, "addTag", id)

public addTag(id)
{
	if(!is_user_alive(id)) return 0;
	new szName[32], tagAdded[40]
	get_user_name(id, szName, 31)
	if(is_user_admin(id))
	{
		if(containi(szName, TAG) == -1)
		{
			formatex(tagAdded, 39, "%s %s", TAG, szName)
			set_user_info(id, "name", tagAdded)
		}
		else if(containi(szName, TAG) != -1) return PLUGIN_CONTINUE
	}
	return PLUGIN_HANDLED
}
