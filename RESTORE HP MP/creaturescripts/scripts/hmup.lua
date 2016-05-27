function onAdvance(cid, skill, oldlevel, newlevel)
		  if skill == SKILL__LEVEL then
		   doCreatureAddHealth(cid, getCreatureMaxHealth(cid))
		doCreatureAddMana(cid, getCreatureMaxMana(cid))
   end
return TRUE
end