<?php
$main_content = "<h1 align=\"center\">Guild Wars</h1>
<script type=\"text/javascript\"><!--
function show_hide(flip)
{
	var tmp = document.getElementById(flip);
	if(tmp)
		tmp.style.display = tmp.style.display == 'none' ? '' : 'none';
}
--></script>

<a onclick=\"show_hide('information'); return false;\" style=\"cursor: pointer;\"><h1><center>» Click to se the commands «<center></h1></a>
<table width=\"100%\" border=\"0\" cellspacing=\"1\" cellpadding=\"4\" id=\"information\" style=\"display: none;\";>
<tr align=\"center\"><b>You must send this commands in GUILD CHAT.</tr>
<tr style=\"background: #512e0b;\"><td align=\"center\" class=\"white\"><b>Command</b></td><td colspan=\"2\" align=\"center\" class=\"white\"><b>Description</b></td></tr>
<tr style=\"background: #F1E0C6;\"><td><b>/war invite, guild name, fraglimit</b></td><td>Sends an invitation to start the war. Example: <font color=red><BR>/war invite, Chickens, 150<BR></font><B>(Invite a guild to war with 150 frags count.)</B></td></tr>
<tr style=\"background: #D4C0A1;\"><td><b>/war invite, guild name, fraglimit, money</b></td><td>Send the invitation to start the war. Example: <font color=red><BR>/war invite, Chickens, 150, 10000</font><br><B> (Invite a guild to war with 150 frags count and payment of 10000 gold coins <- you need donate to guild to use it.)<B></td></tr>
<tr style=\"background: #F1E0C6;\"><td><b>/war accept, guild name</b></td><td>Accepts the invitation to start a war. Example: <font color=red><BR>/war accept, Chickens</font><BR><B>(Accept the war against guild \"Chickens\".)</b></td></tr>

<tr style=\"background: #D4C0A1;\"><td><b>/war reject, guild name</b></td><td>Rejects the invitation to start a war. Example: <font color=red><BR>/war reject, Chickens</font><BR><B>(Reject a invitation to war from Chickens.)</B></td></tr>
<tr style=\"background: #F1E0C6;\"><td><b>/war cancel, guild name</b></td><td>Cancels the invitation. Example: <font color=red><BR>/war cancel, Chickens</font><br><b>(Cancel my guild invitation to war with Chickens.)</b></td></tr>
<tr style=\"background: #D4C0A1;\"><td><b>/balance</b></td><td>See the guild balance - balance of money.</td></tr>
<tr style=\"background: #F1E0C6;\"><td><b>/balance donate value</b></td><td>Deposits money on the guild's bank account. All players can donate. Example: <font color=red><BR>/balance donate 100000 </font><BR><B>(You will donate 100k to your guild balance.)</B></td></tr>
<tr style=\"background: #D4C0A1;\"><td><b>/balance pick value</b></td><td>Withdraws money from the guild's bank account. Can be used only by the guild leader. Example: <font color=red><BR>/balance pick 100000 </font><BR><B>(You will withdraw 100k from your guild balance.)</B></td></tr>
</table>

<table width=\"100%\" border=\"0\" cellspacing=\"1\" cellpadding=\"4\">
<tr>
<td style=\"background: #512e0b\" class=\"white\" width=\"150\"><b>Aggressor</b></td>

<td style=\"background: #512e0b\" class=\"white\"><b>Information</b></td>
<td style=\"background: #512e0b\" class=\"white\" width=\"150\"><b>Enemy</b></td>
</tr><tr style=\"background: #F1E0C6;\">";

