if(!has_value('ipcheck.exceptnick') || !is_array(get_value('ipcheck.exceptnick')), store_value('ipcheck.exceptnick', array()))
if(!has_value('ipcheck.exceptip') || !is_array(get_value('ipcheck.exceptip')), store_value('ipcheck.exceptip', array()))
if(!has_value('ipcheck.autocheck'), store_value('ipcheck.autocheck', true))
export('ipcheck.exceptip', get_value('ipcheck.exceptip'))
export('ipcheck.exceptnick', get_value('ipcheck.exceptnick'))
export('ipcheck.autocheck', get_value('ipcheck.autocheck'))

bind(player_login, null, null, @e,
	if(import('ipcheck.autocheck')) {
		@exceptnick = import('ipcheck.exceptnick')
		@exceptip = import('ipcheck.exceptip')
		@closure = closure(@value) {
			return(pinfo(@value, 3) != @e[ip])
		}
		if(!array_every(all_players(), @closure) && !array_contains_ic(@exceptnick, @e[player]) && !array_contains_ic(@exceptip, @e[ip])) {
			modify_event('result', 'KICK_OTHER')
			modify_event('kickmsg', colorize('&c동일한 IP 로 접속한 플레이어가 이미 존재합니다!'))
		}
	}
)
