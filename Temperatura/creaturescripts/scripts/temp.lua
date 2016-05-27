function onThink(cid, interval)
if isPlayer(cid) and getPlayerAccess(cid) == 0 then

   
------------------------- CONFIG ----------------------

-- Como configurar: Modifique os numeros abaixo da direita para
-- determinar a temperatura da outfit...
outfit_temp = {
               -- Female Outfits
               [136] = 6,        
               [137] = 5,        
               [138] = 5,        
               [139] = 6,        
               [140] = 7,        
               [141] = 6,        
               [142] = 8,        
               [147] = 11,       
               [148] = 6,        
               [149] = 6,        
               [150] = 8,        
               [155] = 7,        
               [156] = 2,   
               [157] = 20,  
               [158] = 11,   
               [152] = 9,
               [259] = 8,
               [270] = 14,
               [279] = 15,
               [288] = 4,
               [324] = 5,
               [336] = 6,
               [329] = 6,
               [366] = 8,
               -- Male Outfits
               [128] = 6, 
               [129] = 5, 
               [130] = 5,
               [131] = 6,
               [132] = 7,
               [133] = 6,
               [134] = 8,
               [143] = 11,
               [144] = 6,
               [145] = 6,
               [151] = 8,
               [152] = 7,
               [153] = 20,   
               [154] = 14,  
               [251] = 11,   
               [268] = 9,
               [273] = 8,
               [278] = 14,
               [279] = 15,
               [289] = 4,
               [325] = 5,
               [335] = 6,
               [328] = 6,
               [367] = 8,
               }     
               
               
temp_base = 20

min_dano = 15          -- Dano por temperatura um pouco alta/baixa
max_dano = 100         -- Dano por temperatura muito alta/baixa
delay = 2000         -- tempo em milissigundos dos danos

sub_config = 1                   -- Ativar temperatura subterranea? ( 0 - Nao ) ( 1 - SIM )


-----------------------------FIM DAS CONFIG ------------------------

temp_local = getPlayerStorageValue(cid, 121314)
pos = getCreaturePosition(cid)
           

   if temp_local == -1 then temp_local = 0 end
   
   temp_user = (temp_base + temp_local + outfit_temp[getCreatureOutfit(cid).lookType])
   
   if sub_config == 1 then 
   
   ----------------------- Subterraneo -------------------------------
                                                                    
   sub = { -11, -10, -8,-5 ,-3 ,-55 , [7] = 0, 55, 5, 7, 10, 12, 15}  
                                                                    
   if pos.z ~= 7 then                                             
      temp_user = temp_user + sub[pos.z]                                  
   end                                                              
   end                                                                 
   -------------------------------------------------------------------
   
   setPlayerStorageValue(cid, 12345, temp_user)  
   
   
   if temp_user >= 40 and temp_user < 50 then
      addEvent(Quente, delay, cid,min_dano)
   
   elseif temp_user >=50 then
      addEvent(Quente, delay, cid,max_dano)
   
   elseif temp_user <= 10  and temp_user > 0 then
          addEvent(Frio, delay, cid,min_dano)
   elseif temp_user < 0 then
          addEvent(Frio, delay, cid,max_dano)
   end
end   


end

function Quente(cid,dano,r)
doPlayerSendTextMessage(cid, 22, "Voce esta sentindo muito calor...")
doCreatureAddHealth(cid, -dano)
r = math.random(1,100)
if r <= 30 then
doCreateItem(2018, getCreaturePosition(cid))
end
end

function Frio(cid,dano)
doPlayerSendTextMessage(cid, 22, "Voce esta sentindo muito frio...")
doCreatureAddHealth(cid, -dano)
end