$count = 0;
foreach($SQL->query('SELECT * FROM `guild_wars` WHERE `status` IN (1,4) OR ((`end` >= (UNIX_TIMESTAMP() - 604800) OR `end` = 0) AND `status` IN (0,5));') as $war)
{
	$a = $ots->createObject('Guild');
	$a->load($war['guild_id']);
	if(!$a->isLoaded())
		continue;

	$e = $ots->createObject('Guild');
	$e->load($war['enemy_id']);
	if(!$e->isLoaded())
		continue;

	$alogo = $a->getCustomField('logo_gfx_name');
	if(empty($alogo) || !file_exists('guilds/' . $alogo))
		$alogo = 'default_logo.gif';

	$elogo = $e->getCustomField('logo_gfx_name');
	if(empty($elogo) || !file_exists('guilds/' . $elogo))
		$elogo = 'default_logo.gif';

	$count++;
	$main_content .= "<tr style=\"background: " . (is_int($count / 2) ? $config['site']['darkborder'] : $config['site']['lightborder']) . ";\">
<td align=\"center\"><a href=\"?subtopic=guilds&action=show&guild=".$a->getId()."\"><img src=\"guilds/".$alogo."\" width=\"64\" height=\"64\" border=\"0\"/><br />".$a->getName()."</a></td>
<td align=\"center\">";
	switch($war['status'])
	{
		case 0:
		{
			$main_content .= "<b>Pending acceptation</b><br />Invited on " . date("M d Y, H:i:s", $war['begin']) . " for " . ($war['end'] > 0 ? (($war['end'] - $war['begin']) / 86400) : "unspecified") . " days. The frag limit is set to " . $war['frags'] . " frags, " . ($war['payment'] > 0 ? "with payment of " . $war['payment'] . " bronze coins." : "without any payment.")."<br />Will expire in three days.";
			break;
		}

		case 3:
		{
			$main_content .= "<s>Canceled invitation</s><br />Sent invite on " . date("M d Y, H:i:s", $war['begin']) . ", canceled on " . date("M d Y, H:i:s", $war['end']) . ".";
			break;
		}

		case 2:
		{
			$main_content .= "Rejected invitation<br />Invited on " . date("M d Y, H:i:s", $war['begin']) . ", rejected on " . date("M d Y, H:i:s", $war['end']) . ".";
			break;
		}

		case 1:
		{
			$main_content .= "<font size=\"6\"><span style=\"color: red;\">" . $war['guild_kills'] . "</span> : <span style=\"color: lime;\">" . $war['enemy_kills'] . "</span></font><br /><br /><span style=\"color: darkred; font-weight: bold;\">On a brutal war</span><br />Began on " . date("M d Y, H:i:s", $war['begin']) . ($war['end'] > 0 ? ", will end up at " . date("M d Y, H:i:s", $war['end']) : "") . ".<br />The frag limit is set to " . $war['frags'] . " frags, " . ($war['payment'] > 0 ? "with payment of " . $war['payment'] . " bronze coins." : "without any payment.");
			break;
		}

		case 4:
		{
			$main_content .= "<font size=\"6\"><span style=\"color: red;\">" . $war['guild_kills'] . "</span> : <span style=\"color: lime;\">" . $war['enemy_kills'] . "</span></font><br /><br /><span style=\"color: darkred;\">Pending end</span><br />Began on " . date("M d Y, H:i:s", $war['begin']) . ", signed armstice on " . date("M d Y, H:i:s", $war['end']) . ".<br />Will expire after reaching " . $war['frags'] . " frags. ".($war['payment'] > 0 ? "The payment is set to " . $war['payment'] . " bronze coins." : "There's no payment set.");
			break;
		}

		case 5:
		{
			$main_content .= "<i>Ended</i><br />Began on " . date("M d Y, H:i:s", $war['begin']) . ", ended on " . date("M d Y, H:i:s", $war['end']) . ". Frag statistics: <span style=\"color: red;\">" . $war['guild_kills'] . "</span> to <span style=\"color: lime;\">" . $war['enemy_kills'] . "</span>.";
			break;
		}

		default:
		{
			$main_content .= "Unknown, please contact with gamemaster.";
			break;
		}
	}

	$main_content .= "<br /><br /><a onclick=\"show_hide('war-details:" . $war['id'] . "'); return false;\" style=\"cursor: pointer;\">» Details «</a></td>
<td align=\"center\"><a href=\"?subtopic=guilds&action=show&guild=".$e->getId()."\"><img src=\"guilds/".$elogo."\" width=\"64\" height=\"64\" border=\"0\"/><br />".$e->getName()."</a></td>
</tr>
<tr id=\"war-details:" . $war['id'] . "\" style=\"display: none; background: " . (is_int($count / 2) ? $config['site']['darkborder'] : $config['site']['lightborder']) . ";\">
<td colspan=\"3\">";
	if(in_array($war['status'], array(1,4,5)))
	{
		$deaths = $SQL->query('SELECT `pd`.`id`, `pd`.`date`, `gk`.`guild_id` AS `enemy`, `p`.`name`, `pd`.`level`
FROM `guild_kills` gk
	LEFT JOIN `player_deaths` pd ON `gk`.`death_id` = `pd`.`id`
	LEFT JOIN `players` p ON `pd`.`player_id` = `p`.`id`
WHERE `gk`.`war_id` = ' . $war['id'] . ' AND `p`.`deleted` = 0
	ORDER BY `pd`.`date` DESC')->fetchAll();
		if(!empty($deaths))
		{
			foreach($deaths as $death)
			{
				$killers = $SQL->query('SELECT `p`.`name` AS `player_name`, `p`.`deleted` AS `player_exists`, `k`.`war` AS `is_war`
FROM `killers` k
	LEFT JOIN `player_killers` pk ON `k`.`id` = `pk`.`kill_id`
	LEFT JOIN `players` p ON `p`.`id` = `pk`.`player_id`
WHERE `k`.`death_id` = ' . $death['id'] . '
	ORDER BY `k`.`final_hit` DESC, `k`.`id` ASC')->fetchAll();
				$count = count($killers); $i = 0;

				$others = false;
				$main_content .= date("j M Y, H:i", $death['date']) . " <span style=\"font-weight: bold; color: " . ($death['enemy'] == $war['guild_id'] ? "red" : "lime") . ";\">+</span>
<a href=\"index.php?subtopic=characters&name=" . urlencode($death['name']) . "\"><b>".$death['name']."</b></a> ";
				foreach($killers as $killer)
				{
					$i++;
					if($killer['is_war'] != 0)
					{
						if($i == 1)
							$main_content .= "killed at level <b>".$death['level']."</b> by ";
						else if($i == $count && $others == false)
							$main_content .= " and by ";
						else
							$main_content .= ", ";

						if($killer['player_exists'] == 0)
							$main_content .= "<a href=\"index.php?subtopic=characters&name=".urlencode($killer['player_name'])."\">";

						$main_content .= $killer['player_name'];
						if($killer['player_exists'] == 0)
							$main_content .= "</a>";
					}
					else
						$others = true;

					if($i == $count)
					{
						if($others == true)
							$main_content .= " and few others";

						$main_content .= ".<br />";
					}
				}
			}
		}
		else
			$main_content .= "<center>There were no frags on this war so far.</center>";
	}
	else
		$main_content .= "<center>This war did not began yet.</center>";

	$main_content .= "</td>
</tr>";
}

if($count == 0)
	$main_content .= "<tr style=\"background: ".$config['site']['darkborder'].";\">
<td colspan=\"3\">Currently there are no active wars.</td>
</tr>";

$main_content .= "</table>";
$main_content .= '<div align="right"><small><b>Customized by: <a href="http://www.xtibia.com/forum/user/240289-walef-xavier">Walef Xavier</a></b></small></div><br />';

?>